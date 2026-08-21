# Changelog

Notable changes to this guide. The guide isn't versioned against a release number — it tracks the Craft CMS 5.x control panel, so entries are dated. Format loosely follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## 2026-08-21 — Dark mode fixes

### Fixed

- **Demo `code`, search inputs, and unstyled text** — MkDocs' dark palette was leaking into the live previews. `.md-typeset code`'s theme-driven background outranked the demo stylesheet's `code` rule; `.search-container input` had no explicit color, so it picked up Material's dark-mode text color; and plain text without its own color (spacing-scale values, radius captions) was inheriting Material's theme color via dead `.cp-demo body` / `.cp-demo html` selectors that never matched anything (a `markdown="0"` block has no nested `<html>`/`<body>`). All are now pinned to the guide's always-light demo styling regardless of site theme. ([JOH-6](https://github.com/john-henry/craft-cp-ui-guide/issues/1))

## 2026-07-14 — Craft 5.10 accuracy pass

Corrections after re-verifying the guide against `craftcms/cms` 5.10.10 source, plus a navigation fix.

### Fixed

- **Modals** — removed the non-existent `Craft.confirm()` and the fabricated `.modal .header` / `.modal .footer` classes. Documented the real structure: a bare `Garnish.Modal` is a `.modal` with a `.body`, while a structured `Craft.CpModal` uses `.cpmodal-body` › `.cpmodal-content` + `.cpmodal-footer`. Alert action rows use `.buttons.right`.
- **Address card** — replaced the non-existent `cp.addressCardHtml()` macro with the real `elementCard()` / `elementChip()` Twig functions. Clarified that `Cp::addressFieldsHtml()` is a PHP helper, not a `cp.*` Twig call.
- **Entries & Assets fields** — corrected the element-appearance override points to `attributeHtml()`, `getChipLabelHtml()`, and `getCardBodyHtml()`. The old `chipHtml()` / `cardHtml()` don't exist as element override methods. Noted that `viewMode: "large"` is a legacy alias Craft remaps to `"thumbs"`.
- **Macro reference** — fixed the checkbox/radio macro pairings to `checkboxGroup` / `checkboxGroupField`, `checkboxSelect` / `checkboxSelectField`, and `radioGroup` / `radioGroupField`. The base and `Field` variants had been mixed.
- **Tabs** — corrected `.tabs` / `.tab` to the real `.pane-tabs` › `.scrollable[role=tablist]`, with tab links carrying `.sel` (selected) and a `.tab-label` span, and no `.tab` class.
- **Toolbar & search** — `.search` is now `.search-container`, with the `.clear-btn` clear control. Noted that the "New entry" button is rendered by the element index in JavaScript, not static `.btn.submit` markup.
- **Layout builder elements** — the UI-element wrapper is `.fld-ui-element` (with a `data-type` attribute), not a combined `.fld-element fld-ui-element`.
- **Status indicators** — "Expired" uses its own `.status.expired` class instead of reusing `.status.off`. Noted that `off`, `suspended`, and `expired` are distinct statuses that share the same muted fill.
- **Typography & tokens** — stopped presenting runtime pixel values as design tokens. `--font-size`, `12.5px`, and `--text-color: --gray-700` were not real tokens; the confirmed ones are `--size-line-height: 1.42em` and `--fg-subtle: var(--gray-550)`.
- **Sidebar navigation** — clicking some sidebar links updated the URL without updating the page content, needing a manual refresh. Removed the `navigation.instant` theme feature, which threw on the guide's inline SVG sprite icons (`<use href="#…">`, whose SVG `href` is read-only) and killed instant navigation mid-swap.

### Changed

- **Demo stylesheet** (`docs/stylesheets/craft-cp.css`) — updated so the live previews render against the corrected, real Craft class names (`.pane-tabs`, `.search-container`, `.cpmodal-*`, `.status.expired`).
