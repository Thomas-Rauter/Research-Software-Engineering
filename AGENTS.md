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

This is a writing project, not a code project. Typical tasks are adding or
revising a principle, finding a better title, checking the document for
consistency, and tightening the prose.

## Files

- `latex/NAME.tex` is the source of a document and the source of truth. All
  edits go here, for example to
  `latex/Design_Principles_for_Research_Software.tex`.
- `pdf/NAME.pdf` is built from it and committed. The website serves the PDFs
  from this directory.
- `README.md` is the landing page of the website. For every document it gives
  the title, linked to the PDF, and a short description.
- `Makefile` and `build/Dockerfile` build the PDFs; `build/README.md`
  explains how. `_config.yml` configures the website.

## Structure of the document

- The unnumbered front matter, "About these guidelines", defines the scope,
  the **Ladder of Research Software** (four rungs, with a table), the
  **Normative language**, the two kinds of code (**Library code and
  workflow code**, told apart by the Hollywood principle), **Packages**, and
  the **Terminology**. The formal definitions of library code, workflow
  code, and package stand out in `definitionbox` environments; the
  Terminology entries repeat only their first sentence and link to them.
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
- Cross-reference with `Subsection~\ref{sec:...}`. A subsection that is
  referenced has a `\label{sec:kebab-case}` directly after its heading. Keep
  existing labels stable, and make sure every `\ref` still resolves after an
  edit. The front-matter subsections are unnumbered, so a `\ref` to them
  prints an empty number; refer to them by name instead.
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
  it refers to, for contradictions.

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
