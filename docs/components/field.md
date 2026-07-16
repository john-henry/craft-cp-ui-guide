# The field wrapper

The single most important pattern to match. Every setting in the CP lives in a `.field` shell: a
heading with an optional required dot, instructions, the input, and any tip / warning / errors
below. The `*Field` macros build all of this for you.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" id="demo-slug-field" data-attribute="slug">
<div class="heading"><label id="demo-slug-label" for="demo-slug">Slug<span class="visually-hidden">Required</span><span class="required" aria-hidden="true"></span></label></div>
<div class="instructions" id="demo-slug-instructions"><p>How this entry is referenced in URLs.</p></div>
<div class="input ltr"><input class="text fullwidth" id="demo-slug" type="text" value="my-first-entry"/></div>
<p class="notice has-icon" id="demo-slug-tip"><span class="icon" aria-hidden="true"><svg class="ic"><use href="#i-lightbulb"></use></svg></span><span class="visually-hidden">Tip: </span><span>Leave blank to generate from the title.</span></p>
</div>
</div>
</div>

=== "Twig"

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

=== "PHP"

    ```php
    use craft\helpers\Cp;

    echo Cp::textFieldHtml([
        'label' => Craft::t('app', 'Slug'),
        'instructions' => Craft::t('app', 'How this entry is referenced in URLs.'),
        'tip' => Craft::t('app', 'Leave blank to generate from the title.'),
        'id' => 'slug',
        'name' => 'slug',
        'value' => $entry->slug,
        'required' => true,
        'errors' => $entry->getErrors('slug'),
    ]);
    ```

=== "Rendered HTML"

    ```html
    <div id="slug-field" class="field" data-attribute="slug">
      <div class="heading">
        <label id="slug-label" for="slug">
          Slug
          <span class="visually-hidden">Required</span>
          <span class="required" aria-hidden="true"></span>
        </label>
      </div>
      <div id="slug-instructions" class="instructions"><p>How this entry is referenced in URLs.</p></div>
      <div class="input ltr"><input type="text" id="slug" class="text fullwidth" name="slug"></div>
      <p id="slug-tip" class="notice has-icon">
        <span class="icon" aria-hidden="true"></span>
        <span class="visually-hidden">Tip: </span>
        <span>Leave blank to generate from the title.</span>
      </p>
    </div>
    ```

Three things are easy to get wrong.

**`required` is not a class on the label.** It's a separate `<span class="required" aria-hidden="true">` *after* the label text, preceded by a visually-hidden "Required" — the dot is decorative, and the word is what screen readers get. `<label class="required">` does nothing.

**A tip is `<p class="notice has-icon">`, not `.tip`.** Warnings are `<p class="warning has-icon">`. Both carry a visually-hidden "Tip:" / "Warning:" prefix so the meaning isn't colour-only.

**The container id is `{id}-field`, not `{id}`.** Every sub-element gets a derived id — `-label`, `-instructions`, `-tip`, `-warning`, `-errors`, `-status` — and the macro wires them into the input's `aria-describedby` for you. Override `id` and they all move with it.

## Config

| Config key | Effect |
| --- | --- |
| `label` | Heading above the input. `"__blank__"` renders no label at all |
| `fieldLabel` | Overrides `label` for the heading only |
| `instructions` | Subtle help text (Markdown supported) |
| `instructionsPosition` | `before` (default) or `after` the input |
| `required` | Adds the required dot and the visually-hidden "Required" |
| `tip` / `warning` | `.notice` / `.warning` line below the input |
| `errors` | Array of messages → `<ul class="errors">`, plus `.has-errors` on the field |
| `status` | `[status, message]` → a `.status-badge` in the corner |
| `static` | Adds a `.read-only-badge` beside the label |
| `fieldset` | Renders `<legend>` + `role="group"` instead of `<label for>` |
| `orientation` | `ltr` / `rtl` class on `.input`. Defaults to the site's locale |
| `translatable` | Shows the translation indicator (multi-site only) |
| `id` / `name` / `value` | Standard input wiring |
| `fieldClass` | Extra classes on the outer `.field` |
| `fieldAttributes` | Extra attributes on the outer `.field` |
| `inputContainerAttributes` | Extra attributes on `.input` |
| `labelClass` / `labelAttributes` | Extra class/attributes on the label |
| `headingPrefix` / `headingSuffix` | Raw HTML injected inside `.heading` |
| `labelExtra` | Raw HTML after the `.flex-grow` spacer |
| `actionMenuItems` | Items for a `⋯` disclosure menu in the heading |
| `showAttribute` | Shows the field handle as a copytext button (admins with the pref on) |
| `first` | Adds `.first` — drops the top margin |
| `disabled` | Adds `.disabled` to `.input` |

## Fieldsets

When a field wraps **more than one labelled control** — a date *and* a time, a group of
checkboxes — a `<label for>` can't honestly point at one input. Pass `fieldset: true` and Craft
switches to `<legend>` with `role="group"` and `aria-labelledby`:

```html
<div id="expiry-field" class="field" role="group" aria-labelledby="expiry-label" data-attribute="expiry">
  <div class="heading"><legend id="expiry-label">Expiry</legend></div>
  …
</div>
```

[`dateTimeField`](datetime.md) and [`checkboxGroupField`](checkradio.md) set this for you. You
only pass it by hand when building a custom multi-control field.

## Errors

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field has-errors" id="demo-handle-field" data-attribute="handle">
<div class="heading"><label id="demo-handle-label" for="demo-handle">Handle<span class="visually-hidden">Required</span><span class="required" aria-hidden="true"></span></label></div>
<div class="input ltr errors"><input class="text fullwidth" id="demo-handle" type="text" value="my handle"/></div>
<ul class="errors" id="demo-handle-errors"><li><span class="visually-hidden">Error: </span>Handle must contain only letters, numbers and underscores.</li></ul>
</div>
</div>
</div>

Errors put `.has-errors` on the `.field` **and** `.errors` on `.input`, then append a
`<ul class="errors">`. Each `<li>` gets a visually-hidden "Error:" prefix.

Pass them straight from the model — `errors: entry.getErrors("slug")` — and the ids line up with
`aria-describedby` automatically.

## In the heading

Anything beyond the label goes after a `.flex-grow` spacer, which pushes it to the trailing edge:

```html
<div class="heading">
  <legend id="fields-newsCategory-label">News Category</legend>
  <div class="flex-grow"></div>
  <button type="button" class="btn menubtn action-btn small prevent-autofocus"
          aria-controls="fields-menu-978975904" aria-label="Actions"
          data-disclosure-trigger="true" aria-expanded="false"></button>
</div>
```

That spacer only renders when there's something to push — an `actionMenuItems` menu, a
`showAttribute` handle button, or your own `labelExtra`.

!!! note
    **From PHP.** Twig's `forms.field(config, input)` is a thin wrapper over
    `craft\helpers\Cp::fieldHtml($input, $config)` — same config keys, same output. Every
    `*Field` macro routes through it, which is why they all share the table above. Building a
    field type's settings, or returning HTML from a controller? Call `Cp::textFieldHtml()` and
    friends directly instead of rendering Twig.

!!! note
    **Two flavors of most macros.** A bare input macro (e.g. `forms.text`) renders just the
    control. The `*Field` variant (e.g. `forms.textField`) wraps that control in this shell.
    Reach for `*Field` inside settings screens; use the bare input where you supply your own
    labelling. See [form macros](../reference/macros.md).
