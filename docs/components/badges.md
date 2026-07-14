# Badges, chips & tokens

**Badges** show counts. **Chips** represent an element (entry, asset, user) with a thumbnail. **Tokens** are compact tag-like labels.

<div class="cp-demo" markdown="0">
<div class="demo row" style="align-items:center; gap:22px">
<span style="display:inline-flex; align-items:center; gap:8px">Entries <span class="badge">128</span></span>
<span class="chip"><span class="thumb"></span> Homepage Hero</span>
<span class="token">news</span>
<span class="token">featured</span>
</div>
</div>

```html
<span class="badge">128</span>

<div class="chip">
  <div class="thumb"></div>
  <div class="label">Homepage Hero</div>
</div>
```

!!! note
    **Prefer the helper.** For real elements, render chips with `craft\helpers\Cp::elementChipHtml($element)` (or `elementCardHtml()`) so thumbnails, statuses, and context menus come along automatically.
