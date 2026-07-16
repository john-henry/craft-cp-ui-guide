# Contributing

Thanks for helping keep this reference accurate! It's a community resource, and the most
valuable contributions are **corrections where the guide has drifted from current Craft**.

## Ground rules

- This documents **Craft CMS 5.x**. Note the Craft version your change applies to.
- Prefer **primary sources**: cite the file/line in `craftcms/cms`, `craftcms/commerce`, or
  `craftcms/shopify` your change is based on (a permalink to the tagged release is ideal).
  Reading the templates beats reading the compiled CSS — a selector can exist without any
  template ever emitting it.
- Keep it **unofficial and honest** — don't imply endorsement by Pixel & Tonic.

## Run it locally

With Docker — nothing to install, and it matches what CI builds with:

```bash
make serve      # http://localhost:8000/craft-cp-ui-guide/
```

The preview reloads as you edit. Note the `/craft-cp-ui-guide/` path: `site_url` sets a base
path, so the bare root just redirects there.

```bash
make build      # render to site/ with --strict
make clean      # remove site/
make help       # list every target
```

`make build` passes `--strict`, so broken links and bad config fail the build rather than
shipping. Run it before opening a PR — it's the same thing CI runs.

### Without Docker

You need **Python 3.9+**; the pinned `mkdocs-material` won't install on older interpreters.

```bash
make venv        # creates .venv, installs requirements.txt
make venv-serve
```

On Debian/Ubuntu `make venv` also needs the matching `python3.x-venv` package, and you may need
to point it at a newer interpreter: `make venv PY=python3.12`.

!!! note
    **Two places pin the version.** `requirements.txt` pins `mkdocs-material` for CI, and the
    `IMAGE` variable in the `Makefile` pins the Docker image for local builds. Bump them
    together or local and CI will drift apart.

## Editing content

Each page under `docs/` is plain Markdown:

- **Prose** is normal Markdown.
- **Code snippets** are fenced blocks (```` ```twig ````, ```` ```php ````, etc.). Material
  adds the copy button automatically.
- **Live previews** are raw HTML wrapped in `<div class="cp-demo" markdown="0">…</div>`. The
  styles live in `docs/stylesheets/craft-cp.css` (scoped to `.cp-demo`). Reuse existing
  component classes; only touch the stylesheet if you're adding a genuinely new component.
- Icons come from an inline SVG sprite injected on every page via
  `overrides/partials/cp-sprite.html`; reference them with
  `<svg class="ic"><use href="#i-…"/></svg>`.

### Theme features worth using

- **Content tabs** for the same thing in different languages — Twig / PHP / rendered HTML:

    ````markdown
    === "Twig"

        ```twig
        …
        ```

    === "Rendered HTML"

        ```html
        …
        ```
    ````

    Tabs with the same labels stay in sync across the page (`content.tabs.link`), so picking
    "PHP" once picks it everywhere.

- **Code annotations** for explaining markup class-by-class. The fence needs the `.annotate`
  class — the `content.code.annotate` feature flag on its own does nothing, it just fails
  silently:

    ````markdown
    ```{ .html .annotate }
    <div class="chip small element removable"> <!-- (1)! -->
    ```

    1.  Four classes, from two different renderers.
    ````

    The numbered list must follow the block immediately. `(1)!` strips the comment markers;
    `(1)` keeps them.

- **Last-updated** dates render from git history. New pages show the build date until they're
  committed — that's the `fallback_to_build_date` setting, not a bug.

### Use Craft's real class names

Demos should use the markup Craft actually emits, not an approximation that merely looks right.
If a preview needs a class Craft doesn't have, that's a signal the structure is wrong — the
guide's value is that you can copy a class name out of it and have it work.

Where a demo *must* depart from reality — a disclosure menu shown open, an icon standing in for
Craft's icon font — say so on the page rather than letting it read as fact.

## Adding a page

1. Create `docs/<group>/<slug>.md` starting with a single `# Title`.
2. Add it to the `nav:` tree in `mkdocs.yml`.
3. Run `make build` and confirm it passes `--strict`, then `make serve` and check the preview
   renders and links resolve.

Open a PR against `main`; the deploy workflow publishes automatically once merged.
