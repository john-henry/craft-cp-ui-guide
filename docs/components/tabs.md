# Tabs

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<div class="pane-tabs">
<div class="scrollable" role="tablist">
<a class="sel" role="tab"><span class="tab-label">Content</span></a>
<a role="tab"><span class="tab-label">SEO</span></a>
<a role="tab"><span class="tab-label">Settings</span></a>
</div>
</div>
</div>
</div>

```html
<div class="pane-tabs">
  <div class="scrollable" role="tablist" aria-label="Primary fields">
    <a id="tab-content" class="sel" role="tab" href="#content"
       aria-controls="content" aria-selected="true">
      <span class="tab-label">Content</span>
    </a>
    <a id="tab-seo" role="tab" href="#seo"
       aria-controls="seo" aria-selected="false">
      <span class="tab-label">SEO</span>
    </a>
  </div>
</div>
```

Tab links carry no `.tab` class — the selected one gets `.sel`, and the label always sits in a `.tab-label` span.

!!! note
    **In practice.** Most plugins never hand-write tabs — you declare them in a controller’s template `tabs` variable or a field layout, and Craft renders the markup and toggling behavior.
