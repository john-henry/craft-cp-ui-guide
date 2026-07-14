# Lightswitch

Craft’s signature on/off toggle. Prefer this over a checkbox for a single boolean setting. It renders as a `<button role="switch">` with a hidden input, so it submits like a normal field.

<div class="cp-demo" markdown="0">
<div class="demo row" style="align-items:center; gap:26px">
<span style="display:inline-flex; align-items:center; gap:10px"><span class="lightswitch on"><span class="handle"></span></span> On</span>
<span style="display:inline-flex; align-items:center; gap:10px"><span class="lightswitch"><span class="handle"></span></span> Off</span>
<span style="display:inline-flex; align-items:center; gap:10px"><span class="lightswitch small on"><span class="handle"></span></span> Small</span>
</div>
</div>

```twig
{{ forms.lightswitchField({
    label: "Enable this feature"|t("my-plugin"),
    instructions: "Turn on to expose the widget."|t("my-plugin"),
    name: "enabled",
    on: settings.enabled,
}) }}
```
