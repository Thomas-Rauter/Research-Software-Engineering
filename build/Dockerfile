# Image that renders the website and its PDFs with Quarto.
#
# `make image` builds it; `make site` and `make preview` run short-lived
# containers from it and build it first if needed. The image lives in
# Docker's local storage, not in this repository.
#
# TeX Live and Quarto are pinned, so rebuilding the image later, or on another
# machine, gives the same tools and therefore the same site. To move to newer
# releases, change the tag or QUARTO_VERSION and run `make image` again.
FROM texlive/texlive:TL2025-historic

# rsvg-convert turns the SVG figures into PDF for the PDFs.
RUN apt-get update \
 && apt-get install --yes --no-install-recommends librsvg2-bin \
 && rm -rf /var/lib/apt/lists/*

ARG QUARTO_VERSION=1.10.19
ARG TARGETARCH
RUN curl -fsSL -o /tmp/quarto.deb \
      "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${TARGETARCH}.deb" \
 && dpkg -i /tmp/quarto.deb \
 && rm /tmp/quarto.deb

# Build the font cache of LuaLaTeX once, where every user can read it, rather
# than in every run.
ENV TEXMFVAR=/usr/local/texlive/2025/texmf-var
RUN luaotfload-tool --update && chmod -R a+rwX "$TEXMFVAR"

WORKDIR /work
