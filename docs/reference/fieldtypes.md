# Built-in field types

These are the custom field types Craft ships with — what content modelers pick from in *Settings → Fields*, and what a plugin’s field extends. Each has a class under `craft\fields\`, a designer icon, and produces an input built from the [form macros](../index.md) above. Grouped here by what they capture.


## Text & data

| Field type | Class | Stores / renders |
| --- | --- | --- |
| Plain Text | `fields\PlainText` | Single- or multi-line text; optional char limit |
| Number | `fields\Number` | Numeric value with min/max, decimals, prefix/suffix |
| Money | `fields\Money` | Currency amount (uses the [money field](../commerce-and-advanced/money.md)) |
| Range | `fields\Range` | Slider between a min and max |
| Email | `fields\Email` | Validated email address |
| URL | `fields\Url` | Validated URL |
| Link | `fields\Link` | URL, email, phone, or a related element as a link |
| Color | `fields\Color` | Hex color via the color picker |
| Icon | `fields\Icon` | An icon chosen from Craft’s icon set |
| JSON | `fields\Json` | Raw JSON in a code editor |


## Options

Fields where authors pick from a predefined set. These map directly onto the [checkbox / radio](../components/checkradio.md), [select](../components/select.md), and [lightswitch](../components/lightswitch.md) components.

| Field type | Class | Input |
| --- | --- | --- |
| Dropdown | `fields\Dropdown` | Single-select menu |
| Multi-select | `fields\MultiSelect` | Multi-value menu |
| Checkboxes | `fields\Checkboxes` | Checkbox group (many values) |
| Radio Buttons | `fields\RadioButtons` | Radio group (one value) |
| Button Group | `fields\ButtonGroup` | Segmented control of icons/labels |
| Country | `fields\Country` | Country picker |
| Lightswitch | `fields\Lightswitch` | On/off boolean |


## Date & time

| Field type | Class | Stores |
| --- | --- | --- |
| Date | `fields\Date` | Date, or date & time, with timezone handling |
| Time | `fields\Time` | Time of day |


## Relations

Fields that relate the element to *other* elements, rendered with the element-select / [chip](../components/badges.md) UI.

| Field type | Class | Relates to |
| --- | --- | --- |
| Entries | `fields\Entries` | Other entries |
| Assets | `fields\Assets` | Files in volumes |
| Categories | `fields\Categories` | Categories in a group |
| Tags | `fields\Tags` | Tags in a group |
| Users | `fields\Users` | User accounts |
| Addresses | `fields\Addresses` | Nested [address](../commerce-and-advanced/address.md) elements |


## Nested content

Fields that contain their own fields — the backbone of flexible content modeling.

| Field type | Class | Structure |
| --- | --- | --- |
| Table | `fields\Table` | Rows & typed columns (uses [editable table](../components/tables.md)) |
| Matrix | `fields\Matrix` | Repeatable blocks, each with its own field layout |
| Content Block | `fields\ContentBlock` | A single inline group of nested fields |

!!! note
    **Building your own.** A custom field extends `craft\base\Field` (or `ElementRelationFieldType` for a relation). Implement `displayName()`, `icon()`, `getInputHtml()` — where you call the form macros or `Cp` helpers to render the control — and `getSettingsHtml()` for its configuration screen. Register it with the `Fields::EVENT_REGISTER_FIELD_TYPES` event, and it appears in the Fields dropdown alongside the built-ins above.

!!! note
    **Not built in.** A few common field types live in first-party *plugins* rather than core — notably **CKEditor** (rich text) and **Vizy**-style builders. If your plugin depends on rich text, require the CKEditor plugin rather than assuming it’s present.
