# AGENTS.md

## What this repository is

*Research Software Engineering*, a website of documents written in Quarto
and published on the repository's GitHub Pages. Every document is also
rendered as a PDF that readers can download and keep. The site has three
parts:

- **Principles**: how to design, test, and document research software, in
  any programming language and with any tools. The four documents described
  below.
- **Languages**: how to write research software in one programming language,
  one document per language, such as Python, R, SQL, and Bash. A document
  covers the language and its own tooling: package manager and environments,
  test framework, linters, documentation tools.
- **Tools**: how to use the tools that research software is run, stored,
  tracked, and served with, whatever its language. The documents are
  organized by job, not by tool: containers (Apptainer, Docker), workflow
  managers (Nextflow, Snakemake), HPC scheduling (Slurm), cloud computing
  (AWS), data formats and storage (Parquet, HDF5, Zarr), experiment tracking
  (MLflow), services (FastAPI), and version control and continuous
  integration (Git, GitHub Actions).

The line between the last two: a tool tied to one language, such as uv,
renv, pytest, or testthat, belongs to the document of its language; a tool
that does a job whatever the language belongs to the tools. A tool written
for one language but chosen for its job, such as FastAPI for serving a
model, goes with its job.

The main document is *Design Principles for Research Software*: guidelines
for research software in the broadest sense, in academia and in industry,
from the one-off script of a PhD student to libraries and workflows that a
community or a company relies on. Such software stands on the "Ladder of
Research Software", and the principles are what it takes to climb it. The guidelines are independent of programming language and
scientific field.

Most of the principles are general software engineering principles (KISS,
DRY, stable APIs, no side effects, testing), stated and motivated for the
scientific setting. There, the typical failure is not a crash but a
plausible, wrong number. A smaller set is specific to research software:
numerical stability, conditioning and convergence, units and axis
conventions, missing values, numerical defaults as part of the API,
reproducibility, and traceability of results.

The readers of all documents are research software engineers: first
the author, and possibly colleagues at work. They program and know general
software engineering, so established terms such as coupling, cohesion, or
semantic versioning need no introduction. Spend the words on what the
scientific setting adds, not on the basics. The scope above describes the
software the guidelines cover, not their readers.

The second document, *Testing Research Software*, is about how to test
research software. It stands beside *Design Principles*, not below it: the
two form one set of guidelines, and neither is presented as a companion or
appendix of the other. Its core idea is that a test is only as good as its
oracle, the source of its expected value. It is short and meant for looking
things up while working, not for reading from cover to cover.

The third document, *Documenting Research Software*, is about how to document
research software. It stands beside *Design Principles* as the testing guide
does. Its core idea is that users act on documentation: they choose
parameters by it and copy its description of the method into their papers,
so wrong documentation does the damage of a wrong number, and documentation
stays true only if it lives, changes, and is checked with the code. It is
short and meant for looking things up as well.

The fourth document, *Types of Research Software Tests*, defines the terms of
testing for the whole set: test, test suite, oracle, tolerance, and every
type of test. Its core idea is that every test makes three choices, its
scope (what runs), its inputs (what goes in), and its oracle (what the
result is checked against), and takes one type from each. It describes and
states no rules.

This is a writing project, not a code project. Typical tasks are adding or
revising a principle, finding a better title, checking the document for
consistency, and tightening the prose.

## Files

- `principles/`, `languages/`, and `tools/` hold the documents of the three
  parts, one `.qmd` file each, and the source of truth; `tools/` has a
  folder per job. All edits go here,
  for example to `principles/design.qmd`, `principles/testing.qmd`,
  `principles/documenting.qmd`, or `principles/test-types.qmd`. Figures go
  into `figures/` beside the document, as SVG, which serves the website and
  the PDF alike.
- `index.qmd` in each folder is the overview page of its part, and
  `index.qmd` at the root the landing page. Overview pages set
  `format: html` and `number-sections: false`, so they have no PDF and no
  numbers.
- `_quarto.yml` configures the website, the navigation, and the options of
  the HTML and the PDFs that all documents share.
- `filters/refs.lua` resolves the cross-references and turns the custom
  blocks into LaTeX for the PDFs (see "Cross-references").
- `style/` holds the look: `header.tex` for the PDFs, `site.scss` for the
  website in both color schemes, and `light.scss` and `dark.scss` for the
  colors of each.
- `Makefile`, `build/Dockerfile`, and `.github/workflows/publish.yml` render
  and publish the site; `build/README.md` explains how. `README.md` is the
  README of the repository, not a page of the site.
- `favicon.svg` is the icon of the website.

## Front matter of a document

Every document starts with this YAML:

```yaml
---
title: Testing Research Software
description: >-
  One paragraph that says what the document covers.
order: 2
format:
  html: default
  pdf:
    output-file: Testing_Research_Software
---
```

The `description` appears in the overview page of the part, in the search,
and in the metadata of the page, but not on the page itself, which starts
with its own introduction. `order` sorts the documents of a part in the
sidebar and in the overview page. `output-file` names the PDF after the
title, with underscores. A document that other documents cite under a
shorter name gives it as `short-title`, as *Design Principles* does.

## Structure of the design principles

- The unnumbered front matter, "About these guidelines", defines the scope,
  the **Ladder of Research Software** (four rungs, with a table), the
  **Normative language**, the two kinds of code (**Library code and
  workflow code**, told apart by the Hollywood principle), **Packages**, and
  the **Terminology**. The formal definitions of library code, workflow
  code, and package stand out in `::: {.definitionbox}` blocks; the
  Terminology entries repeat only their first sentence and link to them.
- "At a glance" follows the front matter and starts on a page of its own in
  the PDF: every principle of Parts I to III, grouped by part and section,
  with its number, its title, and a one-line rule. Part IV has no rows,
  because it states no principles. In the PDF, the table breaks across
  pages.
- Three parts group the principles by the kind of code they apply to:
  Part I to all code, Part II only to workflow code, Part III only to library
  code. A principle belongs in Part I unless it makes sense for only one kind
  of code; a Part I principle says how it applies to each kind where they
  differ. Check this before placing a principle in Part II or III.
- Part IV, "Other code forms", is descriptive, not a set of principles. Each
  of its sections covers one common form besides libraries and workflows
  (graphical applications, web applications and services, notebooks,
  simulation codes, plugins) with its advantages and disadvantages compared
  with library and workflow code. These sections have no subsections. The
  rule that the science inside every form should be library code is stated
  once, in the introduction of Part IV; do not repeat it per section.
- Within each part, numbered sections group the principles by theme, for
  example Scope, API design, and Numerical correctness. There are no
  chapters: a part is a level-1 heading with the class `.part`, directly
  above its sections, which are numbered through the parts, as in a LaTeX
  article.
- Each subsection (`##`) is exactly one principle: a memorable title,
  followed by a few paragraphs that state the rule and explain it.

## Structure of the testing guide

- The unnumbered front matter, "About this guide", says what the guide
  covers and what *Design Principles* covers instead. "Normative language and
  the ladder" adopts both from *Design Principles* without restating them,
  and "Terminology" adopts the terms of *Design Principles* and the terms of
  testing from *Types of Research Software Tests*, without defining any.
- "At a glance" follows on a page of its own, as in *Design Principles*:
  every principle with its number, its title, and a one-line rule.
- Three numbered sections, without parts: "Where correctness comes from"
  (the oracles), "Writing tests", and "Keeping tests honest". Each
  subsection is one principle, as in *Design Principles*, but shorter: one
  to three paragraphs.
- The table of oracles for common kinds of code sits in "A test is only as
  good as its oracle". Keep it in step with the oracle principles.
- The guide is prose only: no code examples in any language. Naming tools,
  such as pytest or Hypothesis, is fine.

## Structure of the documentation guide

- The front matter has the same three parts as the testing guide. "About
  this guide" says what the guide covers and what *Design Principles* covers
  instead, and "Normative language and the ladder" adopts both from *Design
  Principles*. "Terminology" adopts the terms of *Design Principles* and of
  the types document, and defines the only terms of its own: the four kinds
  of documentation of Diátaxis, namely tutorial, how-to guide, reference,
  and explanation.
- "At a glance" follows on a page of its own: every principle with its
  number, its title, and a one-line rule.
- Three numbered sections, without parts: "What to document" (the kinds of
  documents and the readers they serve), "Writing documentation", and
  "Keeping documentation true". Each subsection is one principle of one to
  three paragraphs, as in the testing guide.
- The guide is prose only, like the testing guide. Naming tools, such as
  Sphinx, pkgdown, or Zenodo, is fine.

## Structure of the types document

- The unnumbered front matter, "About this document", explains the three
  choices of every test (scope, inputs, oracle), says that each test checks
  one claim and that an entry point is tested by several tests with
  different oracles, and states that the document has no rules. "How to read
  a type" lists the fields, and "Terminology" defines test, test suite,
  oracle, and tolerance for all documents of the set.
- "At a glance" follows on a page of its own: every type with its number,
  its title, and a one-line definition.
- Three numbered sections, "Scope: what runs", "Inputs: what goes in", and
  "Oracle: what the result is checked against". Each subsection is one
  type, titled with its plain name, such as "Unit test" or "Snapshot",
  because readers look types up by name. The oracles start with the three
  that do not show that a result is right: it runs, snapshot, and
  reproducibility.
- Each type is one `::: {.typecard}` block that holds a definition list
  with the fields Definition, Catches, Misses, Cost, Pairs with, Example,
  and See, always all seven and in this order. "Pairs with" names the types
  of the other two sections that work with this one, and those that do not.
  "See" cites the principles that state rules about the type.
- The fourth section, "Tests by name", is a table of common names, such as
  smoke test, regression test, and property-based test, with the scope, the
  inputs, and the oracle that each usually combines and what the name adds.
  A name that stands for a combination of types or for a purpose goes into
  this table, not into a subsection of its own. Activities that are not
  tests of results, such as mutation testing, code coverage, benchmarks, and
  validation, are only pointed to.
- The document describes; it uses no *must*, *should*, *prefer*, or *avoid*.
  Where a type comes with a rule, the rule stays in *Design Principles* or
  the testing guide, and the field "See" cites it.

## The four documents

- *Design Principles*, the testing guide, and the documentation guide form
  one set of guidelines. The two guides use the normative language, the
  ladder, the terminology, and the priorities of *Design Principles*, and
  their *must*s are part of the same floor.
- *Types of Research Software Tests* is the one place where the terms of
  testing are defined: test, test suite, oracle, tolerance, and every type of
  test. The other documents use these terms with that meaning and do not
  define them again; a new term of testing is added there.
- The split: *Design Principles* says *that* code is tested and what the
  software itself must do, including checks the code makes on every run,
  such as validation and assertions. The testing guide says *how* tests are
  written and maintained. "Testing is not optional" and "Test the whole
  workflow on a small dataset" stay in *Design Principles*. Before adding a
  principle about testing, decide by this rule which document it belongs in.
  A sentence that says what someone must or should do belongs in one of
  these two; a sentence that says what a type of test is, catches, or misses
  belongs in the types document.
- The split for documentation: *Design Principles* says what the
  documentation must state because it is part of what the software promises,
  such as the method with its assumptions, defaults, and references, the
  policy for missing values, the complexity, the changelog, and the citation
  metadata. The documentation guide says which documents a package has and
  for which readers, and how they are written and kept true, including that
  their examples run. Running an example is not a test of the result: a rule
  about examples in the documentation belongs in the documentation guide, a
  rule about tests in the testing guide. Before adding a principle about
  documentation, decide by this rule which document it belongs in.
- DRY holds across all four: each rule is stated in one document only, and
  the others cite it.
- The documents cite each other's principles by title, with a link with
  empty text to the heading, such as `[](design.qmd#sec-dry)`, which prints
  *Design Principles*, "DRY: Don't repeat yourself" (see
  "Cross-references"). The title comes from the heading, so renaming a
  principle updates every citation of it. Only a link with a text of its
  own, such as `[Normative language](design.qmd#sec-normative)`, keeps the
  old title: after a renaming, search all documents for it.

## Structure of the languages and the tools

The first documents are `tools/containers/index.qmd` and
`tools/containers/apptainer.qmd`; follow them.

- One document per language in `languages/`, such as
  `languages/python.qmd`. When the first one is added, give
  `languages/index.qmd` the same `listing` as `principles/index.qmd`; an
  empty listing fails the build with a warning, which is why it has none yet.
- In `tools/`, one folder per job, such as `tools/containers/`, with a
  document for the job, `index.qmd`, and one for each tool, such as
  `apptainer.qmd`. The job document compares the tools of the job and states
  the rules that hold for all of them; a tool document states only what is
  specific to its tool and cites the job document for the rest. The PDFs are
  named after the job and the tool, such as `Containers.pdf` and
  `Apptainer.pdf`. `tools/index.qmd` lists the
  jobs and their tools in a table, linked where a document exists; add the
  links when you add a document. The sidebar lists the documents of a folder
  by `order`.
- The documents of the two parts are short and meant for looking things up,
  so "At a glance" follows the front matter without a page break and lists
  only the rules, without rows for sections.
- A document mixes rules and reference. Rules are what a reader must or
  should do, such as that every user-facing function in Python has a
  docstring; they use the normative language of *Design Principles* and
  stand out as numbered subsections with a title, like principles, and
  "At a glance" lists only them. The reference describes what is useful to
  look up while working, such as the syntax of common operations, the
  commands of a tool, or a configuration, and states no rules.
- A rule that applies a principle to the language or the tool cites it
  instead of restating it (DRY across the parts): the principle says what
  and why, the rule says how in this language or with this tool. Only a rule
  with no general principle behind it, such as "no mutable default
  arguments" in Python, stands on its own. Before writing a rule, check
  whether it is the concrete form of a principle; if a rule would hold in
  every language, it may belong in *Design Principles* instead.
- Code examples are welcome here, unlike in the testing and documentation
  guides, as fenced code blocks with the language named, so that they are
  highlighted and can be copied. For a language the highlighter does not
  know, such as an Apptainer definition file, name it `default`: without a
  language, a block gets no copy button. Keep lines of code within about 80
  columns, or they run past the margin of the PDF.
- Tools change faster than principles and languages, so each tool document
  states the versions of the tools it was last checked against, and each
  language document the version of the language.

## Writing a principle

### Title

Readers remember a principle by its title, so the title matters as much as
the text. It should be short and either witty or plainly clear, ideally
both. The existing titles follow these patterns:

- An idiom or proverb, bent to the point: "Code is for life, not just for
  Christmas", "Don't call us, we'll call you", "Do what it says on the tin",
  "Flaky tests cry wolf", "Garbage in, useful error out".
- An established name, with its expansion: "KISS: Keep it simple, stupid",
  "DRY: Don't repeat yourself".
- A plain rule: "No magic numbers", "Don't guess", "Compare floats with
  tolerance".
- A contrast: "Build the right thing before building the thing right",
  "Document the method, not the implementation".

Prefer established principles to reinventing them. When an established
software engineering principle covers the idea, build the principle around it
and use its established name as the title, with the expansion of an acronym:
readers may already know it and can look it up. Use the name only for the
idea it stands for; a principle that merely resembles an established one gets
a title of its own. Check for an established name before proposing other
titles.

A reader who remembers only the title should be able to recall what the
principle demands. A clear title beats a clever one that needs explaining.
When proposing a title, offer several options.

### Body

- State the rule in the first sentence or two. Then explain why it matters,
  and then give the details, exceptions, and how to comply.
- Write prose, a few short paragraphs. Use `**...**` lead-ins or lists
  only when a principle has distinct parts.
- Explain the reasoning well enough that a reader can apply the principle to
  a case the text does not mention.
- Illustrate general principles with scientific examples, such as
  tolerances, units, sparse or lazy arrays, random seeds, and published
  results, not with business software examples.
- In the principles, stay neutral about language and field. When a concrete
  example helps, give it for more than one ecosystem where practical, for
  example `set.seed` in R and `numpy.random.seed` in Python. The languages
  and the tools are where the specifics go.
- Use American spelling ("behavior", "optimization").

### Normative language and terminology

- Use the words defined under "Normative language" with exactly that
  meaning. **must / must not** is a requirement, and a violation is a defect.
  **should / should not** is a strong default, and a deviation needs a stated
  reason. **may** means permitted. "Prefer" and "avoid" carry the weight of
  *should*. Choose these words deliberately, because changing a *should* to a
  *must* changes the rule.
- Use the terms defined under "Terminology" consistently: *package*, *library
  code*, *workflow code*, *host stack*, *entry point*, *user-facing function*,
  *caller*. Do not introduce synonyms for concepts that already have a term.
  If a new concept comes up repeatedly, add it to Terminology. A *package* is
  what is shipped, not a synonym for a library. Avoid calling the two kinds
  of code "roles", because "the role of the software" in "Pay as you grow"
  means something else.
- Use the terms of testing as *Types of Research Software Tests* defines
  them, such as *oracle*, *unit test*, and *snapshot test*.

### Consistency across the document

- The document follows its own DRY principle. Each idea is stated in one
  place, and other principles refer to it instead of restating it. Before
  adding a principle, check whether an existing one already covers it;
  extending that one or referring to it is often better.
- Cross-reference with `@sec-...`, which prints "Subsection 3.2" (see
  "Cross-references"). Every section and subsection has an identifier
  `{#sec-kebab-case}` in its heading, because "At a glance" refers to all of
  them; give a new one an identifier too. Keep existing identifiers stable,
  because other documents link to them; a reference that does not resolve
  fails the build. The front-matter subsections are unnumbered, so refer to
  them by title, with `[](#sec-ladder)`.
- All four documents have an "At a glance" table, in a `::: {.glance}`
  block. Each row takes the number and the title of its principle or type
  from the identifier: `| [-@sec-dry] | [](#sec-dry) | One-line rule. |`.
  The rows of parts and sections are bold and leave the last cell empty:
  `| **@part-general** | **[](#part-general)** | |` and
  `| **[-@sec-scope]** | **[](#sec-scope)** | |`. The one-line rule, or in
  the types document the one-line definition, is written by hand: when you
  add, move, or change a principle or a type, add or update its row, and
  keep the rule true to the principle, including its *must* or *should*.
- The ranking in "Get your priorities right" (correctness, clarity,
  testability, maintainability, performance, features) resolves conflicts
  between principles. When a principle conflicts with another, say which one
  wins and cite the ranking.
- The Ladder of Research Software (front matter) places software on one of
  four rungs: personal, shared, released, infrastructure. The first rung is
  in scope but requires nothing; the *must* rules are the floor from the
  second rung on, and everything above them rises with the rung. "Pay as you
  grow" is the principle of climbing it; keep the definition of the rungs in
  the ladder subsection only. New *must* rules
  should be cheap and should prevent wrong results, because they bind every
  piece of software that anyone besides its author uses.
- After editing a principle, check the principles that refer to it, or that
  it refers to, for contradictions, including citations in the other
  documents.

## Cross-references

Quarto numbers the sections and subsections; `filters/refs.lua` adds what
Quarto lacks. The forms, from the most common:

| Write | Prints | Use |
|---|---|---|
| `@sec-dry` | Subsection 3.2 | A reference in the text; the word follows the level of the heading |
| `[-@sec-dry]` | 3.2 | A number alone, as in "Subsections [-@sec-a] and [-@sec-b]" and in tables |
| `@part-library`, `[-@part-library]` | Part III, III | A part |
| `[](#sec-dry)` | DRY: Don't repeat yourself | The title of a heading, like `\nameref`; also for unnumbered headings |
| `[](design.qmd#sec-dry)` | *Design Principles*, "DRY: Don't repeat yourself" | A principle of another document |
| `[](design.qmd)` | *Design Principles for Research Software* | Another document |
| `[text](design.qmd#sec-dry)` | text | A link with its own text, which is kept |
| `@tbl-ladder`, `@fig-layered-api` | Table 1, Figure 1 | A table or a figure, by Quarto |

Paths are relative to the document, for example
`[](../principles/design.qmd#sec-dry)` from `languages/python.qmd`. A
reference to a heading or a page that does not exist stops the build, and so
does `@sec-...` for an unnumbered heading. In the PDF, links to other
documents point to the website.

Headings carry their identifier and classes: `# Scope {#sec-scope}`,
`## Normative language {#sec-normative .unnumbered}`, and for a part
`# Library code {#part-library .part}`.

## Working on the sources

- Write Quarto Markdown. Two custom blocks have a look of their own in the
  HTML and the PDF: `::: {.definitionbox}` and `::: {.typecard}`; the
  filter turns them into the LaTeX environments of `style/header.tex`.
  `{{< pagebreak >}}` starts a new page in the PDF.
- Match the source formatting: lines hard-wrapped at about 80 columns, except
  the rows of tables, which Markdown keeps on one line, and two blank lines
  before each heading.
- Put the width of the columns of a table into its separator line: pandoc
  divides the width in proportion to the dashes, for example
  `|-----|------------------------------|----------------------------------------------------|`.
- Build with `make site`, or watch the website with `make preview` while
  writing. Both run Quarto in a Docker container. `make site` fails on a
  reference that does not resolve and on any warning of Quarto. Neither the
  site nor the PDFs are committed: the GitHub Action renders and publishes
  them on every push to `main`.
- A new document needs no entry anywhere else: the sidebar and the overview
  page of its part list it by its front matter.

## Collaboration

- Keep the author's voice. Prefer targeted edits to rewriting whole
  passages.
- Point out overlaps, contradictions, and weak arguments when you notice
  them, but do not fix them without being asked.
- Never stage, commit, or push, not even when a task seems to call for it;
  the author does that. End every task that changes files with a recommended
  commit message, a header line and a body, in the style of the existing
  commits.
