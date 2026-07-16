# Entries & Assets fields

Relation fields (Entries, Assets, Categories, Tags, Users…) all render through the same `elementSelect` UI: a stack of selected elements plus an **Add** button that opens a selector modal. What that stack *looks* like is driven by the field’s settings — chiefly `viewMode`, `maxRelations`, and `selectionLabel` — so the same field type produces quite different UIs.


## Entries field — list view

The default. Related entries stack as draggable chips with a status dot and label. Here `maxRelations: 3` and a custom `selectionLabel`.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:430px">
<div class="heading"><label>Related products</label></div>
<div class="instructions">Up to 3 products shown as “you may also like”.</div>
<div class="input">
<div class="elementselect">
<ul class="elements chips chips-small">
<li><div class="chip small element removable" data-type="craft\commerce\elements\Product" data-id="1063"><div class="chip-content"><span class="status enabled" role="img" aria-label="Status: Enabled"></span><craft-element-label class="label"><span class="label-link">Trail Runner GTX</span></craft-element-label><div class="chip-actions"><button class="btn action-btn small" type="button" aria-label="Actions" data-disclosure-trigger="true" data-icon="ellipsis" aria-expanded="false"><div class="cp-icon"><svg class="ic"><use href="#i-ellipsis"></use></svg></div></button><button class="btn chromeless small move-btn" type="button" title="Reorder" aria-label="Reorder"><div class="inline-flex gap-xs"><div class="cp-icon"><svg class="ic"><use href="#i-move"></use></svg></div></div></button></div><input type="hidden" name="fields[relatedProducts][]" value="1063"/></div></div></li>
<li><div class="chip small element removable" data-type="craft\commerce\elements\Product" data-id="1062"><div class="chip-content"><span class="status enabled" role="img" aria-label="Status: Enabled"></span><craft-element-label class="label"><span class="label-link">Alpine Down Jacket</span></craft-element-label><div class="chip-actions"><button class="btn action-btn small" type="button" aria-label="Actions" data-disclosure-trigger="true" data-icon="ellipsis" aria-expanded="false"><div class="cp-icon"><svg class="ic"><use href="#i-ellipsis"></use></svg></div></button><button class="btn chromeless small move-btn" type="button" title="Reorder" aria-label="Reorder"><div class="inline-flex gap-xs"><div class="cp-icon"><svg class="ic"><use href="#i-move"></use></svg></div></div></button></div><input type="hidden" name="fields[relatedProducts][]" value="1062"/></div></div></li>
</ul>
<div class="flex">
<button class="btn add icon dashed wrap" type="button"><svg class="ic"><use href="#i-plus"></use></svg> Add a product</button>
</div>
</div>
</div>
</div>
</div>
</div>

```{ .html .annotate }
<ul class="elements chips chips-small"> <!-- (1)! -->
  <li>
    <div id="chip-1897433908" class="chip small element removable" <!-- (2)! -->
         data-type="craft\elements\Category" data-id="1063" data-label="Special Events"
         data-status="enabled" data-cp-url="…" data-editable data-deletable>
      <div class="chip-content">
        <span class="status enabled" role="img" aria-label="Status: Enabled"></span>
        <craft-element-label id="chip-1897433908-label" class="label"> <!-- (3)! -->
          <span class="label-link">Special Events</span>
        </craft-element-label>
        <div class="chip-actions"> <!-- (4)! -->
          <button type="button" class="btn action-btn small" data-icon="ellipsis"
                  aria-label="Actions" data-disclosure-trigger="true" aria-expanded="false"></button>
          <button type="button" class="btn chromeless small move-btn" title="Reorder"
                  aria-label="Reorder" aria-describedby="chip-1897433908-label">
            <div class="inline-flex gap-xs"><div class="cp-icon"><!-- svg --></div></div>
          </button>
        </div>
        <input type="hidden" name="fields[newsCategory][]" value="1063"> <!-- (5)! -->
      </div>
    </div>
  </li>
</ul>
```

1.  One chip per `<li>`. The `<ul>` carries **three** classes — `elements chips chips-small` — and `.chips` is a flex column.
2.  **Four** classes, from two different places. `chip` and `small` come from `Cp::chipHtml()`; `element` and `removable` come from `baseElementAttributes()`. `removable` appears **only** when `context: 'field'` — it's what puts the × on hover. An invalid element picks up `error` the same way.
3.  **Not `.chip-label`.** `Cp::chipHtml()` produces that generically, but `elementChipHtml()` overrides it with this `<craft-element-label>` custom element wrapping a `.label-link` span. Style `.chip .label` or you'll miss every element chip.
4.  Pushed to the trailing edge with `margin-inline-start: auto` — there's no spacer element. The `⋯` is a [disclosure menu](menus.md) trigger.
5.  **Inside `.chip-content`**, not a sibling. Remove the chip and the value goes with it — that's how the field posts its selection.

The chip's hairline is a `::before` overlay rather than a border, which is how it sits above the thumb without the corners poking through.

!!! note
    **`align-items: flex-start` is what makes chips hug.** `.chips` is a flex column, so without it every `<li>` stretches and each chip runs the full field width. Craft sets `.chips{align-items:flex-start; gap:var(--xs)}` — if your chips look like full-width bars instead of pills, that's the missing declaration.

The **Add** button is a *dashed ghost* button — `btn add icon dashed wrap` — not the solid grey `.btn` default. Once `elements|length >= limit` Craft adds `.hidden` to it rather than removing it.

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

## The search input

When a field passes `searchCriteria`, Craft renders a search box **beside** the Add button inside a shared `.flex` row. Without `searchCriteria` there's no search box at all, which is why some relation fields have one and others don't.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:430px">
<div class="heading"><label>Featured exhibits</label></div>
<div class="instructions">Will be displayed in a random order.</div>
<div class="input">
<div class="elementselect">
<ul class="elements chips chips-small"></ul>
<div class="flex">
<button class="btn add icon dashed wrap" type="button"><svg class="ic"><use href="#i-plus"></use></svg> Add an entry</button>
<div class="texticon search icon elementselect__search-input-wrapper"><svg class="ic"><use href="#i-search"></use></svg><input class="text" placeholder="Search" role="combobox" type="text"/></div>
</div>
</div>
</div>
</div>
</div>
</div>

```twig
{{ forms.elementSelectField({
    label: "Featured exhibits"|t("my-plugin"),
    name: "featuredExhibits",
    elementType: "craft\\elements\\Entry",
    elements: entry.featuredExhibits.all(),
    selectionLabel: "Add an entry"|t("my-plugin"),
    searchCriteria: { section: "exhibits" },
}) }}
```


## Assets field — thumbnail view

Assets fields default to a thumbnail view. Note that `viewMode: "large"` is a legacy alias Craft remaps to `"thumbs"` (`BaseRelationField::normalizeConfig()`), so `"thumbs"` is the real value. With `maxRelations: 1` the field accepts a single image — a common “featured image” setup.

There's no thumbnail template. `thumbs` reuses the **same list** as the default view with `size: "large"` and `inline: true`, so you get `<ul class="elements chips chips-large inline-chips">` — a grid of `auto-fill` columns, each holding a `.chip.large` that stacks its 120px thumb above the label. Same chip, different axis.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:430px">
<div class="heading"><label>Featured image<span class="visually-hidden">Required</span><span class="required" aria-hidden="true"></span></label></div>
<div class="input">
<div class="elementselect">
<ul class="elements chips chips-large inline-chips">
<li><div class="chip large element removable" data-type="craft\elements\Asset"><div class="thumb"><svg class="ic"><use href="#i-image"></use></svg></div><div class="chip-content"><craft-element-label class="label"><span class="label-link">hero-spring.jpg</span></craft-element-label></div></div></li>
</ul>
<div class="flex">
<button class="btn add icon dashed wrap" type="button"><svg class="ic"><use href="#i-plus"></use></svg> Choose an image</button>
</div>
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

Set `viewMode: "cards"` for a richer element that shows a heading plus body content — useful when a plain label isn’t enough to tell related elements apart. Cards are a different template (`_elements/cards.twig`) and a different renderer (`Cp::elementCardHtml()`), not a bigger chip.

A card is a `.card-titlebar` strip — element icon, type label, and actions — sitting over a `.card-main` grid that holds `.card-content` (a `.card-heading` and `.card-body`) alongside the thumb.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="elementselect">
<ul class="elements cards">
<li>
<div class="card thumb-end">
<div class="card-titlebar">
<div class="flex flex-nowrap flex-gap-s"><div class="cp-icon small" aria-hidden="true"><svg class="ic"><use href="#i-image"></use></svg></div><div class="card-titlebar-label">Product</div></div>
<div class="card-actions-container"><div class="card-actions"><button class="btn chromeless small edit-btn" title="Edit product" aria-label="Edit product"><svg class="ic"><use href="#i-gear"></use></svg></button></div></div>
</div>
<div class="card-main">
<div class="card-content">
<div class="card-heading">Alpine Down Jacket</div>
<div class="card-body">Outerwear · $289.00</div>
</div>
</div>
</div>
</li>
</ul>
</div>
</div>
</div>

```twig
{{ forms.elementSelectField({
    label: "Related products"|t("my-plugin"),
    name: "relatedProducts",
    elementType: "craft\\commerce\\elements\\Product",
    elements: entry.relatedProducts.all(),
    viewMode: "cards",      // "cards-grid" emits <ul class="card-grid"> instead
}) }}
```

`viewMode: "cards"` stacks the cards in a column; `"cards-grid"` swaps the container class to `card-grid` — note the class is `card-grid`, singular, while the view mode is `cards-grid`. The grid auto-fills at a 300px minimum, against 160px for the thumbs grid.

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
