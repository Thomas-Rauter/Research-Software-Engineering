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

- `latex/NAME.tex` is the source of a document and the source of truth. All
  edits go here, for example to
  `latex/Design_Principles_for_Research_Software.tex`,
  `latex/Testing_Research_Software.tex`,
  `latex/Documenting_Research_Software.tex`, or
  `latex/Types_of_Research_Software_Tests.tex`.
- `pdf/NAME.pdf` is built from it and committed. The website serves the PDFs
  from this directory.
- `README.md` is the landing page of the website. For every document it gives
  the title, linked to the PDF, and a short description.
- `Makefile` and `build/Dockerfile` build the PDFs; `build/README.md`
  explains how. `_config.yml` configures the website.
- `favicon.svg` is the icon of the website, and `_includes/head-custom.html`
  links it into every page.

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
  and "Terminology" adopts the terms of *Design Principles* and the terms of
  testing from *Types of Research Software Tests*, without defining any.
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
- Three numbered `\section`s, without `\part`s: "What to document" (the
  kinds of documents and the readers they serve), "Writing documentation",
  and "Keeping documentation true". Each `\subsection` is one principle of
  one to three paragraphs, as in the testing guide.
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
  "Oracle: what the result is checked against". Each `\subsection` is one
  type, titled with its plain name, such as "Unit test" or "Snapshot",
  because readers look types up by name. The oracles start with the three
  that do not show that a result is right: it runs, snapshot, and
  reproducibility.
- Each type is one `typecard` environment with the fields `\Definition`,
  `\Catches`, `\Misses`, `\Cost`, `\PairsWith`, `\Example`, and `\See`,
  always all seven and in this order. "Pairs with" names the types of the
  other two sections that work with this one, and those that do not. "See"
  cites the principles that state rules about the type.
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
- A `\ref` cannot reach into another PDF, so the documents cite each other's
  principles by title, with macros defined in the customization zone:
  `\DesignRef{Title}`, `\TestingRef{Title}`, `\DocumentingRef{Title}`, and
  `\TypesRef{Title}`. Each document defines those it uses. The title is the
  reference, so renaming a principle means searching the other documents for
  the old title and updating it.

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
- Use the terms of testing as *Types of Research Software Tests* defines
  them, such as *oracle*, *unit test*, and *snapshot test*.

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
- All four documents have an "At a glance" table. Its rows take the number
  and the title of each principle or type from its label (`\ref`,
  `\nameref`), and the macros `\GlancePart` and `\GlanceSection` write the
  header rows. The one-line rule, or in the types document the one-line
  definition, is written by hand: when you add, move, or change a principle
  or a type, add or update its row, and keep the rule true to the principle,
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
  documents.

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
  references. The rebuilt PDF belongs in the same commit as the `.tex`, so
  that the two stay in sync.
- A new document also needs an entry in `README.md`: the title, linked to
  the PDF, and a short description. `make check` verifies that every document
  has a PDF and an entry.

## Collaboration

- Keep the author's voice. Prefer targeted edits to rewriting whole
  passages.
- Point out overlaps, contradictions, and weak arguments when you notice
  them, but do not fix them without being asked.
- Never stage, commit, or push, not even when a task seems to call for it;
  the author does that. End every task that changes files with a recommended
  commit message, a header line and a body, in the style of the existing
  commits.
