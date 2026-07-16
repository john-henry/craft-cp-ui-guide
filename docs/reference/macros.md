# Form macros

Craft ships a set of Twig form macros in `_includes/forms`. Import them once at the top of any
control-panel template and call them like functions. Almost every macro takes a single `config`
hash.

```twig
{# Import the macros once, at the top of your CP template #}
{% import "_includes/forms" as forms %}

{# Then call any macro with a config hash #}
{{ forms.textField({
    label: "Title"|t("my-plugin"),
    id: "title",
    name: "title",
    value: settings.title ?? "",
    required: true,
}) }}
```

!!! note
    **Two flavors of most macros.** A bare input macro (e.g. `forms.text`) renders just the control. The `*Field` variant (e.g. `forms.textField`) wraps that control in the standard [field shell](../components/field.md) — label, instructions, tip, warning, and errors. Reach for the `*Field` version inside settings screens; use the bare input inside custom layouts where you supply your own labeling.

!!! note
    **From PHP.** The same field shell is available server-side via `Craft::$app->view->renderTemplate()` or the `Cp` helper (`craft\helpers\Cp::textFieldHtml()`, `::lightswitchFieldHtml()`, etc.), which is handy when returning HTML from a controller or building a field type’s settings.

## The full set

Craft 5.10 exports 77 macros. Nearly all pair a bare input with a `*Field` wrapper, listed here
as `name` / `nameField`.

### Text

| Macro | Renders |
| --- | --- |
| `text` / `textField` | Single-line text input |
| `textarea` / `textareaField` | Multi-line textarea |
| `password` / `passwordField` | Password input with show/hide |
| `autosuggest` / `autosuggestField` | Text with env-var / alias suggestions |
| `copytext` / `copytextField` | Read-only value + copy button |
| `hidden` | Hidden input |

### Choice

| Macro | Renders |
| --- | --- |
| `select` / `selectField` | Native styled dropdown |
| `selectize` / `selectizeField` | Searchable / taggable menu |
| `multiselect` / `multiselectField` | Multi-value select |
| `customSelect` / `customSelectField` | Disclosure menu with custom option markup |
| `booleanMenu` / `booleanMenuField` | Yes/no menu (submits `1`/`0`) |
| `checkbox` / `checkboxField` | Single checkbox |
| `checkboxGroup` / `checkboxGroupField` | Group of checkboxes |
| `checkboxSelect` / `checkboxSelectField` | Checkbox group in a menu |
| `radio` | Single radio input |
| `radioGroup` / `radioGroupField` | Radio button set |
| `lightswitch` / `lightswitchField` | On/off toggle |

### Date, time & numbers

| Macro | Renders |
| --- | --- |
| `date` / `dateField` | [Date picker](../components/datetime.md) |
| `time` / `timeField` | [Time picker](../components/datetime.md) |
| `dateTimeField` | Date **and** time together — no bare `dateTime` macro exists |
| `range` / `rangeField` | Slider |
| `money` / `moneyField` | Currency input |

### Pickers

| Macro | Renders |
| --- | --- |
| `color` / `colorField` | Color picker |
| `colorSelect` / `colorSelectField` | Preset swatch select |
| `iconPicker` / `iconPickerField` | Craft icon chooser |
| `file` / `fileField` | File upload control |
| `elementSelect` / `elementSelectField` | [Relate entries, assets, users…](../components/relationfields.md) |

### Craft components

Selects populated from the install's own config — handy in plugin settings.

| Macro | Renders |
| --- | --- |
| `componentSelect` / `componentSelectField` | Choose a component class |
| `entryTypeSelect` / `entryTypeSelectField` | Choose an entry type |
| `fieldSelect` / `fieldSelectField` | Choose a custom field |
| `volume` / `volumeField` | Choose an asset volume (with inline “create new”) |
| `fs` / `fsField` | Choose a filesystem (with inline “create new”) |
| `timeZone` / `timeZoneField` | Timezone menu |
| `languageMenu` / `languageMenuField` | Language menu |

### Structure & chrome

| Macro | Renders |
| --- | --- |
| `field` | The [field shell](../components/field.md) around arbitrary input HTML |
| `errorList` | A field's validation errors |
| `button` / `submitButton` | [Buttons](../components/buttons.md) |
| `buttonGroup` / `buttonGroupField` | Segmented control |
| `editableTable` / `editableTableField` | Add/edit/reorder [table](../components/tables.md) rows |
| `fieldLayoutDesigner` / `fieldLayoutDesignerField` | Drag-and-drop [layout builder](../commerce-and-advanced/fld.md) |
| `optionShortcutLabel` | A `.shortcut` span for a keyboard hint |
| `shortcutText` | Platform-aware shortcut text (`⌘K` on Mac, `Ctrl+K` elsewhere) |

!!! note
    **Not everything takes a config hash.** `field(config, input)`, `errorList(errors)`,
    `shortcutText(key, shift, alt)`, and `optionShortcutLabel(key, shift, alt)` take positional
    arguments instead. Passing a hash to those fails silently rather than loudly.
