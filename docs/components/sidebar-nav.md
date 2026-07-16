# Inner sidebar menus

Distinct from the dark global sidebar, many CP screens have a **secondary nav** in the left gutter — Settings, Utilities, and any plugin section with sub-pages. It sits transparently in the page margin (no card), and you build it by filling the layout’s `sidebar` block with the `_includes/nav` include.

The layout wraps it in `<div id="sidebar" class="sidebar">`, and a `heading` item **nests** its group in a child `<ul>` inside the same `<li class="heading">` — the items aren't flat siblings after the header.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="cp-sidebar-frame">
<div class="sidebar">
<nav aria-label="Settings">
<ul>
<li class="heading"><span>System</span>
<ul>
<li><a aria-current="page" class="sel" href="#">General</a></li>
<li><a href="#">Sites</a></li>
<li><a href="#">Routes</a></li>
</ul>
</li>
<li class="heading"><span>Content</span>
<ul>
<li><a href="#">Fields</a></li>
<li><a href="#">Entry Types</a></li>
<li><a href="#">Sections</a></li>
</ul>
</li>
</ul>
</nav>
</div>
<div class="content-stub">Main content pane — the selected page renders here.</div>
</div>
</div>
</div>

```twig
{# In your CP layout / template #}
{% block sidebar %}
    {% include "_includes/nav" with {
        label: "Settings"|t("my-plugin"),
        items: navItems,
        selectedItem: selectedNavItem,   {# a key from navItems #}
    } only %}
{% endblock %}
```

```twig title="the items hash"
{% set navItems = {
    general: { label: "General"|t("my-plugin"), url: url("my-plugin/general") },
    sites:   { label: "Sites"|t("my-plugin"),   url: url("my-plugin/sites") },

    {# A heading groups the items nested under it #}
    contentHeading: {
        heading: "Content"|t("my-plugin"),
        nested: {
            fields:   { label: "Fields",   url: url("my-plugin/fields") },
            sections: { label: "Sections", url: url("my-plugin/sections") },
        },
    },
} %}
```

```html title="HTML output"
<nav aria-label="Settings">
  <ul>
    <li class="heading"><span>Content</span>
      <ul>
        <li><a class="sel" href="…" aria-current="page">Fields</a></li>
      </ul>
    </li>
  </ul>
</nav>
```

| Key | Purpose |
| --- | --- |
| `label` | Link text for a nav item |
| `url` | Destination (wrap in `url()`) |
| `heading` + `nested` | A section header with its own group of items below it |
| `selected` | Force an item’s selected state (otherwise driven by `selectedItem`) |

!!! note
    **Selection & accessibility.** Pass `selectedItem` the key of the active page; the include adds `class="sel"` and `aria-current="page"` to the matching link. The selected link fills with `--gray-500` and white text — the same treatment as the global sidebar — so the two nav levels feel consistent.

!!! note
    **Badges need hand-written markup.** Craft styles `.sidebar nav li a .badge`, so a count pill in a nav link is a real pattern — but `_includes/nav` renders links with `text: item.label`, which HTML-escapes. Passing `"Sections <span class='badge'>6</span>"` as a label prints the tags literally. If you need a badge, write the `<nav>` yourself rather than fighting the include.

!!! note
    **Related: index sources.** Element index screens use a similar left column, but built from *sources* (with counts, statuses, and nested groups) rather than plain links. If your plugin has an [element index](../commerce-and-advanced/elindex.md), define those in your element type’s `defineSources()` instead of hand-writing this nav.
