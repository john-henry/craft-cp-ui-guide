# Menus

The disclosure menu is the CP's workhorse popover — the `⋯` on an element chip, the Actions
button on a field, the overflow list on a [tab strip](tabs.md), and the guts of `customSelect`
and `checkboxSelect`. Anywhere you see a button reveal a list, this is it.

You rarely hand-write one. `craft\helpers\Cp::disclosureMenu($items, $config)` builds the trigger
*and* the menu from an array, and `_includes/disclosuremenu` is the template behind it.

<div class="cp-demo" markdown="0">
<div class="demo">
<button class="btn menubtn" type="button" aria-controls="demo-menu" aria-expanded="true" data-disclosure-trigger="true"><div class="label">Actions</div></button>
<div class="menu menu--disclosure" id="demo-menu" style="position:static; margin-top:6px">
<ul class="padded">
<li><a class="menu-item sel" role="button"><span class="menu-item-label">Edit</span></a></li>
<li><a class="menu-item" role="button"><span class="menu-item-label">Duplicate<span class="menu-item-description smalltext light">Creates an unpublished draft</span></span></a></li>
</ul>
<hr class="padded"/>
<ul class="padded">
<li><a class="menu-item error" role="button"><span class="menu-item-label">Delete</span></a></li>
</ul>
</div>
</div>
</div>

```php
use craft\helpers\Cp;

echo Cp::disclosureMenu([
    ['label' => Craft::t('my-plugin', 'Edit'), 'url' => $widget->getCpEditUrl()],
    [
        'label' => Craft::t('my-plugin', 'Duplicate'),
        'description' => Craft::t('my-plugin', 'Creates an unpublished draft'),
        'action' => 'my-plugin/widgets/duplicate',
        'params' => ['id' => $widget->id],
    ],
    [
        'label' => Craft::t('my-plugin', 'Delete'),
        'action' => 'my-plugin/widgets/delete',
        'params' => ['id' => $widget->id],
        'destructive' => true,
        'confirm' => Craft::t('my-plugin', 'Are you sure?'),
    ],
], [
    'hiddenLabel' => Craft::t('my-plugin', 'Actions'),
]);
```

```html title="what that renders"
<button type="button" class="btn menubtn" aria-controls="menu-123" aria-label="Actions"
        data-disclosure-trigger="true" aria-expanded="false"></button>

<div id="menu-123" class="menu menu--disclosure">
  <ul class="padded">
    <li><a id="menu-item-1" class="menu-item" href="…"><span class="menu-item-label">Edit</span></a></li>
  </ul>
  <hr class="padded">
  <ul class="padded">
    <li>
      <button id="menu-item-3" class="menu-item error formsubmit" data-destructive
              data-action="my-plugin/widgets/delete" data-confirm="Are you sure?">
        <span class="menu-item-label">Delete</span>
      </button>
    </li>
  </ul>
</div>
```

The trigger and the menu are **siblings**, wired by `aria-controls` → the menu's `id`. The menu
isn't nested inside the button, so don't go looking for it there.

`data-disclosure-trigger` is what Craft's JS binds to. Without it you have a button and an
inert div.

## Item types

You don't set `type` — it's inferred:

| Renders | When |
| --- | --- |
| `link` (`<a href>`) | The item has a `url` |
| `hr` | The item has `hr: true` |
| `group` | The item has a `heading` or nested `items` |
| `button` (`<button>`) | Anything else — the default |

Set `type` explicitly to override. Valid values come from `craft\enums\MenuItemType`: `link`,
`button`, `hr`, `group`.

## Item options

| Key | Effect |
| --- | --- |
| `label` | The item's text |
| `html` | Raw HTML instead of `label` |
| `url` | Makes it a link |
| `icon` | Icon before the label |
| `color` | Colours the icon — a `craft\enums\Color` or its value |
| `status` | Renders a status indicator before the label |
| `description` | Muted second line under the label |
| `handle` | Like `description`, but rendered as `code` |
| `info` | An info bubble after the label |
| `selected` | Adds `.sel` and a visually-hidden ", selected" |
| `destructive` | Adds `.error` and `data-destructive` — **and moves the item to the end** |
| `action` | Controller action to post to. Adds `.formsubmit` |
| `params` | Params posted with `action` |
| `confirm` | Confirmation prompt before the action runs |
| `redirect` | Where to go afterwards (hashed automatically) |
| `requireElevatedSession` | Force an elevated session first |
| `disabled` | Adds `.disabled` |
| `hidden` | Adds `.hidden` to the `<li>` |
| `id` | The item's id. Defaults to `menu-item-{random}` |
| `attributes` | Extra attributes on the link/button |
| `liAttributes` | Extra attributes on the `<li>` |
| `items` | Nested items — makes it a group |
| `heading` | Group heading |
| `headingTag` | Heading tag. Default `h3` |
| `padded` | For `hr` and group headings. Default `true` |

**`destructive` reorders your menu.** `Cp::disclosureMenu()` pulls every destructive item out,
appends an `hr`, then pushes them onto the end — so Delete lands at the bottom behind a divider
no matter where you put it in the array. Don't fight it by adding your own separator.

## Menu options

`Cp::disclosureMenu($items, $config)`:

| Key | Default | Effect |
| --- | --- | --- |
| `id` | `menu-{random}` | The menu's id, referenced by `aria-controls` |
| `class` | `null` | Extra classes on the menu |
| `withButton` | `true` | Render the trigger. `false` gives you just the menu |
| `buttonLabel` | `null` | Visible label inside the trigger |
| `buttonHtml` | `null` | Raw HTML inside the trigger |
| `autoLabel` | `false` | Derive the button label from the selected item |
| `buttonAttributes` | `[]` | Extra attributes on the trigger |
| `hiddenLabel` | `null` | `aria-label` for an icon-only trigger |
| `omitIfEmpty` | `true` | Render nothing when there are no items |

`withButton: false` is how you attach a menu to a trigger you've already rendered — as the tab
strip does.

## Groups & separators

Headings and rules break the `<ul>` and start a new one — a group is a `.menu-group` wrapper
with its own heading and list, not a nested `<li>`:

```php
Cp::disclosureMenu([
    ['heading' => Craft::t('my-plugin', 'Sort by'), 'items' => [
        ['label' => 'Title', 'selected' => true],
        ['label' => 'Date created'],
    ]],
    ['hr' => true],
    ['label' => 'Settings', 'url' => '…'],
]);
```

!!! note
    **The selected tick is an icon font.** `.menu ul.padded li a.sel:not([data-icon]):before`
    sets `content: "check"` — a ligature from Craft's icon font — and `ul.padded` reserves the
    space for it with `padding-inline-start`. That's why selected items in a menu don't shift
    the others: the gutter is always there. The demo above approximates the tick.

!!! note
    **It's a popover.** `.menu` is `position: absolute` and Craft's JS positions it against the
    trigger. The demo forces `position: static` so it can sit inline on the page — in the CP it
    floats, and it's hidden until the trigger is activated.
