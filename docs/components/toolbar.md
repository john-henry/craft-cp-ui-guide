# Toolbar & search

The bar that sits above element indexes: a search box, filters, and view controls.

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<div class="toolbar">
<div class="search-container"><input class="text" placeholder="Search entries…" type="text"/><button class="clear-btn hidden" title="Clear"></button></div>
<div class="select-wrap" style="width:auto"><select class="select-el" style="width:auto"><option>All sections</option><option>News</option></select></div>
<span class="flex-grow"></span>
<button class="btn submit">New entry</button>
</div>
</div>
</div>

```html
<div class="toolbar">
  <div class="search-container">
    <input class="text" type="text" placeholder="Search…">
    <button class="clear-btn hidden" title="Clear"></button>
  </div>
  <div class="flex-grow"></div>
</div>
```

!!! note
    **The "New entry" button isn't toolbar markup.** Craft's element index injects the new-element button in JavaScript (as `.btn.add.icon`), not as a static template button, so you won't find it in `_elements/toolbar.twig`. The `.btn.submit` class is just the primary-button colour modifier, not specific to this button.
