# Research Software Engineering

Notes on research software engineering, published as a website with a PDF of
every document:
<https://thomas-rauter.github.io/Research-Software-Engineering/>

The site has three parts:

- **Principles**: how to design, test, and document research software, in any
  programming language and with any tools.
- **Languages**: one document per programming language, such as Python, R,
  SQL, and Bash.
- **Tools**: the tools that research software is run, stored, tracked, and
  served with, organized by job.

The sources are Quarto documents. `make site` renders the website and the
PDFs into `_site/`, and a GitHub Action publishes them on every push to
`main`. [build/README.md](build/README.md) explains the build, and
[AGENTS.md](AGENTS.md) the structure and the conventions of the documents.
