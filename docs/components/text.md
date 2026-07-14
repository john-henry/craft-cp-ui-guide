# Text & textarea

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field"><div class="heading"><label>Heading</label></div><div class="input"><input class="text fullwidth" placeholder="Enter a headline…" type="text"/></div></div>
<div class="field"><div class="heading"><label>Summary</label></div><div class="instructions"><p>A short teaser for listings.</p></div><div class="input"><textarea class="text fullwidth">Craft is a flexible, user-friendly CMS.</textarea></div></div>
</div>
</div>

```twig
{{ forms.textField({ label: "Heading", name: "heading", value: value }) }}

{{ forms.textareaField({
    label: "Summary",
    instructions: "A short teaser for listings.",
    name: "summary",
    rows: 4,
    value: value,
}) }}
```
