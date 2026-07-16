# Panes & meta

A `.pane` is the white content card that most CP screens are built from. A `.meta` pane is the settings sidebar you see on entry edit screens — each row a label column and a value, split by a hairline.

<div class="cp-demo" markdown="0">
<div class="grid2">
<div class="pane">
<h3 style="margin:0 0 8px">Pane</h3>
<p style="margin:0; color:var(--gray-600); font-size:13.5px">Primary content container. Standard 24px (<code>--xl</code>) padding, hairline border, 5px radius.</p>
</div>
<div class="meta">
<div class="flex-fields">
<div class="field"><div class="heading"><label>Author</label></div><div class="input">Brad Bell</div></div>
<div class="field"><div class="heading"><label>Post Date</label></div><div class="input">Jul 14, 2026</div></div>
<div class="field"><div class="heading"><label>Status</label></div><div class="input"><span class="status on"></span> Live</div></div>
</div>
</div>
</div>
</div>

```twig
<div class="pane"> … your content … </div>

<div class="meta">
  <div class="flex-fields">
    {{ forms.textField({ label: "Author", … }) }}
    {{ forms.dateField({ label: "Post Date", … }) }}
  </div>
</div>
```

The `.flex-fields` wrapper is doing the work, and it's easy to miss. Craft only lays meta rows out horizontally via `.meta > .flex-fields > .field` — a direct-child selector. Drop the fields straight into `.meta` and you keep the default stacked field, label above input, which is why a hand-built sidebar looks subtly unlike the native one.

The heading is a fixed `--heading-width` column (132px) with a rule down its trailing edge; the input flexes to fill what's left and is vertically centred against a `44px` minimum row height. Inputs inside a meta row also lose their own border and background — the row is the box, not the control.

!!! note
    **Editable vs read-only.** `.meta` on its own is the editable sidebar and Craft tints it (`--gray-050`). Add `.read-only` and you get the white [metadata](../commerce-and-advanced/metadata.md) variant, which is a `<dl>` of `.data` rows with `.heading`/`.value` rather than fields — a different structure, not just a different skin.
