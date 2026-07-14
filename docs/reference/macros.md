# Macro reference

The full set of form macros exported from `_includes/forms`. Nearly all have a bare input version and a `*Field` wrapped version. Import once, then call as `forms.<name>(config)`.

| Macro | Renders |
| --- | --- |
| `text` / `textField` | Single-line text input |
| `textarea` / `textareaField` | Multi-line textarea |
| `password` / `passwordField` | Password input with show/hide |
| `select` / `selectField` | Native styled dropdown |
| `selectize` / `selectizeField` | Searchable / taggable menu |
| `multiselect` / `multiselectField` | Multi-value select |
| `checkbox` / `checkboxField` | Single checkbox |
| `checkboxGroup` / `checkboxSelect` | Group of checkboxes |
| `radioGroup` / `radioGroupField` | Radio button set |
| `lightswitch` / `lightswitchField` | On/off toggle |
| `button` / `submitButton` | Buttons |
| `buttonGroup` / `buttonGroupField` | Segmented control |
| `copytext` / `copytextField` | Read-only value + copy button |
| `autosuggest` / `autosuggestField` | Text with env-var / alias suggestions |
| `color` / `colorSelect` | Color picker / swatch select |
| `date` / `time` / `datetime` | Date & time pickers |
| `range` / `rangeField` | Slider |
| `money` / `moneyField` | Currency input |
| `file` / `fileField` | File upload control |
| `editableTable` / `editableTableField` | Add/edit/reorder table rows |
| `elementSelect` / `elementSelectField` | Relate entries, assets, users, … |
| `iconPicker` / `iconPickerField` | Craft icon chooser |
| `timeZone` / `languageMenu` | Timezone & language menus |
| `fieldLayoutDesigner` | Drag-and-drop field layout builder |

!!! note
    **Reference, not gospel.** This guide is a reverse-engineered snapshot of the Craft 5.x control panel, with commerce-specific patterns drawn from [craftcms/commerce](https://github.com/craftcms/commerce) and [craftcms/shopify](https://github.com/craftcms/shopify) — not official Craft documentation. Always cross-check class names and macro configs against the version of [craftcms/cms](https://github.com/craftcms/cms) your plugin targets, since tokens and markup evolve between releases.
