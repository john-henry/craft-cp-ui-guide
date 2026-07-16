# Craft CMS Control Panel — UI & Brand Guide

An **unofficial, reverse-engineered** reference to the [Craft CMS](https://craftcms.com) 5.x
control-panel UI, aimed at people building **plugins and modules**. It documents the design
tokens, form macros, components, and Twig/PHP snippets you need to make your settings screens,
field types, and element indexes look native to Craft.

> **Not official Craft documentation.** Values were derived by reading the open-source
> `craftcms/cms` (5.x), `craftcms/commerce`, and `craftcms/shopify` repositories. Class names
> and tokens are Craft's; this project only documents how to use them. When Craft changes,
> this may drift — [corrections welcome](CONTRIBUTING.md).

## Live site

[https://john-henry.github.io/craft-cp-ui-guide/](https://john-henry.github.io/craft-cp-ui-guide/)

## What's inside

- **Foundations** — color, typography, spacing, and the full design-token set.
- **Components** — buttons, the field wrapper, inputs, lightswitch, tables, tabs, toolbars,
  sidebars, modals, and relation (Entries/Assets) fields, each with a **live preview** and
  copy-paste Twig/PHP/HTML.
- **Commerce & advanced** — status labels, money/price, metadata sidebars, order totals,
  address cards, element indexes, and field-layout builder elements.
- **Reference** — every built-in field type and a form-macro cheat sheet.

The component previews are real HTML styled with Craft's actual CSS (extracted to
`docs/stylesheets/craft-cp.css` and scoped to `.cp-demo` so it never fights the theme).

## Run locally

The site is [MkDocs Material](https://squidfunk.github.io/mkdocs-material/). With Docker you
need nothing installed, and you get the same version CI builds with:

```bash
make serve      # open http://localhost:8000/craft-cp-ui-guide/
```

Note the `/craft-cp-ui-guide/` path — `site_url` sets a base path, so the bare root redirects
there. Other targets:

```bash
make build      # render to site/ with --strict (what CI runs)
make clean      # remove site/
make help       # list every target
```

Prefer running MkDocs natively? You'll need **Python 3.9+**:

```bash
make venv        # creates .venv, installs requirements.txt
make venv-serve
```

On Debian/Ubuntu that also needs the matching `python3.x-venv` package, and you may have to
point it at a newer interpreter: `make venv PY=python3.12`.

## Contributing

Spotted an inaccuracy or something that's drifted from current Craft? Please
[open an issue or PR](CONTRIBUTING.md) — fidelity is the whole point of this reference. The full
guide, including how the live previews are built, is at
[Contributing](https://john-henry.github.io/craft-cp-ui-guide/contributing/).

## Acknowledgements

Thanks to the folks whose contributions and work have improved this repo:

- **[Michael Thomas](https://github.com/michtio)** ([@michtio](https://github.com/michtio)) — Feedback and creator of [Craft CMS Claude Skills](https://github.com/michtio/craftcms-claude-skills)

## License

[MIT](LICENSE). Craft CMS, its control panel, class names, and design tokens are the property
of Pixel &amp; Tonic, Inc.; this project documents them and is not affiliated with or endorsed
by them.
