# The field wrapper

The single most important pattern to match. Every setting in the CP lives in a `.field` shell: a heading with an optional required dot, instructions, the input, and any tip / warning / errors below. The `*Field` macros build all of this for you.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field">
<div class="heading"><label class="required" for="demo-slug">Slug</label></div>
<div class="instructions"><p>How this entry is referenced in URLs.</p></div>
<div class="input"><input class="text fullwidth" id="demo-slug" type="text" value="my-first-entry"/></div>
<div class="tip"><svg class="ic" style="margin-top:1px"><use href="#i-lightbulb"></use></svg> Leave blank to generate from the title.</div>
</div>
</div>
</div>

```twig
{{ forms.textField({
    label: "Slug"|t("app"),
    instructions: "How this entry is referenced in URLs."|t("app"),
    tip: "Leave blank to generate from the title."|t("app"),
    id: "slug",
    name: "slug",
    value: entry.slug ?? "",
    required: true,
    errors: entry.getErrors("slug"),
}) }}
```

| Config key | Effect |
| --- | --- |
| `label` | Bold heading above the input |
| `instructions` | Subtle help text (Markdown supported) |
| `required` | Adds the red required dot to the label |
| `tip` / `warning` | Blue tip or amber warning line below the input |
| `errors` | Array of validation messages, rendered in red |
| `id` / `name` / `value` | Standard input wiring |
