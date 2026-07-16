# Tables

Two different things share the word "table" in the CP. `table.data` is **static** tabular
content you write yourself. `forms.editableTable` is an **input** — add, edit, reorder, and
delete rows, posted back as an array.

For a listing of things your plugin manages (with sorting, pagination, and bulk actions), you
want neither — see [Vue admin tables](vue-admin-table.md).

## Static — `table.data`

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<table class="data">
<thead><tr><th>Name</th><th>Handle</th><th>Type</th><th>Status</th></tr></thead>
<tbody>
<tr><td>Featured Image</td><td><code>featuredImage</code></td><td>Assets</td><td><span class="status on"></span> Enabled</td></tr>
<tr><td>Body</td><td><code>body</code></td><td>CKEditor</td><td><span class="status on"></span> Enabled</td></tr>
<tr><td>Legacy Tags</td><td><code>legacyTags</code></td><td>Tags</td><td><span class="status off"></span> Disabled</td></tr>
</tbody>
</table>
</div>
</div>

```html
<table class="data">
  <thead><tr><th>Name</th><th>Handle</th></tr></thead>
  <tbody>
    <tr><td>Featured Image</td><td><code>featuredImage</code></td></tr>
  </tbody>
</table>
```

Nothing clever — plain markup with one class. Add `.fullwidth` to stretch it.

## Editable — `forms.editableTable`

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<table class="editable fullwidth">
<thead><tr><th scope="col">From</th><th scope="col">To</th><th class="thin"></th></tr></thead>
<tbody>
<tr><td class="textual"><textarea rows="1">/old-page</textarea></td><td class="textual"><textarea rows="1">/new-page</textarea></td><td class="thin action"><svg class="ic"><use href="#i-x"></use></svg></td></tr>
<tr><td class="textual"><textarea rows="1">/legacy</textarea></td><td class="textual"><textarea rows="1">/blog</textarea></td><td class="thin action"><svg class="ic"><use href="#i-x"></use></svg></td></tr>
</tbody>
</table>
<div class="flex" style="margin-top:8px"><button class="btn add icon dashed wrap" type="button"><svg class="ic"><use href="#i-plus"></use></svg> Add a redirect</button></div>
</div>
</div>

```twig
{{ forms.editableTableField({
    label: "Redirects",
    name: "redirects",
    cols: {
        from: { heading: "From", type: "singleline" },
        to:   { heading: "To",   type: "singleline" },
    },
    rows: settings.redirects,
    addRowLabel: "Add a redirect",
    allowAdd: true,
    allowDelete: true,
    allowReorder: true,
}) }}
```

The container is `<table class="editable">`, plus `fullwidth`, `static`, and `hidden` (when
there are zero rows — the Add button is outside the table, so an empty table disappears rather
than showing an empty header).

### Config

| Key | Default | Effect |
| --- | --- | --- |
| `cols` | `[]` | Column definitions, keyed by the row-data key |
| `rows` | `[]` | Row data |
| `allowAdd` | `false` | Show the Add button |
| `allowDelete` | `false` | Show per-row delete |
| `allowReorder` | `false` | Show drag handles |
| `minRows` | `null` | Minimum rows |
| `maxRows` | `null` | Maximum rows — hides Add once reached |
| `static` | `false` | Read-only |
| `staticRows` | `false` | Rows can't be added/removed/reordered, but remain editable |
| `fullWidth` | `true` | Adds `.fullwidth` |
| `includeRowId` | `false` | Post a hidden row ID with each row |
| `addRowLabel` | — | Label on the Add button |
| `initJs` | `true` | Set false to construct `Craft.EditableTable` yourself |

**All three `allow*` options default to `false`** and are silently forced off when `staticRows`
is on — which also happens implicitly when `minRows == 1 and maxRows == 1` and there's one row.
If your Add button won't appear, that's the first thing to check.

### Column types

| Type | Renders |
| --- | --- |
| `singleline` | Single-line text (a `<textarea rows="1">`) |
| `multiline` | Multi-line textarea |
| `number` | Numeric input |
| `select` | Dropdown — needs `options` |
| `checkbox` | Checkbox |
| `lightswitch` | Lightswitch |
| `color` | [Colour picker](pickers.md) |
| `date` | [Date picker](datetime.md) |
| `time` | [Time picker](datetime.md) — registers `TimepickerAsset` |
| `email` | Email input |
| `url` | URL input |
| `autosuggest` | [Autosuggest](autosuggest.md) — takes `suggestEnvVars` / `suggestAliases` |
| `icon` | Icon picker |
| `heading` | A row heading rather than an input |
| `html` | Raw HTML |
| `template` | Rendered Twig template — registers `VueAsset` |

Per-column keys: `heading`, `headingHtml`, `info`, `type`, `class`, `width`, `thin`, `code`,
`placeholder`, `rows`, `options`, `value`, `locale`, `suggestEnvVars`, `suggestAliases`.

!!! note
    **`singleline` is a textarea.** Not an `<input>` — Craft uses `<textarea rows="1">` so the
    cell can grow and so paste-with-newlines behaves. If you're targeting
    `.editable input[type=text]` in plugin CSS, you're missing every text column.

!!! note
    **The preview is static.** `Craft.EditableTable` handles adding, deleting, reordering, and
    the JS-driven cell types at runtime. The demo shows the server-rendered shape; the drag
    handles and live behaviour aren't reproducible here.
