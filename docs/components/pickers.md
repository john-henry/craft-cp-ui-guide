# Colour & icon pickers

Three related controls: a free-form hex picker, a preset swatch select, and Craft's icon
chooser.

## `color` — hex input

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:280px">
<div class="heading"><label id="demo-color-label" for="demo-color">Brand colour</label></div>
<div class="input ltr">
<div class="flex flex-nowrap color-container" id="demo-color-container">
<div class="color static"><div class="color-preview" style="background-color:#dc2626"></div></div>
<div class="color-input-container">
<div class="color-hex-indicator light code" aria-hidden="true">#</div>
<input class="text color-input" id="demo-color" size="10" type="text" value="dc2626"/>
</div>
</div>
</div>
</div>
</div>
</div>

```twig
{{ forms.colorField({
    label: "Brand colour",
    name: "brandColor",
    value: settings.brandColor,
}) }}
```

The value posts **without** the `#` — the macro renders `value|trim('#')` into the input and
shows the hash as a separate `.color-hex-indicator` div that isn't part of the field. Store and
compare accordingly; a saved value of `dc2626` is normal, not a bug.

Structurally it's a `.color-container` flex row holding a `.color.static` swatch (with a
`.color-preview` inside carrying the inline `background-color`) and a `.color-input-container`.
Pass `small: true` for the compact variant.

The accessible name is assembled from two visually-hidden spans — "Color hex value" and "Value
prefixed by '#'" — wired via `aria-labelledby` and `aria-describedby`, because "dc2626" alone
tells a screen-reader user nothing.

## `colorSelect` — preset swatches

```twig
{{ forms.colorSelectField({
    label: "Label colour",
    name: "labelColor",
    value: settings.labelColor,
}) }}
```

A menu of Craft's named colours rather than a free hex value. Omit `options` and you get the
built-in palette; Craft also unshifts a **"No color"** option with the value `__blank__` — so an
empty selection posts that string, not an empty one.

Values map to `craft\enums\Color`. If you're storing the result, expect the enum's value (`red`,
`amber`, `teal`…) rather than a hex code — the actual colour resolves from the CP's tokens, which
is what keeps plugin colours consistent in both light and dark mode.

## `iconPicker`

```twig
{{ forms.iconPickerField({
    label: "Icon",
    name: "icon",
    value: settings.icon,
}) }}
```

Craft's icon chooser, backed by the same icon set the CP uses for `data-icon` and
`Cp::iconSvg()`. Takes `small` and `static`.

The value is an icon **name** (`gear`, `plus`, `asterisk`), which you render with
`Cp::iconSvg($name)` in PHP or `iconSvg(name)` in Twig — not a path or a file.

!!! note
    **All three are JS-driven.** `color` renders the swatch and hex input server-side, but the
    actual picker panel is JS; `colorSelect` and `iconPicker` are [selectize](selectize.md)
    menus underneath — `iconPicker.twig` even defaults its id to `selectize{random}`. The
    previews here show the server-rendered markup only.
