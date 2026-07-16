# Checkbox & radio

Craft doesn't wrap these in a row element. The `<input>` and its `<label>` are **siblings**, and
the control you see is drawn on the label's `::before` while the native input sits invisibly
behind it. That's why the label isn't optional — without it there's nothing to render.

## Checkboxes

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="checkbox-group">
<input checked class="checkbox" id="cb-comments" type="checkbox"/><label for="cb-comments">Enable comments</label>
<input class="checkbox" id="cb-guests" type="checkbox"/><label for="cb-guests">Allow guest authors</label>
<input checked class="checkbox" id="cb-notify" type="checkbox"/><label for="cb-notify">Send notifications</label>
</div>
</div>
</div>

```twig
{{ forms.checkboxGroupField({
    label: "Options",
    name: "options",
    values: ["comments", "notify"],
    options: [
        { label: "Enable comments", value: "comments" },
        { label: "Allow guest authors", value: "guests" },
        { label: "Send notifications", value: "notify" },
    ],
}) }}
```

```html
<div id="checkbox-group-1" class="checkbox-group">
  <input type="hidden" name="options" value="">
  <input type="checkbox" id="options-comments" class="checkbox" name="options[]" value="comments" checked>
  <label for="options-comments">Enable comments</label>
  <input type="checkbox" id="options-guests" class="checkbox" name="options[]" value="guests">
  <label for="options-guests">Allow guest authors</label>
</div>
```

`checkboxGroup` wraps the set in `.checkbox-group` — a flex column — and posts `name[]`. Note
the **hidden input** carrying the bare `name` first: without it, unchecking everything would
leave the key absent from the POST entirely, and the old value would survive the save. A lone
`forms.checkbox` emits the same hidden input whenever its `name` doesn't already end in `[]`.

`checked` is a real attribute on the input, not a class.

## Radios

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="radio-group">
<input checked class="radio" id="st-draft" name="status" type="radio"/><label for="st-draft">Draft</label>
<input class="radio" id="st-pending" name="status" type="radio"/><label for="st-pending">Pending review</label>
<input class="radio" id="st-live" name="status" type="radio"/><label for="st-live">Published</label>
</div>
</div>
</div>

```twig
{{ forms.radioGroupField({
    label: "Status",
    name: "status",
    value: "draft",
    options: [
        { label: "Draft", value: "draft" },
        { label: "Pending review", value: "pending" },
        { label: "Published", value: "live" },
    ],
}) }}
```

Same shape, `.radio-group` instead. The dot is the label's `::after`, sized `--radio-size - 8px`
and filled `--gray-900` when checked.

## Toggling other fields

Both accept a `toggle`, which is how Craft's own settings screens reveal dependent fields with
no custom JS — but the two macros wire it up differently.

A **checkbox** takes the target's id directly. The macro adds `.fieldtoggle` to the input and
sets `data-target`:

```twig
{{ forms.checkboxField({
    label: "Limit relations",
    name: "useLimit",
    checked: settings.useLimit,
    toggle: "limit-settings",
}) }}

<div id="limit-settings" class="{{ settings.useLimit ? '' : 'hidden' }}">
  {{ forms.textField({ label: "Max relations", name: "maxRelations" }) }}
</div>
```

A **radioGroup** (and [select](select.md)) instead takes `toggle: true` plus a `targetPrefix`,
and puts `.fieldtoggle` and `data-target-prefix` on the container — each option then reveals
`#prefix` + its own value:

```twig
{{ forms.radioGroupField({
    label: "Source",
    name: "source",
    value: "url",
    toggle: true,
    targetPrefix: "source-",
    options: [
        { label: "URL", value: "url" },
        { label: "Upload", value: "upload" },
    ],
}) }}

<div id="source-url">…</div>
<div id="source-upload" class="hidden">…</div>
```

`reverseToggle` on a checkbox inverts the logic — the target shows when *unchecked*.

!!! note
    **The tick is an icon font.** Craft draws the checkmark with `content: "check"`, a ligature
    from its own icon font, layered on the same pale box — it does **not** invert the box to a
    solid colour the way most UI kits do. The preview above approximates the mark with CSS, so
    its shape is a stand-in even though the structure, box, and sizing are exact.
