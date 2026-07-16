# Tabs

The selected tab is a white card lifted out of the header, not an underlined label — it shares
its background with the pane body below, so the two read as one surface.

<div class="cp-demo" markdown="0">
<header class="pane-header" style="margin:0; border-radius:var(--radius-lg)">
<div class="pane-tabs">
<div class="scrollable" role="tablist">
<a class="sel" role="tab"><span class="tab-label">Content</span></a>
<a role="tab"><span class="tab-label">SEO</span></a>
<a role="tab"><span class="tab-label">Settings</span></a>
</div>
</div>
</header>
</div>

```html
<div class="pane-tabs">
  <div class="scrollable" role="tablist" aria-label="Primary fields">
    <a id="tab-content" class="sel" role="tab" href="#content" data-id="content"
       tabindex="0" aria-controls="content" aria-selected="true">
      <span class="tab-label">Content</span>
    </a>
    <a id="tab-seo" role="tab" href="#seo" data-id="seo"
       tabindex="-1" aria-controls="seo" aria-selected="false">
      <span class="tab-label">SEO</span>
    </a>
  </div>
</div>
```

Tab links carry no `.tab` class — the selected one gets `.sel`, and the label always sits in a `.tab-label` span. Craft also sets `data-id` to the panel's namespaced ID, which is what its JS reads when switching tabs; `aria-controls` carries the same value for assistive tech.

The `.tab-label` span is what gets the height and padding, not the link — it's `45px` tall, matching the header's `min-height`, which is how the tab fills the header edge to edge. `.sel` then paints the card: a white background, an *inset* `2px` bar across the top in `--gray-500`, a hairline ring, and a soft drop shadow. There's no bottom border anywhere; the illusion of the tab joining the body is just the white tab sitting over the header's own bottom rule with `z-index: 1`.

Only the selected tab is keyboard-focusable: it gets `tabindex="0"` while the rest get `-1`. That's a roving tabindex — arrow keys move between tabs, and Tab jumps out of the strip entirely. If you hand-write tabs and give every link `tabindex="0"`, keyboard users have to tab through all of them to escape.

## Tabs with errors

When a tab's panel contains invalid fields, Craft adds `.error` to the link and appends an alert icon inside the `.tab-label`, with visually-hidden text so the state isn't colour-only.

<div class="cp-demo" markdown="0">
<header class="pane-header" style="margin:0; border-radius:var(--radius-lg)">
<div class="pane-tabs">
<div class="scrollable" role="tablist">
<a class="sel" role="tab"><span class="tab-label">Content</span></a>
<a class="error" role="tab"><span class="tab-label">SEO <span data-icon="alert"><svg class="ic"><use href="#i-warning"></use></svg><span class="visually-hidden">This tab contains errors</span></span></span></a>
<a role="tab"><span class="tab-label">Settings</span></a>
</div>
</div>
</header>
</div>

```html
<a id="tab-seo" class="error" role="tab" href="#seo" data-id="seo"
   tabindex="-1" aria-controls="seo" aria-selected="false">
  <span class="tab-label">
    SEO
    <span data-icon="alert">
      <span class="visually-hidden">This tab contains errors</span>
    </span>
  </span>
</a>
```

`.error` and `.sel` combine — the current tab can also be the broken one. Craft routes both the bar and the label through custom properties (`--highlight-color`, `--tab-label-color`) and `.error` redefines them with `!important`, so a selected-and-invalid tab keeps its white card but turns its top bar and label red. Override `color` directly and you'll break that.

## The overflow menu

Every tab strip ships with a disclosure button and a duplicate menu of the same tabs. Craft renders the button with `.hidden` and only reveals it when the tabs don't fit their container, so it's invisible on most screens. The menu below is shown open for illustration.

<div class="cp-demo" markdown="0">
<div class="demo">
<button class="btn menubtn error" type="button" aria-label="List all tabs" title="List all tabs" aria-controls="tab-menu" data-disclosure-trigger="true"><span data-icon="alert"><svg class="ic"><use href="#i-warning"></use></svg></span></button>
<div class="menu menu--disclosure" style="margin-top:8px">
<ul class="padded">
<li><a class="sel" role="button">Content</a></li>
<li><a class="error" role="button">SEO <span data-icon="alert"><svg class="ic"><use href="#i-warning"></use></svg><span class="visually-hidden">This tab contains errors</span></span></a></li>
<li><a role="button">Settings</a></li>
</ul>
</div>
</div>
</div>

```html
<button type="button" class="btn menubtn hidden" title="List all tabs"
        aria-label="List all tabs" aria-controls="tab-menu" data-disclosure-trigger>
</button>

<div id="tab-menu" class="menu menu--disclosure">
  <ul class="padded">
    <li><a class="sel" data-id="content" role="button">Content</a></li>
    <li><a class="error" data-id="seo" role="button">SEO</a></li>
  </ul>
</div>
```

If any tab has errors, the trigger itself picks up `.error` and an alert icon — that's the only cue an off-screen tab is invalid, so don't strip it. Menu links use `role="button"` rather than `role="tab"`: they're not part of the tablist, and they carry the same `data-id` the strip does.

## In a pane header

On a real edit screen the strip isn't free-floating — it's docked into the [pane's](panes.md) header. The CP layout wraps the content card in `.content-pane` and, *only if* there are tabs or a content notice, renders a `.pane-header` above the body.

<div class="cp-demo" markdown="0">
<div class="content-pane">
<header class="pane-header">
<div class="pane-tabs">
<div class="scrollable" role="tablist">
<a class="sel" role="tab"><span class="tab-label">Content</span></a>
<a class="error" role="tab"><span class="tab-label">SEO <span data-icon="alert"><svg class="ic"><use href="#i-warning"></use></svg><span class="visually-hidden">This tab contains errors</span></span></span></a>
<a role="tab"><span class="tab-label">Settings</span></a>
</div>
</div>
</header>
<div class="field"><div class="heading"><label>Title</label></div><div class="input"><input class="text fullwidth" type="text" value="A flexible CMS"/></div></div>
</div>
</div>

```twig
<div id="content" class="content-pane">
  {% if contentNotice or tabs %}
    <header id="content-header" class="pane-header">
      {{ contentNotice ? tag('div', { id: 'content-notice', html: contentNotice, role: 'status' }) }}
      {% if tabs %}
        {% include "_includes/tabs" with { containerAttributes: { id: 'tabs' } } %}
      {% endif %}
    </header>
  {% endif %}

  {# … field layout … #}
</div>
```

The header is the card's own top edge, not a band inside it: Craft pulls it back out through the pane's padding with negative margins (`margin-inline: var(--neg-padding)`) so it meets the card edges, and rounds only its top corners. If you rebuild this by hand and forget the negative margins, you get a floating grey strip inset from the border.

Note the pane is `.content-pane`, not `.pane` — same card, but it owns the `--padding` the header's negative margins cancel out. The header renders only when there's something to put in it, so a tabless screen has no grey band at all.

!!! note
    **Slideouts nest one level deeper.** Element editor slideouts build the same header in JS rather than Twig, and insert a flex row between: `.pane-header > .so-toolbar > .pane-tabs`. The `so-` prefix is *slideout*, and it exists to sit the tabs next to the slideout's own controls. You won't find `.so-toolbar` in any template — style against `.pane-tabs` rather than the parent chain and both contexts keep working.

!!! note
    **In practice.** Most plugins never hand-write tabs — you declare them in a controller’s template `tabs` variable or a field layout, and Craft renders the markup and toggling behavior. Each entry takes `label`, `url`, and an optional `class` of `error`; the `_includes/tabs` template derives `.sel`, the roving tabindex, the alert icons, and the overflow menu from that.
