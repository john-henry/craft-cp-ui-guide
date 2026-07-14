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

```bash
pip install -r requirements.txt
mkdocs serve
# open http://127.0.0.1:8000
```


## Contributing

Spotted an inaccuracy or something that's drifted from current Craft? Please
[open an issue or PR](CONTRIBUTING.md) — fidelity is the whole point of this reference.

## License

[MIT](LICENSE). Craft CMS, its control panel, class names, and design tokens are the property
of Pixel &amp; Tonic, Inc.; this project documents them and is not affiliated with or endorsed
by them.
