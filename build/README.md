# Building the website

The website and its PDFs are rendered from the Quarto documents with Quarto,
inside a Docker container, so the result does not depend on the Quarto or TeX
installation of the machine. Run all commands from the repository root.

```sh
make site      # render the website and every PDF into _site/
make preview   # serve the website at http://localhost:4200, live
make clean     # remove _site/ and Quarto's cache
```

`make site` renders every page to HTML and every document to PDF as well. It
works on a copy of the sources inside the container, so intermediate files,
such as the LaTeX of a PDF, never reach the repository, and it copies the
site to `_site/` only if the render succeeds without a warning. A reference
to a heading or a page that does not exist stops the render (see
`filters/refs.lua`), and a cross-reference that Quarto cannot resolve gives a
warning, which fails the build too.

`make preview` renders the HTML only and renders it again whenever a source
changes; open the address it prints. Stop it with Ctrl+C.

## Publishing

`.github/workflows/publish.yml` runs `make site` on every push to `main` and
publishes `_site/` on GitHub Pages; it can also be started by hand from the
Actions tab. In the settings of the repository, Pages > Source must be set to
"GitHub Actions". Neither `_site/` nor the PDFs are committed.

## The image

The first `make site` or `make preview` builds the image `rse-site` from
`build/Dockerfile`: TeX Live, pinned to a frozen yearly release, and Quarto,
pinned to a version (about 6 GB on disk, downloaded once). The image lives in
Docker's local storage, not in this repository; `build/` only holds the
Dockerfile. After editing the Dockerfile, rebuild with `make image`. To free
the disk space, run `docker image rm rse-site`.

## Adding a document

1. Put the source in the folder of its part, for example
   `languages/python.qmd`, with a `title`, a `description`, an `order`, and the
   name of its PDF (see AGENTS.md).
2. Run `make site`, or `make preview` while writing.
3. Commit the source. The sidebar and the overview page of the part list the
   new document by themselves.
