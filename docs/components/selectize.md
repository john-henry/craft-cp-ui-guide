# Selectize

`forms.selectize` is Craft's searchable menu — type to filter, optionally create new options on
the fly. It's what most "pick a thing" settings use once the list gets long enough that a native
[select](select.md) stops being pleasant.

It isn't a separate control. `selectize.twig` **includes `select.twig`** and pushes `selectize`
onto the class list, so you get `<div class="select selectize"><select>` — the same markup, with
JS layered on top.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:280px">
<div class="heading"><label id="demo-sz-label" for="demo-sz">Author</label></div>
<div class="input ltr"><div class="select selectize"><select id="demo-sz"><option>Brad Bell</option><option>Brandon Kelly</option><option>Andrew Welch</option></select></div></div>
</div>
</div>
</div>

```twig
{{ forms.selectizeField({
    label: "Author",
    name: "authorId",
    value: value,
    options: [
        { label: "Brad Bell", value: "1" },
        { label: "Brandon Kelly", value: "2" },
    ],
}) }}
```

That shared `.select` class is the trap. Craft guards every native-select rule with
`:not(.selectize)` — the chevron, the padding, the fixed height. Style bare `.select` in plugin
CSS and you'll restyle every searchable menu in the CP along with it.

## Config

`selectize` takes everything [`select`](select.md) does, plus:

| Key | Effect |
| --- | --- |
| `multi` | Multi-value mode — includes `multiselect.twig` instead of `select.twig` |
| `selectizeOptions` | Options passed through to Selectize.js itself |
| `includeEnvVars` | Allow `$ENV_VAR` values alongside the options |
| `allowedEnvValues` | Which env values are permitted. Defaults to every option's `value` |

Options are normalised for you: a bare string, a `{ label, value }` hash, or an
`{ optgroup: "…" }` marker all work. Each option also accepts `icon` and `color`, which get
folded into the option's `data` and rendered in the menu.

## Plugins

Craft sets Selectize's plugin list for you, and **which plugins you get depends on `multi`**:

| Mode | Plugins |
| --- | --- |
| Always | `auto_position`, `selectize-plugin-a11y` |
| `multi: true` | adds `remove_button` |
| Single (default) | adds `select_on_focus` |

Pass `selectizeOptions: { extraPlugins: false }` to opt out of `select_on_focus` in single mode
— useful when focusing the field shouldn't immediately open and select the current value.

`dropdownParent` defaults to `'body'`, which is how the menu escapes overflow-hidden panes.
Overriding it usually means clipping.

!!! note
    **The preview is a plain select.** Selectize is entirely JS — the server renders a normal
    `<select>` and the library replaces it on load. The demo above is that server-rendered
    markup, so it looks like a native select rather than the search field you get in the CP.
    That *is* the fallback: with JS off, it's a working `<select>`.
