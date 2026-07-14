# Address card

Craft 5 addresses (used by Commerce for billing/shipping and by the core for user addresses) render as a compact card with a formatted address block and edit/delete actions.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="address-card">
<div class="name">Ada Lovelace</div>
<address>12 Analytical Way<br/>London EC1A 1BB<br/>United Kingdom</address>
<div class="card-actions"><button class="btn small">Edit</button><button class="btn small caution">Delete</button></div>
</div>
</div>
</div>

```twig
{# Craft formats the address per-country for you #}
{{ cp.addressCardHtml(address)|raw }}

{# Or a full editable fieldset: #}
{{ cp.addressFieldsHtml(address)|raw }}
```
