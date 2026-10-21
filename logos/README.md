# Logos

The logos of the languages and the tools. Each is one SVG, named like the
document it belongs to: `python.svg` for `languages/python.qmd`, `docker.svg`
for `tools/containers/docker.qmd`. The document names it in its front matter,
for example `image: ../../logos/docker.svg`, and then

- the website shows it beside the title of the page, on the card of the
  language in `languages/index.qmd`, and after the link to the tool in the
  table of `tools/index.qmd`;
- the PDF shows it beside the title.

`filters/refs.lua` and `style/site.scss` do this, so nothing but the SVG and
the `image` line is needed. A document of a job, such as `containers/index.qmd`,
is not one tool and has no logo.

## Adding a logo

1. Take the symbol of the language or the tool, without its name where there
   is a separate symbol, in the colors of its brand, about square, as SVG
   without embedded raster images. A language without a logo of its own gets
   a generic symbol, as SQL does.
2. Name the file like the document, and add a row to the table below with its
   source, its license, and what was changed.
3. Add `image:` to the front matter of the document and, for a tool, the logo
   after its link in `tools/index.qmd`:
   `[Docker](containers/docker.qmd) ![](../logos/docker.svg){.logo}`.

On a dark page, the logos stand on a white chip, because some are dark.

The PDFs of the logos, `logos/*.pdf`, are made by the filter for the PDFs
of the documents, because LaTeX cannot read SVG. They are not committed.

## Sources

A logo is a trademark of its owner, and is shown here only to name the
language or the tool that a document is about. The license in the table is the
one of the file, not of the trademark.

| File | Source | License of the file | Changes |
|------------------|--------------------------------------------|------------------|----------------------------|
| `python.svg` | Simple Icons 16.35.0, `python` | CC0 1.0 | Fill set to the brand color `#3776AB` |
| `r.svg` | Simple Icons 16.35.0, `r` | CC0 1.0 | Fill `#276DC3` |
| `bash.svg` | Simple Icons 16.35.0, `gnubash` | CC0 1.0 | Fill `#4EAA25` |
| `sql.svg` | Lucide 1.60.0, `database`; SQL has no logo of its own | ISC | Stroke `#4B6584` instead of `currentColor` |
| `apptainer.svg` | `docs/logos/apptainer_v3.svg` in github.com/apptainer/apptainer | See the repository | None |
| `aws.svg` | Simple Icons 14.0.0, `amazonwebservices`; later versions do not have it | CC0 1.0 | Fill `#232F3E` |
| `docker.svg` | Simple Icons 16.35.0, `docker` | CC0 1.0 | Fill `#2496ED` |
| `fastapi.svg` | Simple Icons 16.35.0, `fastapi` | CC0 1.0 | Fill `#009688` |
| `git.svg` | Simple Icons 16.35.0, `git` | CC0 1.0 | Fill `#F03C2E` |
| `github-actions.svg` | Simple Icons 16.35.0, `githubactions` | CC0 1.0 | Fill `#2088FF` |
| `hdf5.svg` | Wikimedia Commons, `File:HDF logo.svg` (the logo of The HDF Group, traced) | Public domain, as stated there | None |
| `mlflow.svg` | Simple Icons 16.35.0, `mlflow` | CC0 1.0 | Fill `#0194E2` |
| `nextflow.svg` | Simple Icons 16.35.0, `nextflow` | CC0 1.0 | Fill `#0DC09D` |
| `parquet.svg` | Simple Icons 16.35.0, `apacheparquet` | CC0 1.0 | Fill `#50ABF1` |
| `slurm.svg` | Wikimedia Commons, `File:Slurm logo.svg` | GPL, as stated there | Only the dots, without the words |
| `snakemake.svg` | `images/logo.svg` in github.com/snakemake/snakemake | MIT | None |
| `zarr.svg` | `docs/_static/logo_horizontal.svg` in github.com/zarr-developers/zarr-python | MIT | Only the cube, without the word, and cleaned up |

Simple Icons (https://simpleicons.org) gives every icon in one color; the
fill is the brand color that its data lists. Check the license of a file again
before relying on it in another place: the table records what the sources said
when the logos were added.
