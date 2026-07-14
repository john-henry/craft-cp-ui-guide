# Panes & meta

A `.pane` is the white content card that most CP screens are built from. A `.meta` pane is the stacked settings sidebar you see on entry edit screens — each row a bordered field.

<div class="cp-demo" markdown="0">
<div class="grid2">
<div class="pane">
<h3 style="margin:0 0 8px">Pane</h3>
<p style="margin:0; color:var(--gray-600); font-size:13.5px">Primary content container. Standard 24px (<code>--xl</code>) padding, hairline border, 5px radius.</p>
</div>
<div class="meta">
<div class="field"><div class="heading"><label>Author</label></div><div class="input" style="font-size:13.5px">Brad Bell</div></div>
<div class="field"><div class="heading"><label>Post Date</label></div><div class="input" style="font-size:13.5px">Jul 14, 2026</div></div>
<div class="field"><div class="heading"><label>Status</label></div><div class="input"><span class="status on"></span> Live</div></div>
</div>
</div>
</div>

```twig
<div class="pane"> … your content … </div>

<div class="meta">
  {{ forms.textField({ label: "Author", … }) }}
  {{ forms.dateField({ label: "Post Date", … }) }}
</div>
```
