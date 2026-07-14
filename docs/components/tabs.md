# Tabs

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<div class="tabs"><div class="tab sel">Content</div><div class="tab">SEO</div><div class="tab">Settings</div></div>
</div>
</div>

```html
<div id="tabs" class="tabs">
  <a class="tab sel" href="#content">Content</a>
  <a class="tab" href="#seo">SEO</a>
</div>
```

!!! note
    **In practice.** Most plugins never hand-write tabs — you declare them in a controller’s template `tabs` variable or a field layout, and Craft renders the markup and toggling behavior.
