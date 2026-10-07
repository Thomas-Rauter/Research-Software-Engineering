-- Cross-references between headings and pages, and the LaTeX side of the
-- custom blocks. AGENTS.md, "Cross-references", explains the syntax.
--
-- Parts. A level-1 heading with the class .part is a part. It is numbered
-- I, II, ... and shown as "Part I" before its title; in the PDF it becomes
-- \part. Quarto does not number it, so the sections are numbered through
-- the parts, as in a LaTeX article.
--
-- Numbers. @sec-id prints the word for the level of the heading and its
-- number, such as "Subsection 3.2"; [-@sec-id] prints only the number.
-- Quarto supplies the numbers. @part-id prints "Part I", [-@part-id] "I".
--
-- Titles. A link with empty text to a heading, [](#sec-id), prints the title
-- of the heading, like \nameref. A link with empty text to a heading on
-- another page, [](design.qmd#sec-id), prints the short title of that page
-- and the title of the heading: Design Principles, "Title". A link with empty
-- text to a page, [](design.qmd), prints the title of the page. A link with
-- text keeps it.
--
-- Checks. A reference to a heading or a page that does not exist stops the
-- render, and so does @sec-id for an unnumbered heading.
--
-- PDF. Links to other pages point to the website, and a div with the class
-- definitionbox or typecard becomes the LaTeX environment of that name,
-- which style/header.tex defines.

local LEVEL_WORDS = { "Section", "Subsection", "Subsubsection" }
local LATEX_ENVIRONMENTS = { definitionbox = true, typecard = true }
local NBSP = "\u{00A0}"

local is_latex, input_dir, headings, site_url
local pages = {}

local function fail(message)
  error("filters/refs.lua: " .. message .. " (in " .. quarto.doc.input_file .. ")")
end

local function roman(n)
  local numerals = { { 10, "X" }, { 9, "IX" }, { 5, "V" }, { 4, "IV" }, { 1, "I" } }
  local result = ""
  for _, pair in ipairs(numerals) do
    while n >= pair[1] do
      result = result .. pair[2]
      n = n - pair[1]
    end
  end
  return result
end

-- Every heading with an identifier: its level, its title, whether Quarto
-- numbers it, and the number of a part.
local function collect_headings(blocks)
  local found, parts = {}, 0
  blocks:walk({
    Header = function(h)
      if h.identifier == "" then return end
      local entry = {
        level = h.level,
        title = h.content,
        numbered = not h.classes:includes("unnumbered"),
      }
      if h.classes:includes("part") then
        parts = parts + 1
        entry.part = roman(parts)
        entry.numbered = false
      end
      found[h.identifier] = entry
    end,
  })
  return found
end

-- Resolve "." and ".." in a path, so that it can be compared and made
-- relative to the project.
local function clean_path(path)
  local parts = {}
  for part in path:gmatch("[^/]+") do
    if part == ".." then
      table.remove(parts)
    elseif part ~= "." then
      table.insert(parts, part)
    end
  end
  return (path:sub(1, 1) == "/" and "/" or "") .. table.concat(parts, "/")
end

local function read_page(path)
  if pages[path] == nil then
    local file = io.open(path, "r")
    if not file then return nil end
    local doc = pandoc.read(file:read("a"), "markdown")
    file:close()
    pages[path] = { meta = doc.meta, headings = collect_headings(doc.blocks) }
  end
  return pages[path]
end

-- The site-url of _quarto.yml. Quarto does not pass the website options to
-- filters, so read them from the file.
local function read_site_url()
  local file = io.open(pandoc.path.join({ quarto.project.directory, "_quarto.yml" }), "r")
  local meta = pandoc.read("---\n" .. file:read("a") .. "\n---\n", "markdown").meta
  file:close()
  local url = pandoc.utils.stringify(meta.website["site-url"])
  return url:match("/$") and url or url .. "/"
end

local function link_to_heading(link)
  local id = link.target:match("^#(.+)$")
  if not id then return nil end
  local heading = headings[id]
  if not heading then
    if id:match("^sec%-") or id:match("^part%-") then fail("no heading #" .. id) end
    return nil
  end
  if #link.content == 0 then link.content = heading.title:clone() end
  return link
end

local function link_to_page(link)
  local file, id = link.target:match("^([^#:]+%.qmd)#?(.*)$")
  if not file then return nil end
  local path = clean_path(pandoc.path.join({ input_dir, file }))
  local page = read_page(path)
  if not page then fail("no page " .. file) end
  local heading = id ~= "" and page.headings[id]
  if id ~= "" and not heading then fail("no heading #" .. id .. " on page " .. file) end
  if is_latex then
    local relative = pandoc.path.make_relative(path, quarto.project.directory)
    link.target = site_url .. relative:gsub("%.qmd$", ".html") .. (heading and "#" .. id or "")
  end
  if #link.content > 0 then return link end
  if not heading then
    link.content = { pandoc.Emph(pandoc.Inlines(page.meta.title)) }
    return link
  end
  link.content = heading.title:clone()
  local short = page.meta["short-title"] or page.meta.title
  return {
    pandoc.Emph(pandoc.Inlines(short)), pandoc.Str(","), pandoc.Space(),
    pandoc.Quoted("DoubleQuote", { link }),
  }
end

local function cite(c)
  if #c.citations ~= 1 then return nil end
  local citation = c.citations[1]
  local id = citation.id
  if id:match("^part%-") then
    local heading = headings[id]
    if not heading or not heading.part then fail("no part @" .. id) end
    local text = heading.part
    if citation.mode ~= "SuppressAuthor" then text = "Part" .. NBSP .. text end
    return pandoc.Link(text, "#" .. id)
  end
  if id:match("^sec%-") then
    local heading = headings[id]
    if not heading then fail("no heading @" .. id) end
    if not heading.numbered then
      fail("@" .. id .. " has no number; link it by its title with [](#" .. id .. ")")
    end
    if citation.mode == "SuppressAuthor" then return nil end
    citation.mode = "SuppressAuthor"
    return { pandoc.Str(LEVEL_WORDS[heading.level] .. NBSP), c }
  end
  return nil
end

local function part(h)
  if not h.classes:includes("part") then return nil end
  if is_latex then
    local title = pandoc.write(pandoc.Pandoc({ pandoc.Plain(h.content) }), "latex")
    return pandoc.RawBlock("latex", "\\part{" .. title .. "}\\label{" .. h.identifier .. "}")
  end
  h.classes:insert("unnumbered")
  local number = pandoc.Span("Part" .. NBSP .. headings[h.identifier].part,
    { class = "part-number" })
  h.content = pandoc.Inlines({ number, pandoc.Space() }) .. h.content
  return h
end

local function environment(div)
  if not is_latex then return nil end
  for _, class in ipairs(div.classes) do
    if LATEX_ENVIRONMENTS[class] then
      local blocks = pandoc.Blocks({ pandoc.RawBlock("latex", "\\begin{" .. class .. "}") })
      blocks:extend(div.content)
      blocks:insert(pandoc.RawBlock("latex", "\\end{" .. class .. "}"))
      return blocks
    end
  end
  return nil
end

function Pandoc(doc)
  is_latex = quarto.doc.is_format("latex")
  input_dir = pandoc.path.directory(quarto.doc.input_file)
  headings = collect_headings(doc.blocks)
  site_url = read_site_url()
  return doc:walk({
    Header = part,
    Div = environment,
    Cite = cite,
    Link = function(link) return link_to_heading(link) or link_to_page(link) end,
  })
end
