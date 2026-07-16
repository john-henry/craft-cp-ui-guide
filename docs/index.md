# Craft CMS Control Panel — UI & Brand Guide

An **unofficial, reverse-engineered** reference to the Craft CMS 5.x control panel, for people
building **plugins and modules**. It documents the tokens, macros, and markup you need so your
settings screens, field types, and element indexes look like they belong in Craft rather than
bolted onto it.

Craft's own documentation tells you which APIs to call. This guide covers the layer underneath:
*what the control panel actually renders* — the class names, the structure, and the details that
only surface when you read the templates.

## Where to start

Read [the field wrapper](components/field.md) first. Nearly every control in the CP is a form
macro inside that same shell, so it explains more of the UI than any other single page. From
there, [form macros](reference/macros.md) covers how to call them, and
[components](components/buttons.md) documents what each one renders.

## How this guide is organised

| Section | What's in it |
| --- | --- |
| **Foundations** | Color, typography, spacing, and the full [design-token](foundations/tokens.md) set — the values everything else is built from. |
| **Components** | The CP's building blocks: buttons, fields, inputs, tabs, panes, tables, modals, relation fields. Each with a live preview and copy-paste markup. |
| **Commerce & advanced** | Patterns from Commerce and Shopify — status labels, money, metadata sidebars, order totals, element indexes, layout builders. |
| **Reference** | Every built-in [field type](reference/fieldtypes.md), and the [form-macro](reference/macros.md) cheat sheet. |

## About the previews

The live previews are **real HTML**, styled with Craft's actual CSS extracted into
`docs/stylesheets/craft-cp.css` and scoped to `.cp-demo` so it can't fight the theme. What you
see is what those class names produce.

Two things they can't reproduce. Craft renders its icons from an icon font via `data-icon`
attributes, so the guide substitutes an inline SVG sprite — the glyphs are stand-ins even where
the surrounding markup is exact. And anything Craft builds in JavaScript (datepickers,
disclosure menus, drag-and-drop) is shown in a static state, often one you'd otherwise never see
on screen. Where a demo departs from what Craft emits, the page says so.

!!! note
    **Reference, not gospel.** This is a reverse-engineered snapshot of the Craft 5.x control
    panel, with commerce-specific patterns drawn from [craftcms/commerce](https://github.com/craftcms/commerce)
    and [craftcms/shopify](https://github.com/craftcms/shopify) — not official Craft
    documentation, and not affiliated with or endorsed by Pixel &amp; Tonic. Always cross-check
    class names and macro configs against the version of [craftcms/cms](https://github.com/craftcms/cms)
    your plugin targets, since tokens and markup evolve between releases.

Found something that's drifted from current Craft? Corrections are the most valuable thing you
can contribute — see [contributing](contributing.md).
