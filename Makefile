# Render the website and its PDFs with Quarto, inside Docker.
#
#   make site      render the website and every PDF into _site/
#   make preview   serve the website at http://localhost:4200, and render
#                  it again on every change of a source (HTML only)
#   make image     (re)build the Docker image; the other targets do it if needed
#   make clean     remove _site/ and Quarto's cache
#
# build/README.md explains the build. Choose another port for the preview
# with, for example, `make preview PORT=8080`.

IMAGE := rse-site
PORT  ?= 4200

DOCKER_RUN := docker run --rm --pull never --user "$$(id -u):$$(id -g)" \
              --env HOME=/tmp

.PHONY: help site preview image clean

help:
	@sed -n '/^$$/q; s/^# \{0,1\}//p' $(firstword $(MAKEFILE_LIST))

# The sources are mounted read-only and rendered in a copy inside the
# container, so that intermediate files, such as the LaTeX of a failed PDF,
# never reach the repository, and every render starts from scratch. The site
# is copied out only if the render succeeds without a warning: Quarto only
# warns about a cross-reference it cannot resolve.
site:
	@docker image inspect $(IMAGE) >/dev/null 2>&1 || $(MAKE) --no-print-directory image
	@rm -rf _site && mkdir _site
	@$(DOCKER_RUN) --network none \
	  --volume "$(CURDIR):/src:ro" --volume "$(CURDIR)/_site:/out" \
	  $(IMAGE) sh -c ' \
	    mkdir /tmp/site && \
	    tar -C /src --exclude=./.git --exclude=./_site --exclude=./.quarto -cf - . \
	      | tar -C /tmp/site -xf - && \
	    cd /tmp/site && \
	    { quarto render 2>&1; echo $$? > /tmp/status; } | tee /tmp/render.log && \
	    if [ "$$(cat /tmp/status)" -ne 0 ]; then exit 1; fi && \
	    if grep -q WARN /tmp/render.log; then \
	      echo "Render failed: warnings above." >&2; exit 1; \
	    fi && \
	    cp -r _site/. /out/'
	@echo "Rendered into _site/."

preview:
	@docker image inspect $(IMAGE) >/dev/null 2>&1 || $(MAKE) --no-print-directory image
	$(DOCKER_RUN) --interactive --tty --publish $(PORT):$(PORT) \
	  --volume "$(CURDIR):/work" --workdir /work \
	  $(IMAGE) quarto preview --host 0.0.0.0 --port $(PORT) --no-browser

image:
	docker build --tag $(IMAGE) build

clean:
	rm -rf _site .quarto
