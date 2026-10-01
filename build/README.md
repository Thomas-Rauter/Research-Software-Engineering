# Building the PDFs

The PDFs in `pdf/` are built from the LaTeX sources in `latex/` inside a
Docker container, so the result does not depend on the TeX installation of
the machine. Run all commands from the repository root.

```sh
make pdf Design_Principles_for_Scientific_Software   # one document
make pdf                                             # every document
make check                                           # PDFs and README entries complete?
```

`make pdf NAME` compiles `latex/NAME.tex` with latexmk and writes
`pdf/NAME.pdf`. Undefined references fail the build. Auxiliary files stay in
the container, which is removed after each run, so the repository only ever
receives the PDF. The engine defaults to pdflatex; pass `ENGINE=-lualatex` or
`ENGINE=-xelatex` to use another.

## The image

The first `make pdf` builds the image `latex-pdf` from `build/Dockerfile`
(full TeX Live, about 5.5 GB on disk, downloaded once). The image lives in
Docker's local storage, not in this repository; `build/` only holds the
Dockerfile. After editing the Dockerfile, rebuild with `make image`. To free
the disk space, run `docker image rm latex-pdf`.

## Adding a document

1. Put the source in `latex/NAME.tex`.
2. Run `make pdf NAME`.
3. Add an entry to `README.md`: the title, linked to `pdf/NAME.pdf`, and a
   short description.
4. Run `make check`, then commit the `.tex`, the PDF, and `README.md`
   together.

After a push, GitHub Pages rebuilds the website from `README.md` and `pdf/`.
