# Tables

Use `table.data` for static tabular content. For inline-editable rows (add/delete/reorder), reach for `forms.editableTableField`, which wires up the JS for you.

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<table class="data">
<thead><tr><th>Name</th><th>Handle</th><th>Type</th><th>Status</th></tr></thead>
<tbody>
<tr><td>Featured Image</td><td><code>featuredImage</code></td><td>Assets</td><td><span class="status on"></span> Enabled</td></tr>
<tr><td>Body</td><td><code>body</code></td><td>CKEditor</td><td><span class="status on"></span> Enabled</td></tr>
<tr><td>Legacy Tags</td><td><code>legacyTags</code></td><td>Tags</td><td><span class="status off"></span> Disabled</td></tr>
</tbody>
</table>
</div>
</div>

```twig
{{ forms.editableTableField({
    label: "Redirects",
    name: "redirects",
    cols: {
        from: { heading: "From", type: "singleline" },
        to:   { heading: "To",   type: "singleline" },
    },
    rows: settings.redirects,
    addRowLabel: "Add a redirect",
}) }}
```
