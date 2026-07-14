# Contributing

Thanks for helping keep this reference accurate! It's a community resource, and the most
valuable contributions are **corrections where the guide has drifted from current Craft**.

## Ground rules

- This documents **Craft CMS 5.x**. Note the Craft version your change applies to.
- Prefer **primary sources**: cite the file/line in `craftcms/cms`, `craftcms/commerce`, or
  `craftcms/shopify` your change is based on (a permalink to the tagged release is ideal).
- Keep it **unofficial and honest** — don't imply endorsement by Pixel & Tonic.

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

## Adding a page

1. Create `docs/<group>/<slug>.md` starting with a single `# Title`.
2. Add it to the `nav:` tree in `mkdocs.yml`.
3. Run `mkdocs serve` and confirm the preview renders and links resolve.

## Preview your change

```bash
pip install -r requirements.txt
mkdocs serve
```

Open a PR against `main`; the deploy workflow publishes automatically once merged.
