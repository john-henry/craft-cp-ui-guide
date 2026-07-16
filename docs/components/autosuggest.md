# Autosuggest

`forms.autosuggest` is a text input that suggests **environment variables**, **aliases**, and
optionally **template paths** as you type. It's the control behind every Craft setting that
accepts `$SITE_URL` or `@webroot`, and it's the right choice any time a plugin setting holds a
URL, a path, or a secret.

Using it is how you let integrators keep credentials out of Project Config.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:430px">
<div class="heading"><label id="demo-as-label" for="demo-as">API endpoint</label></div>
<div class="instructions" id="demo-as-instructions"><p>Environment variables and aliases are supported.</p></div>
<div class="input ltr"><div class="autosuggest-container" id="demo-as-container" tabindex="-1"><input class="text fullwidth" id="demo-as" type="text" value="$WIDGET_API_URL"/></div></div>
</div>
</div>
</div>

```twig
{{ forms.autosuggestField({
    label: "API endpoint"|t("my-plugin"),
    instructions: "Environment variables and aliases are supported."|t("my-plugin"),
    id: "apiUrl",
    name: "apiUrl",
    value: settings.apiUrl,
    suggestEnvVars: true,
    suggestAliases: true,
}) }}
```

## Config

| Key | Effect |
| --- | --- |
| `suggestEnvVars` | Suggest environment variables |
| `suggestAliases` | Also suggest aliases (`@web`, `@webroot`…). Needs `suggestEnvVars` |
| `suggestTemplates` | Suggest template paths from the site's templates directory |
| `suggestions` | Your own suggestion groups, merged with the above |
| `suggestionFilter` | Callback narrowing which env vars are offered |

`suggestEnvVars` pulls its list from `craft.cp.getEnvSuggestions(suggestAliases, suggestionFilter)`
and `suggestTemplates` from `craft.cp.getTemplateSuggestions()` — so the suggestions reflect the
actual environment, not a static list.

## Reading the value

The stored value is the **raw string** — `$WIDGET_API_URL`, not what it resolves to. Parse it
when you use it:

```php
use craft\helpers\App;

$url = App::parseEnv($this->apiUrl);
```

Forget `App::parseEnv()` and you'll make a request to the literal string `$WIDGET_API_URL`. This
is the single most common bug with this control — and it only shows up in the environment that
actually sets the variable, which is rarely the one you're developing in.

!!! note
    **It's a Vue component.** `autosuggest.twig` registers `VueAsset` and renders a
    `<div class="autosuggest-container">` around a **disabled preview input**, then mounts
    `<vue-autosuggest>` over it. The disabled input is what you see before JS runs — which is why
    the demo above shows a plain text field. The real suggestion dropdown has no server-rendered
    equivalent to reproduce here.
