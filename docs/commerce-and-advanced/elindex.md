# Element index page

The biggest win for a plugin that manages its own element type: don’t rebuild the listing UI — extend Craft’s. A one-line template gives you sources, search, filters, view modes, pagination, and bulk actions. This is exactly how the Shopify plugin lists products.

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<div class="el-index">
<div class="el-sources"><span class="src sel">All products</span><span class="src">Active</span><span class="src">Draft</span><span class="src">Archived</span></div>
<div class="el-toolbar"><div class="search" style="max-width:220px"><input placeholder="Search…" type="text"/></div><span style="flex:1"></span><a class="btn submit"><svg class="ic"><use href="#i-external"></use></svg> New product</a></div>
<table class="data" style="border:0; border-radius:0">
<thead><tr><th>Title</th><th>Status</th><th>Options</th><th>Variants</th></tr></thead>
<tbody>
<tr><td>Field Notes Notebook</td><td><span class="status-label green"><span class="status"></span><span class="status-label-text">Active</span></span></td><td><span class="token">Color</span> <span class="token">Size</span></td><td>4</td></tr>
<tr><td>Enamel Pin</td><td><span class="status-label gray"><span class="status"></span><span class="status-label-text">Draft</span></span></td><td><span class="token">Style</span></td><td>2</td></tr>
</tbody>
</table>
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
