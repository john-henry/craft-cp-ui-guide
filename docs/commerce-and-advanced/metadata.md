# Metadata sidebar

The read-only label/value list shown in element edit sidebars (post date, author, Shopify ID, sync status…). It’s a definition list, not a table, so screen readers pair each label with its value. Build one with `Cp::metadataHtml()`.

<div class="cp-demo" markdown="0">
<div class="demo" style="max-width:340px">
<dl class="meta read-only">
<div class="data"><dt class="heading">Status</dt><dd class="value"><span class="status-label green"><span class="status"></span><span class="status-label-text">Active</span></span></dd></div>
<div class="data"><dt class="heading">Shopify ID</dt><dd class="value">80412…9931</dd></div>
<div class="data"><dt class="heading">Last synced</dt><dd class="value">2 minutes ago</dd></div>
<div class="data"><dt class="heading">Variants</dt><dd class="value">4</dd></div>
</dl>
</div>
</div>

```php
Cp::metadataHtml([
    Craft::t('shopify', 'Shopify ID') => $product->shopifyId,
    Craft::t('shopify', 'Last synced') => $product->dateSynced,
    Craft::t('shopify', 'Variants') => count($product->variants),
]);
// Return this from your element's getSidebarHtml()
```

```html title="HTML output"
<dl class="meta read-only">
  <div class="data">
    <dt class="heading">Shopify ID</dt>
    <dd class="value">80412…9931</dd>
  </div>
</dl>
```
