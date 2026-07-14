# Entries & Assets fields

Relation fields (Entries, Assets, Categories, Tags, Users…) all render through the same `elementSelect` UI: a stack of selected elements plus an **Add** button that opens a selector modal. What that stack *looks* like is driven by the field’s settings — chiefly `viewMode`, `maxRelations`, and `selectionLabel` — so the same field type produces quite different UIs.


## Entries field — list view

The default. Related entries stack as draggable rows with a status dot and label. Here `maxRelations: 3` and a custom `selectionLabel`.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:430px">
<div class="heading"><label>Related products</label></div>
<div class="instructions">Up to 3 products shown as “you may also like”.</div>
<div class="input">
<div class="elementselect">
<div class="elements">
<div class="el-row"><span class="status on"></span><span class="el-label">Trail Runner GTX</span><svg class="ic move"><use href="#i-rule"></use></svg></div>
<div class="el-row"><span class="status on"></span><span class="el-label">Alpine Down Jacket</span><svg class="ic move"><use href="#i-rule"></use></svg></div>
</div>
<button class="btn add rel-add"><svg class="ic"><use href="#i-plus"></use></svg> Add a product</button>
</div>
</div>
</div>
</div>
</div>

```twig
{{ forms.elementSelectField({
    label: "Related products"|t("my-plugin"),
    id: "relatedProducts",
    name: "relatedProducts",
    elementType: "craft\\commerce\\elements\\Product",
    elements: entry.relatedProducts.all(),
    viewMode: "list",       // list · list-inline · cards · cards-grid · thumbs
    limit: 3,               // field's maxRelations
    selectionLabel: "Add a product"|t("my-plugin"),
    sources: ["*"],
}) }}
```


## Assets field — thumbnail view

Assets fields default to a thumbnail view. Note that `viewMode: "large"` is a legacy alias Craft remaps to `"thumbs"` (`BaseRelationField::normalizeConfig()`), so `"thumbs"` is the real value. With `maxRelations: 1` the field accepts a single image — a common “featured image” setup.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:430px">
<div class="heading"><label class="required">Featured image</label></div>
<div class="input">
<div class="elementselect">
<div class="el-thumbs">
<div class="el-thumb"><div class="pic"><svg class="ic"><use href="#i-image"></use></svg></div><div class="cap">hero-spring.jpg</div></div>
</div>
<button class="btn add rel-add"><svg class="ic"><use href="#i-plus"></use></svg> Choose an image</button>
</div>
</div>
</div>
</div>
</div>

```twig
{{ forms.elementSelectField({
    label: "Featured image"|t("my-plugin"),
    id: "featuredImage",
    name: "featuredImage",
    elementType: "craft\\elements\\Asset",
    elements: entry.featuredImage.all(),
    viewMode: "thumbs",     // thumbnails ("large" is a legacy alias)
    limit: 1,               // single selection
    selectionLabel: "Choose an image"|t("my-plugin"),
    sources: ["volume:uploads"],
    criteria: { kind: ["image"] },
}) }}
```


## Cards view

Set `viewMode: "cards"` for a richer chip that shows a thumbnail plus secondary metadata — useful when a plain label isn’t enough to tell related elements apart.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="elementselect">
<div class="el-card"><span class="pic"><svg class="ic"><use href="#i-image"></use></svg></span><div class="cbody"><span class="t">Alpine Down Jacket</span><span class="d">Outerwear · $289.00</span></div></div>
</div>
</div>
</div>

| Setting | PHP property | Effect |
| --- | --- | --- |
| View mode | `viewMode` | `list` · `list-inline` · `cards` · `cards-grid` · `thumbs` |
| Limit | `maxRelations` | Max related elements; `1` makes it single-select |
| Selection label | `selectionLabel` | Custom text on the Add button |
| Sources | `sources` | Which sections / volumes / groups can be picked from |
| Show site menu | `showSiteMenu` | Let authors relate elements from other sites |
| Maintain hierarchy | `maintainHierarchy` | (Structures) keep selections in tree order; pair with `branchLimit` |
| Preview mode | `previewMode` (Assets) | `full` shows the filename label; `thumbs` is image-only |

!!! note
    **Same UI for custom element types.** If your plugin defines its own element, a relation field pointing at it renders with this exact `elementSelect`. Override your element’s `attributeHtml()`, `getChipLabelHtml()`, and `getCardBodyHtml()` (on `craft\base\Element`) to control how it appears in each view mode. (There is no `chipHtml()` / `cardHtml()` to override — those are static renderers on `craft\helpers\Cp`.)
