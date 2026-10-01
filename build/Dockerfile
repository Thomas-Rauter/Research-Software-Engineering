# Image that builds the PDFs in pdf/ from the LaTeX sources in latex/.
#
# Build it once with `make image`. Each `make pdf` then runs a short-lived
# container from it. The image lives in Docker's local storage, not in this
# repository.
#
# TeX Live is pinned to a frozen yearly release, so rebuilding the image later,
# or on another machine, gives the same TeX and therefore the same PDFs. To
# move to a newer release, change the tag and run `make image` again.
FROM texlive/texlive:TL2025-historic

WORKDIR /work
