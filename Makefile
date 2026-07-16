# Local preview for the docs site.
#
# Docker is the default path — it needs nothing installed on the host and matches
# the Python version CI builds with. If you'd rather run MkDocs natively, see the
# venv targets below.
#
# Pinned so local builds are reproducible; CI floats on `mkdocs-material>=9.5`
# per requirements.txt. Bump this when CI picks up a version worth matching.
IMAGE ?= squidfunk/mkdocs-material:9.7.6
PORT  ?= 8000

# Run the container as the invoking user so generated files aren't root-owned.
DOCKER_RUN = docker run --rm -v "$(CURDIR):/docs" --user "$(shell id -u):$(shell id -g)"

# Allocate a TTY only when there is one, so `make serve` also works from a script or CI.
TTY := $(shell [ -t 0 ] && printf -- '-it')

.PHONY: serve build clean venv venv-serve help

# site_url in mkdocs.yml carries a /craft-cp-ui-guide/ base path, so MkDocs mounts the
# site there rather than at the server root. Visiting the root just redirects.
URL = http://localhost:$(PORT)/craft-cp-ui-guide/

help:
	@echo "make serve       Live preview on $(URL) (Docker)"
	@echo "make build       Render the static site into ./site (Docker)"
	@echo "make clean       Remove ./site"
	@echo "make venv        Create .venv and install requirements.txt (needs Python 3.9+)"
	@echo "make venv-serve  Live preview using .venv instead of Docker"

# MkDocs must bind 0.0.0.0 for Docker's port mapping to reach it, and it echoes that
# address on startup — but 0.0.0.0 isn't browsable. Print the usable URL first.
serve:
	@echo "→ Open $(URL)"
	@echo "  (ignore the 0.0.0.0 address MkDocs prints below — it's the bind address)"
	$(DOCKER_RUN) -p "$(PORT):8000" $(TTY) $(IMAGE) serve --dev-addr 0.0.0.0:8000

build:
	$(DOCKER_RUN) $(IMAGE) build --strict

clean:
	rm -rf site

# Native path. Requires a Python 3.9+ interpreter with venv support; on Debian/Ubuntu
# that means the matching python3.x-venv package. Override with: make venv PY=python3.12
PY ?= python3

venv:
	$(PY) -m venv .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install -r requirements.txt

venv-serve:
	.venv/bin/mkdocs serve --dev-addr "127.0.0.1:$(PORT)"
