# Element index page

The biggest win for a plugin that manages its own element type: don’t rebuild the listing UI — extend Craft’s. A one-line template gives you sources, search, filters, view modes, pagination, and bulk actions. This is exactly how the Shopify plugin lists products.

Craft renders it in two blocks: **sources** go in the layout's `sidebar`, and the listing sits in
`<div class="main element-index">` in the content block.

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<div class="cp-sidebar-frame">
<div class="sidebar">
<ul class="sources-list">
<li><div class="source-item source-item--link"><a role="button" tabindex="0" data-key="*"><span class="label">All products</span></a></div></li>
<li class="heading">
<div class="source-item source-item--heading"><span class="type-heading-small">Channels</span>
<craft-disclosure persist storage-key="sources-list:channels"><button class="source-item__toggle" type="button" aria-controls="sources-list-1" aria-expanded="true"><span class="cp-icon puny"><svg class="ic"><use href="#i-angle-down"></use></svg></span><span class="visually-hidden">Expand Channels sources</span></button></craft-disclosure>
</div>
<ul class="sources-list" id="sources-list-1">
<li><div class="source-item source-item--link"><a class="sel" role="button" tabindex="0" data-key="active"><span class="label">Active</span><span class="badge" aria-hidden="true">12</span></a></div></li>
<li><div class="source-item source-item--link"><a role="button" tabindex="0" data-key="draft"><span class="label">Draft</span></a></div></li>
<li><div class="source-item source-item--link"><a role="button" tabindex="0" data-key="archived"><span class="label">Archived</span></a></div></li>
</ul>
</li>
</ul>
</div>
<div class="main element-index">
<div class="toolbar flex"><div class="search-container" style="max-width:220px"><input placeholder="Search…" type="text"/></div><span style="flex:1"></span><a class="btn submit"><svg class="ic"><use href="#i-external"></use></svg> New product</a></div>
<table class="data" style="border:0; border-radius:0">
<thead><tr><th>Title</th><th>Status</th><th>Options</th></tr></thead>
<tbody>
<tr><td>Field Notes Notebook</td><td><span class="status-label green"><span class="status"></span><span class="status-label-text">Active</span></span></td><td><span class="token">Color</span></td></tr>
<tr><td>Enamel Pin</td><td><span class="status-label gray"><span class="status"></span><span class="status-label-text">Draft</span></span></td><td><span class="token">Style</span></td></tr>
</tbody>
</table>
</div>
</div>
</div>
</div>

```twig title="templates/products/_index.twig"
{% extends "_layouts/elementindex" %}
{% set title = "Products"|t("my-plugin") %}
{% set elementType = "myplugin\\elements\\Product" %}

{# Add your own toolbar button without losing Craft's #}
{% block toolbar %}
    {{ parent() }}
    <a class="btn submit" data-icon="external" href="{{ newProductUrl }}">
        {{ "New Product"|t("my-plugin") }}
    </a>
{% endblock %}
```

!!! note
    **Custom columns.** Define the columns in your element class with `defineTableAttributes()`, then render each cell by overriding `attributeHtml($attribute)` — return a status label, an external-link icon (`Html::a('', $url, ['data' => ['icon' => 'external']])`), or plain text. That’s the entire recipe behind the Shopify products table above.

## Sources

You define sources in PHP; `_elements/sources.twig` renders them. It's worth knowing the shape,
because it's the part people try (and fail) to restyle.

```html
<ul class="sources-list">
  <li>
    <div class="source-item source-item--link">
      <a role="button" tabindex="0" data-key="*" data-source-item data-criteria="{}">
        <span class="label">All products</span>
        <span class="badge" aria-hidden="true">12</span>
      </a>
    </div>
  </li>

  <li class="heading">
    <div class="source-item source-item--heading">
      <span class="type-heading-small">Channels</span>
      <craft-disclosure persist storage-key="sources-list:channels">
        <button type="button" class="source-item__toggle" aria-controls="sources-list-1" aria-expanded="true">
          <span class="cp-icon puny"><!-- angle-down --></span>
          <span class="visually-hidden">Expand Channels sources</span>
        </button>
      </craft-disclosure>
    </div>
    <ul id="sources-list-1" class="sources-list">…</ul>
  </li>
</ul>
```

A source link is an **`<a>` with no `href`** — `role="button"` and `tabindex="0"`, driven by
`data-key`. Every option you set in `defineSources()` rides along as a `data-` attribute
(`data-criteria`, `data-has-thumbs`, `data-default-sort`, `data-sites`…), which is how the JS
configures the index when you click one.

The label is a `.label` span, not bare text, and a `badgeCount` renders **twice** — a visual
`.badge` marked `aria-hidden`, plus a visually-hidden span with the real sentence, so screen
readers get "12 notifications" rather than "12".

Headings nest their group in a child `<ul class="sources-list">` **inside the same
`<li class="heading">`** — the same pattern as the [settings nav](../components/sidebar-nav.md).

### Collapsing

The toggle is a `<craft-disclosure>` custom element wrapping a button, with `persist` and a
`storage-key`, so a collapsed group **stays collapsed across page loads** (localStorage by
default; `storage-mode="cookies"` is also supported).

Collapsed state is driven by `data-state="collapsed"` on the `<ul>`, and the rule is smarter
than hiding everything:

```css
.sources-list[data-state=collapsed] li:not(:has(.sel)){display:none}
```

The **selected** source stays visible even when its group is collapsed — you never lose sight of
where you are. A blank heading gets no toggle at all.

Nested (structure) sources get `li.collapsible`, and `.collapsible .sources-list:before` draws
the 1px vertical guide line down the group, positioned at half the toggle width.

!!! note
    **You don't write any of this.** `_layouts/elementindex` renders it from your element's
    `defineSources()`. The markup above is for when you need to *target* it — and the demo is
    static, so the disclosure toggles don't actually collapse here.
