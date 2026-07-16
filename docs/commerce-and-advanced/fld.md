# Layout builder elements

When you edit an entry type, user, asset, or any element’s field layout, the **field layout designer** lets you drag more than just fields onto a tab. These *UI elements* add structure and guidance to author-facing edit screens. Each shows as a draggable chip in the designer, and renders its own markup on the edit form.


## The designer library

This is what the addable items look like in the library, each with its icon and label. Drag one onto a tab and Craft inserts it into the layout.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="fld-workspace">
<div class="fld-ui-library">
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-heading"></use></svg></span><h4>Heading</h4></div>
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-lightbulb"></use></svg></span><h4>Tip</h4></div>
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-warning"></use></svg></span><h4>Warning</h4></div>
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-rule"></use></svg></span><h4>Horizontal Rule</h4></div>
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-return"></use></svg></span><h4>Line Break</h4></div>
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-markdown"></use></svg></span><h4>Markdown</h4></div>
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-filecode"></use></svg></span><h4>Template</h4></div>
<div class="fld-element"><span class="fld-element-icon"><svg class="ic"><use href="#i-code"></use></svg></span><h4>HTML</h4></div>
</div>
</div>
</div>
</div>

```html title="chip markup"
<div class="fld-element" data-type="craft-fieldlayoutelements-Heading">
  <div class="fld-element-icon"><!-- SVG icon --></div>
  <div class="field-name">
    <div class="fld-element-label"><h4>Heading</h4></div>
  </div>
</div>
```

The library is `.fld-ui-library` (UI elements) beside `.fld-field-library` (your actual fields), both inside `.fld-workspace`. Each chip is a `.fld-element` — the same class whether it's sitting in the library or dropped on a tab.

Don't confuse the **chip** classes with the **rendered** output. `HorizontalRule`'s selector chip is `.fld-hr` and `LineBreak`'s is `.fld-br`, but neither class appears on the edit screen — that's what the sections below show.


## Tip & Warning

Author-facing callouts. Content is Markdown, and a tip can be made dismissible (Craft remembers dismissal per user). Same underlying element, two styles.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="pane tip dismissible" style="margin-bottom:14px"><button class="tip-dismiss-btn" title="Dismiss"><svg class="ic"><use href="#i-x"></use></svg></button><p>Use a concise, keyword-rich title — it becomes the URL slug and the browser tab label.</p></div>
<div class="pane warning"><p>Changing the section handle will break any templates that reference the old handle.</p></div>
</div>
</div>

```html title="HTML output"
<div class="pane tip"><p>Use a concise, keyword-rich title…</p></div>

<div class="pane warning"><p>Changing the handle will break templates.</p></div>
```

```php title="programmatic layout"
use craft\fieldlayoutelements\Tip;

new Tip([
    'style' => Tip::STYLE_WARNING,   // or STYLE_TIP
    'tip' => 'Changing the handle will break templates.',
    'dismissible' => false,
]);
```


## Heading

Groups related fields under a bold subheading within a tab. Renders a **bare `<h2>`** on the edit screen — no class, so it inherits whatever the surrounding pane gives it.

<div class="cp-demo" markdown="0">
<div class="demo">
<h2>Search engine optimization</h2>
</div>
</div>

```php
use craft\fieldlayoutelements\Heading;

new Heading(['heading' => 'Search engine optimization']);
// formHtml() returns: <h2>Search engine optimization</h2>
```


## Horizontal Rule & Line Break

A **Horizontal Rule** draws a divider between groups of fields. A **Line Break** is invisible on the rendered form — it forces the next field onto a new row, so you can control how fields wrap across the layout’s columns.

<div class="cp-demo" markdown="0">
<div class="demo">
<hr/>
<div class="line-break" style="margin-top:16px">line break — forces the next field to a new row</div>
</div>
</div>

```php
use craft\fieldlayoutelements\{HorizontalRule, LineBreak};

new HorizontalRule();  // formHtml() returns: <hr>
new LineBreak();       // formHtml() returns: <div class="line-break"></div>
```

Both render bare — the `<hr>` carries no class at all. In the designer they're the `.fld-hr` and `.fld-br` chips, but those classes stop at the designer.

!!! note
    **The line break is invisible.** `LineBreak` renders an empty `<div class="line-break">`; it has no appearance on the edit screen and exists only to push the next field onto a new row. The dashes above are the guide drawing something where Craft draws nothing.


## Markdown, Template & HTML

Three ways to inject custom content. **Markdown** renders author-written Markdown; **Template** renders the output of one of your Twig templates (with the element in scope); **HTML** outputs raw markup you supply. Use these for contextual help, computed summaries, or plugin-specific widgets inside the edit screen.

| Element | Class | Icon | Renders |
| --- | --- | --- | --- |
| Heading | `fieldlayoutelements\Heading` | hashtag | `<h2>` |
| Tip | `fieldlayoutelements\Tip` | lightbulb | `.pane.tip` callout |
| Warning | `fieldlayoutelements\Tip` (style) | triangle-exclamation | `.pane.warning` callout |
| Horizontal Rule | `fieldlayoutelements\HorizontalRule` | rule | `<hr>` |
| Line Break | `fieldlayoutelements\LineBreak` | return | `.line-break` (layout only) |
| Markdown | `fieldlayoutelements\Markdown` | markdown | Processed Markdown HTML |
| Template | `fieldlayoutelements\Template` | file-code | Rendered Twig template |
| HTML | `fieldlayoutelements\Html` | code | Raw custom HTML |

!!! note
    **Plugins can add their own.** Extend `craft\fieldlayoutelements\BaseUiElement` (or `BaseField` for a field-like item), implement `selectorLabel()`, `selectorIcon()`, and `formHtml()`, then register it via the `FieldLayout::EVENT_DEFINE_UI_ELEMENTS` event. Your element then appears in the designer’s library for authors to drag in, exactly like the built-ins above.
