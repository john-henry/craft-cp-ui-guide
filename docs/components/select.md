# Select

Native selects get Craft’s chrome via `forms.select`. For searchable / taggable menus, use `forms.selectize`; for multi-value, `forms.multiselect`.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:280px">
<div class="heading"><label>Section</label></div>
<div class="input"><div class="select"><select><option>News</option><option>Blog</option><option>Docs</option></select></div></div>
</div>
</div>
</div>

```twig
{{ forms.selectField({
    label: "Section",
    name: "sectionId",
    value: value,
    options: [
        { label: "News", value: "1" },
        { label: "Blog", value: "2" },
        { label: "Docs", value: "3" },
    ],
}) }}
```

The macro renders a `.select` container around a **bare `<select>`** — the `<select>` itself gets no class. The chevron is a rotated border on `.select::after`, not an image or an icon, and the native arrow is suppressed with `appearance: none`.

`.select` is shared with `selectize`, so Craft guards its own rules with `:not(.selectize)`. If you style `.select` in plugin CSS without that guard, you'll restyle every searchable menu too.

An `options` entry can be a `{ label, value }` hash, a bare string, or `{ optgroup: "…" }` to start a group. Passing `toggle: true` adds `.fieldtoggle` to the `<select>` and wires `data-target-prefix`, so choosing an option shows the matching `#prefix-value` container — that's how Craft's own settings screens swap panels without custom JS.
