# Copytext

A read-only value with a one-click copy button — ideal for API keys, webhook URLs, generated tokens, or IDs.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="copytext"><input readonly="" type="text" value="pk_live_8Kd2mQ9fA1zX"/><button class="copytextbtn" title="Copy"><svg class="ic"><use href="#i-copy"></use></svg></button></div>
</div>
</div>

```twig
{{ forms.copytextField({
    label: "API key",
    value: plugin.apiKey,
    readonly: true,
}) }}
```
