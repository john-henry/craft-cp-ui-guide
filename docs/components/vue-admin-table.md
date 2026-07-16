# Vue admin tables

`Craft.VueAdminTable` is the listing UI behind almost every **settings** screen — Sections,
Fields, Entry Types, Filesystems, GraphQL schemas. If your plugin has a "list of things I
manage" page, this is what Craft uses, and it gives you sorting, pagination, search, reordering,
bulk actions, and delete confirmation for a page of config.

It is **not** an [element index](../commerce-and-advanced/elindex.md). Element indexes are for
elements; admin tables are for everything else. Reach for the element index if your rows are
elements, and this if they aren't.

It's a Vue component with no Twig macro — you register the asset bundle, drop an empty container
in your template, and construct it in a `{% js %}` block.

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<div class="vue-admin-table">
<div class="tableview tablepane">
<table class="data">
<thead><tr><th>Name</th><th>Handle</th><th>Type</th><th></th></tr></thead>
<tbody>
<tr><td class="cell-bold"><a href="#">News</a></td><td><code>news</code></td><td>Channel</td><td class="thin"><svg class="ic"><use href="#i-x"></use></svg></td></tr>
<tr><td class="cell-bold"><a href="#">Blog</a></td><td><code>blog</code></td><td>Channel</td><td class="thin"><svg class="ic"><use href="#i-x"></use></svg></td></tr>
<tr><td class="cell-bold"><a href="#">Docs</a></td><td><code>docs</code></td><td>Structure</td><td class="thin"><svg class="ic"><use href="#i-x"></use></svg></td></tr>
</tbody>
</table>
</div>
</div>
</div>
</div>

## Setup

```twig
{% extends "_layouts/cp" %}
{% set title = "Widgets"|t('my-plugin') %}

{% do view.registerAssetBundle('craft\\web\\assets\\admintable\\AdminTableAsset') %}

{% block content %}
    <div id="widgets-vue-admin-table"></div>
{% endblock %}

{% js %}
    (() => {
        const columns = [
            { name: '__slot:title',  title: Craft.t('my-plugin', 'Name'),   sortField: true },
            { name: '__slot:handle', title: Craft.t('my-plugin', 'Handle'), sortField: true },
            { name: 'type',          title: Craft.t('my-plugin', 'Type'),   sortField: true },
        ];

        new Craft.VueAdminTable({
            columns,
            container: '#widgets-vue-admin-table',
            emptyMessage: Craft.t('my-plugin', 'No widgets exist yet.'),
            tableDataEndpoint: 'my-plugin/widgets/table-data',
            deleteAction: 'my-plugin/widgets/delete',
            deleteConfirmationMessage: Craft.t('my-plugin', 'Are you sure you want to delete “{name}”?'),
        });
    })();
{% endjs %}
```

That's the whole pattern, and it's exactly what `settings/sections/_index.twig` does. Wrapping
it in an IIFE keeps `columns` out of the global scope — Craft's own templates do the same.

Strings must be registered for JS translation up front, or `Craft.t()` returns the source
string:

```twig
{% do view.registerTranslations('my-plugin', ["Name", "Handle", "Type", "No widgets exist yet."]) %}
```

## Data mode vs API mode

Two ways to feed the table, and the choice costs you features.

**Data mode** — pass rows straight to `tableData`. Simple, but **no column sorting and no
pagination**. Fine for a short, bounded list.

```js
new Craft.VueAdminTable({
    columns,
    container: '#widgets-vue-admin-table',
    tableData: [{ id: 1, title: 'News', handle: 'news' }],
});
```

**API mode** — point `tableDataEndpoint` at a controller action. You get sorting and
pagination, but your controller must return this exact shape:

```php
return $this->asJson([
    'pagination' => [
        'total' => (int)$total,
        'per_page' => (int)$limit,
        'current_page' => (int)$page,
        'last_page' => (int)$lastPage,
        'next_page_url' => $nextPageUrl,
        'prev_page_url' => $prevPageUrl,
        'from' => (int)$from,
        'to' => (int)$to,
    ],
    'data' => $rows,
]);
```

Each row's array keys map to column `name`s. With `sortField: true`, the sort arrives as
`{field}|{direction}` — e.g. `email|asc`.

`search` behaves differently per mode too: in data mode it filters client-side across the
attributes you list in `searchParams`; in API mode it's handed to your endpoint and **you**
implement it.

## Columns

| Key | Description |
| --- | --- |
| `name` | Handle of the column, matched against the row data's key |
| `title` | Display title in the header |
| `titleClass` | Class added to the header cell *(optional)* |
| `dataClass` | Class added to the data cell *(optional)* |
| `callback` | Function to transform the cell output — receives the attribute's value |
| `sortField` | Field name to sort on. **API mode only** *(optional)* |

### Special columns

Prefix `name` with `__slot:` for the four built-in column types.

| Slot | Renders |
| --- | --- |
| `__slot:title` | Title cell like an element index — supports `icon`, `iconColor`, `status`, `title`, and `url` in the row data |
| `__slot:handle` | The handle, wrapped in `<code>` |
| `__slot:menu` | A dropdown link menu inside the cell |
| `__slot:detail` | A clickable toggle revealing an expandable detail row beneath its parent |

`__slot:detail` takes its own row-data object:

| Attribute | Description |
| --- | --- |
| `handle` | HTML for the clickable toggle. Omit for an "info" icon *(optional)* |
| `title` | `title` attribute on the toggle *(optional)* |
| `content` | HTML for the detail row — or an array, with `showAsList` |
| `showAsList` | Default `false`. With an array `content`, renders a key → value list *(optional)* |

### Column callback

```js
const columns = [
    {
        name: 'myColumn',
        title: Craft.t('site', 'My Column'),
        callback: function(value) {
            if (value) {
                return '<span data-icon="check" title="' + Craft.t('app', 'Yes') + '"></span>';
            }
            return '';
        },
    },
];
```

## All options

Every option `Craft.VueAdminTable` accepts.

### Data & display

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `columns` | Array | `[]` | Defines the table columns |
| `container` | String | `null` | CSS selector for the element to mount on |
| `tableData` | Array | `null` | Rows for **data mode** |
| `tableDataEndpoint` | String | `null` | Endpoint for **api mode** — returns data, pagination, and metadata |
| `perPage` | Int | `null` | Rows per page. Used with `tableDataEndpoint` |
| `emptyMessage` | String | `No data available.` | Shown when there are no rows |
| `itemLabels` | Object | `{singular: Item, plural: Items}` | Singular/plural names for pagination counts |
| `minItems` | Int | `null` | Minimum number of items allowed in the table |
| `fullPage` | Bool | `false` | Set true when the table is the only element on the template |
| `fullPane` | Bool | `true` | Set **false** when the table isn't the only UI component in its pane |
| `padded` | Bool | `false` | Adds padding around the table |

### Selection

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `checkboxes` | Bool | `false` | Show the checkbox column |
| `checkboxStatus` | Function | `true` | Callback per row — return `false` to disable that row's checkbox |
| `allowMultipleSelections` | Bool | `true` | When false, hides the select-all checkbox |
| `allowMultipleDeletions` | Bool | `true` | Whether multiple rows can be deleted at once |

### Search

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `search` | Bool | `false` | Show the search field |
| `searchParams` | Array | `[]` | Attributes to search across — **data mode only** |
| `searchPlaceholder` | String | `Search` | Placeholder text |
| `searchClear` | String | `Clear` | Title of the clear button |
| `noSearchResults` | String | `No results` | Empty-search text |

### Deleting

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `deleteAction` | String | `null` | Action URL to post to. **Enables the delete buttons when set** |
| `deleteCallback` | Function | `null` | Runs after deletion — receives the deleted row's ID |
| `deleteConfirmationMessage` | String | `Are you sure you want to delete “{name}”?` | Confirmation prompt |
| `deleteSuccessMessage` | String | `“{name}” deleted.` | Success notice |
| `deleteFailMessage` | String | `Couldn’t delete “{name}”.` | Failure notice |
| `beforeDelete` | Function | resolves `true` | Returns a `Promise<boolean>` deciding whether the delete proceeds |

### Reordering

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `reorderAction` | String | `null` | Action URL. **Drag handles appear when set** |
| `paginatedReorderAction` | String | `null` | Reorder action for paginated data |
| `moveToPageAction` | String | `null` | Action URL for moving an item to another page |
| `reorderSuccessMessage` | String | `Items reordered` | Success notice |
| `reorderFailMessage` | String | `Couldn’t reorder items` | Failure notice |

### Actions & buttons

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `actions` | Array | `[]` | Action buttons in the table toolbar |
| `footerActions` | Array | `[]` | Action buttons in the table footer |
| `buttons` | Array | `[]` | Link buttons in the toolbar |

Several options are switches disguised as strings: `deleteAction`, `reorderAction`, and
`moveToPageAction` each **turn their feature on** by being non-null. There's no `deletable: true`.

## Action buttons

Used with `checkboxes` for singular or bulk operations. An entry is either a menu button with
sub-actions, or a single action button.

**Menu button:** `label`, `icon` *(optional)*, and `actions` — an array of sub-actions.

**Sub-action / single action button:**

| Name | Type | Description |
| --- | --- | --- |
| `label` | String | Title to show |
| `action` | String | Action URI to post to |
| `param` | String | Name of the post parameter |
| `value` | String | Value posted with `param` |
| `ajax` | Bool | Post via Ajax |
| `status` | String | Status icon for the button |
| `allowMultiple` | Bool | Whether it can run with multiple items selected |
| `separator` | Bool | Adds a separating line above. **Menu sub-actions only** |

Single action buttons take all of these *except* `separator`.

## Buttons

Simple links in the top right of the toolbar — despite the name, they're anchors.

| Name | Description |
| --- | --- |
| `label` | Link label |
| `icon` | Link icon *(optional)* |
| `href` | The `href` attribute |
| `enabled` | Boolean, or a callback returning one |

```js
new Craft.VueAdminTable({
    buttons: [
        {
            label: 'Create New Thing',
            icon: 'plus',
            href: '{{ cpUrl("my-plugin/thing/new") }}',
            enabled: () => true,
        },
    ],
});
```

## Events

Pass these as options.

| Event | Data | Fires |
| --- | --- | --- |
| `onLoaded` | — | Table has loaded, regardless of data loading |
| `onLoading` | — | Table enters a loading state |
| `onData` | Array of objects | Successful load or page change |
| `onSelect` | Array of IDs | A checkbox or select-all changes |
| `onPagination` | Object | Pagination loaded, including first load |
| `onQueryParams` | Object | Query params are being built — **return the object** |
| `onCellClicked` | data, field, event | Cell click |
| `onCellDoubleClicked` | data, field, event | Cell double-click |
| `onRowClicked` | data, event | Row click |
| `onRowDoubleClicked` | data, event | Row double-click |

`onQueryParams` is the one with a return value — it's your hook for adding filters to the
endpoint request:

```js
new Craft.VueAdminTable({
    onQueryParams: function(params) {
        params.foo = 'bar';
        return params;
    },
});
```

## Properties & methods

| Name | |
| --- | --- |
| `instance` | The Vue instance — the table is wrapped in a skeleton Vue app |
| `$table` | The `VueAdminTable` component instance, for direct access to its properties and methods |
| `reload()` | Reload the table data |

```js
const adminTable = new Craft.VueAdminTable({ /* … */ });

setInterval(() => adminTable.reload(), 15000);
```

## Before delete

`beforeDelete` receives the row `id` and returns a `Promise<boolean>` — resolve `false` to
cancel. Useful for a secondary confirmation or a server-side check:

```js
new Craft.VueAdminTable({
    beforeDelete: id => {
        return new Promise(function (resolve) {
            setTimeout(() => {
                resolve(id > 99);
            }, 1500);
        });
    },
});
```

!!! note
    **The preview is a static stand-in.** Everything here is rendered by Vue at runtime —
    there's no server-side markup to copy. The demo above is hand-written HTML using the classes
    the component produces (`.vue-admin-table`, `.tableview`, `table.data`, `.cell-bold`) so you
    can see the shape, but you never write this markup yourself. Your template contributes one
    empty `<div>`.

!!! note
    **Craft documents this one itself.** Unusually, the component ships with its own README at
    `src/web/assets/admintable/README.md` in `craftcms/cms`. This page is drawn from it plus the
    5.10 source; if something here looks stale, that file is the place to check.
