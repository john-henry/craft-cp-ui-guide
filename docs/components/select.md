# Select

Native selects get Craft’s chrome via `forms.select`. For searchable / taggable menus, use `forms.selectize`; for multi-value, `forms.multiselect`.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:280px">
<div class="heading"><label>Section</label></div>
<div class="input"><div class="select-wrap"><select class="select-el"><option>News</option><option>Blog</option><option>Docs</option></select></div></div>
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
