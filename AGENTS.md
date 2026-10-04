# AGENTS.md

## What this repository is

A collection of LaTeX documents, each built into a PDF and published on the
repository's GitHub Pages website.

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

The second document, *Testing Research Software*, is about how to test
research software. It stands beside *Design Principles*, not below it: the
two form one set of guidelines, and neither is presented as a companion or
appendix of the other. Its core idea is that a test is only as good as its
oracle, the source of its expected value. It is short and meant for looking
things up while working, not for reading from cover to cover.

This is a writing project, not a code project. Typical tasks are adding or
revising a principle, finding a better title, checking the document for
consistency, and tightening the prose.

## Files

- `latex/NAME.tex` is the source of a document and the source of truth. All
  edits go here, for example to
  `latex/Design_Principles_for_Research_Software.tex` or
  `latex/Testing_Research_Software.tex`.
- `pdf/NAME.pdf` is built from it and committed. The website serves the PDFs
  from this directory.
- `README.md` is the landing page of the website. For every document it gives
  the title, linked to the PDF, and a short description.
- `Makefile` and `build/Dockerfile` build the PDFs; `build/README.md`
  explains how. `_config.yml` configures the website.

## Structure of the design principles

- The unnumbered front matter, "About these guidelines", defines the scope,
  the **Ladder of Research Software** (four rungs, with a table), the
  **Normative language**, the two kinds of code (**Library code and
  workflow code**, told apart by the Hollywood principle), **Packages**, and
  the **Terminology**. The formal definitions of library code, workflow
  code, and package stand out in `definitionbox` environments; the
  Terminology entries repeat only their first sentence and link to them.
- "At a glance" follows the front matter and starts on a page of its own:
  every principle of Parts I to III, grouped by part and section, with its
  number, its title, and a one-line rule. Part IV has no rows, because it
  states no principles. The table is an `xltabular`, so it breaks across
  pages.
- Three `\part`s group the principles by the kind of code they apply to:
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
  example Scope, API design, and Numerical correctness. The document class
  is `article`, so there are no chapters: a part is directly above a section.
- Each `\subsection` is exactly one principle: a memorable title, followed by
  a few paragraphs that state the rule and explain it.

## Structure of the testing guide

- The unnumbered front matter, "About this guide", says what the guide
  covers and what *Design Principles* covers instead. "Normative language and
  the ladder" adopts both from *Design Principles* without restating them,
  and "Terminology" defines only the terms of testing (oracle, tolerance,
  snapshot test, and so on); the other terms are used as defined in *Design
  Principles*.
- "At a glance" follows on a page of its own, as in *Design Principles*:
  every principle with its number, its title, and a one-line rule.
- Three numbered `\section`s, without `\part`s: "Where correctness comes
  from" (the oracles), "Writing tests", and "Keeping tests honest". Each
  `\subsection` is one principle, as in *Design Principles*, but shorter: one
  to three paragraphs.
- The table of oracles for common kinds of code sits in "A test is only as
  good as its oracle". Keep it in step with the oracle principles.
- The guide is prose only: no code examples in any language. Naming tools,
  such as pytest or Hypothesis, is fine.

## The two documents

- They form one set of guidelines. The testing guide uses the normative
  language, the ladder, the terminology, and the priorities of *Design
  Principles*, and its *must*s are part of the same floor.
- The split: *Design Principles* says *that* code is tested and what the
  software itself must do, including checks the code makes on every run,
  such as validation and assertions. The testing guide says *how* tests are
  written and maintained. "Testing is not optional" and "Test the whole
  workflow on a small dataset" stay in *Design Principles*. Before adding a
  principle about testing, decide by this rule which document it belongs in.
- DRY holds across both: each rule is stated in one document only, and the
  other cites it.
- A `\ref` cannot reach into the other PDF, so the documents cite each
  other's principles by title: `\TestingRef{Title}` in *Design Principles*
  and `\DesignRef{Title}` in the testing guide, defined in the customization
  zone. The title is the reference, so renaming a principle means searching
  the other document for the old title and updating it.

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

A reader who remembers only the title should be able to recall what the
principle demands. A clear title beats a clever one that needs explaining.
When proposing a title, offer several options.

### Body

- State the rule in the first sentence or two. Then explain why it matters,
  and then give the details, exceptions, and how to comply.
- Write prose, a few short paragraphs. Use `\textbf{...}` lead-ins or lists
  only when a principle has distinct parts.
- Explain the reasoning well enough that a reader can apply the principle to
  a case the text does not mention.
- Illustrate general principles with scientific examples, such as
  tolerances, units, sparse or lazy arrays, random seeds, and published
  results, not with business software examples.
- Stay neutral about language and field. When a concrete example helps, give
  it for more than one ecosystem where practical, for example `set.seed` in R
  and `numpy.random.seed` in Python.
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

### Consistency across the document

- The document follows its own DRY principle. Each idea is stated in one
  place, and other principles refer to it instead of restating it. Before
  adding a principle, check whether an existing one already covers it;
  extending that one or referring to it is often better.
- Cross-reference with `Subsection~\ref{sec:...}`. Every section and
  subsection has a `\label{sec:kebab-case}` directly after its heading,
  because "At a glance" refers to all of them; give a new one a label too.
  Keep existing labels stable, and make sure every `\ref` still resolves after an
  edit. The front-matter subsections are unnumbered, so a `\ref` to them
  prints an empty number; refer to them by name instead.
- Both documents have an "At a glance" table. Its rows take the number and
  the title of each principle from its label (`\ref`, `\nameref`), and the
  macros `\GlancePart` and `\GlanceSection` write the header rows. The
  one-line rule is written by hand: when you add, move, or change a
  principle, add or update its row, and keep the rule true to the principle,
  including its *must* or *should*.
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
  document.

## Working on the LaTeX

- Do not edit the block marked `STANDARDIZED PREAMBLE (STATIC CORE) — DO NOT
  EDIT THIS PART`. Packages and settings specific to this document go in the
  `CUSTOMIZATION ZONE`.
- Match the source formatting: lines hard-wrapped at about 80 columns, blank
  lines between subsections, and `% ====` banner comments around each
  `\section`.
- Build with `make pdf Design_Principles_for_Research_Software`. It runs
  latexmk in a Docker container and writes only the PDF to `pdf/`; the
  auxiliary files stay in the container. The build fails on undefined
  references. Commit the rebuilt PDF together with the `.tex` so the two stay
  in sync.
- A new document also needs an entry in `README.md`: the title, linked to
  the PDF, and a short description. `make check` verifies that every document
  has a PDF and an entry.

## Collaboration

- Keep the author's voice. Prefer targeted edits to rewriting whole
  passages.
- Point out overlaps, contradictions, and weak arguments when you notice
  them, but do not fix them without being asked.
