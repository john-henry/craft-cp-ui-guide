# Craft CMS Control Panel — UI & Brand Guide

Craft ships a set of Twig form macros in `_includes/forms`. Import them once at the top of any control-panel template and call them like functions. Each macro takes a single `config` hash.

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
    **Two flavors of most macros.** A bare input macro (e.g. `forms.text`) renders just the control. The `*Field` variant (e.g. `forms.textField`) wraps that control in the standard [field shell](components/field.md) — label, instructions, tip, warning, and errors. Reach for the `*Field` version inside settings screens; use the bare input inside custom layouts where you supply your own labeling.

!!! note
    **From PHP.** The same field shell is available server-side via `Craft::$app->view->renderTemplate()` or the `Cp` helper (`craft\helpers\Cp::textFieldHtml()`, `::lightswitchFieldHtml()`, etc.), which is handy when returning HTML from a controller or building a field type’s settings.
