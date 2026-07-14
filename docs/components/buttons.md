# Buttons

One primary `.submit` per screen. Everything else is a neutral `.btn`, a `.secondary`, a destructive `.caution`, or a `.dashed` “add” affordance.

<div class="cp-demo" markdown="0">
<div class="demo row">
<button class="btn submit">Save</button>
<button class="btn secondary">Save and continue</button>
<button class="btn">Cancel</button>
<button class="btn caution">Delete</button>
<button class="btn dashed"><svg class="ic"><use href="#i-plus"></use></svg> Add a row</button>
<button class="btn disabled">Disabled</button>
</div>
</div>

```twig
{# Primary action #}
{{ forms.submitButton({ label: "Save"|t("app") }) }}

{# Or the generic button macro with any class #}
{{ forms.button({
    label: "Delete"|t("app"),
    class: "caution",
    spinner: true,
}) }}
```

```html title="HTML output"
<button type="submit" class="btn submit">
  <div class="inline-flex">
    <div class="label">Save</div>
  </div>
</button>
```


## Sizes & groups

<div class="cp-demo" markdown="0">
<div class="demo row" style="align-items:center">
<button class="btn small">Small</button>
<button class="btn">Default</button>
<button class="btn big">Big</button>
<span style="width:16px"></span>
<div class="btngroup" role="group">
<button class="btn active">List</button>
<button class="btn">Cards</button>
<button class="btn">Table</button>
</div>
</div>
</div>

```twig
{{ forms.buttonGroup({
    name: "viewMode",
    value: "list",
    options: [
        { label: "List",  value: "list" },
        { label: "Cards", value: "cards" },
        { label: "Table", value: "table" },
    ],
}) }}
```

!!! note
    **Icon buttons.** Pass `icon: "settings"` (a Craft icon name) to `forms.button`. Craft renders an inline SVG inside `.cp-icon`. Add `spinner: true` to reserve space for a loading indicator on async actions.
