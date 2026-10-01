# Build the PDFs in pdf/ from the LaTeX sources in latex/, inside Docker.
#
#   make pdf NAME...   build latex/NAME.tex into pdf/NAME.pdf
#   make pdf           build every document in latex/
#   make check         check that every document has a PDF and a README entry
#   make image         (re)build the Docker image; `make pdf` does it if needed
#
# NAME may also be given as NAME.tex or latex/NAME.tex. The engine defaults to
# pdflatex; choose another with, for example, `make pdf NAME ENGINE=-lualatex`.

IMAGE     := latex-pdf
LATEX_DIR := latex
PDF_DIR   := pdf
ENGINE    ?= -pdf

# -Werror makes undefined or multiply defined references fail the build.
LATEXMK := latexmk $(ENGINE) -Werror -interaction=nonstopmode \
           -halt-on-error -file-line-error

# In `make pdf NAME...`, the words after `pdf` are document names, not
# targets: collect them, and give each a rule that does nothing.
ifeq (pdf,$(firstword $(MAKECMDGOALS)))
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  ifneq ($(ARGS),)
    $(eval $(ARGS):;@:)
  endif
endif
DOCS := $(basename $(notdir $(or $(ARGS),$(wildcard $(LATEX_DIR)/*.tex))))

.PHONY: help pdf check image

help:
	@sed -n '/^$$/q; s/^# \{0,1\}//p' $(firstword $(MAKEFILE_LIST))

# The sources are mounted read-only, and latexmk works in the container's
# /tmp, so auxiliary files never reach the repository and every build starts
# from scratch. The PDF is copied out only if the build succeeds.
pdf:
	@docker image inspect $(IMAGE) >/dev/null 2>&1 || $(MAKE) --no-print-directory image
	@mkdir -p $(PDF_DIR)
	@set -e; for name in $(DOCS); do \
	  if [ ! -f "$(LATEX_DIR)/$$name.tex" ]; then \
	    echo "No such document: $(LATEX_DIR)/$$name.tex" >&2; exit 1; \
	  fi; \
	  echo "==> $(LATEX_DIR)/$$name.tex -> $(PDF_DIR)/$$name.pdf"; \
	  docker run --rm --pull never --network none \
	    --user "$$(id -u):$$(id -g)" --env HOME=/tmp \
	    --volume "$(CURDIR)/$(LATEX_DIR):/work/$(LATEX_DIR):ro" \
	    --volume "$(CURDIR)/$(PDF_DIR):/work/$(PDF_DIR)" \
	    --workdir /work/$(LATEX_DIR) \
	    $(IMAGE) sh -c '$(LATEXMK) -outdir=/tmp/out "$$1.tex" && \
	      cp "/tmp/out/$$1.pdf" "/work/$(PDF_DIR)/$$1.pdf"' sh "$$name"; \
	done

check:
	@status=0; \
	for tex in $(LATEX_DIR)/*.tex; do \
	  [ -e "$$tex" ] || continue; \
	  name=$$(basename "$$tex" .tex); pdf=$(PDF_DIR)/$$name.pdf; \
	  if [ ! -f "$$pdf" ]; then \
	    echo "Missing $$pdf (run: make pdf $$name)"; status=1; \
	  fi; \
	  if ! grep -qF "($$pdf)" README.md; then \
	    echo "README.md does not link $$pdf"; status=1; \
	  fi; \
	done; \
	for pdf in $(PDF_DIR)/*.pdf; do \
	  [ -e "$$pdf" ] || continue; \
	  name=$$(basename "$$pdf" .pdf); \
	  if [ ! -f "$(LATEX_DIR)/$$name.tex" ]; then \
	    echo "$$pdf has no source $(LATEX_DIR)/$$name.tex"; status=1; \
	  fi; \
	done; \
	if [ $$status -eq 0 ]; then echo "All documents have a PDF and a README entry."; fi; \
	exit $$status

image:
	docker build --tag $(IMAGE) build
