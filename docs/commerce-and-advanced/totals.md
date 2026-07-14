# Order totals

Commerce’s order screen renders line items in a [data table](../components/tables.md), then a right-aligned totals summary underneath. A good pattern for any “invoice” or “summary” view: adjustments in the body, the grand total emphasized on its own rule.

<div class="cp-demo" markdown="0">
<div class="demo" style="padding:0; border:0">
<table class="data" style="border-radius:var(--radius-lg) var(--radius-lg) 0 0">
<thead><tr><th>Item</th><th>SKU</th><th style="text-align:center">Qty</th><th style="text-align:right">Total</th></tr></thead>
<tbody>
<tr><td>Field Notes Notebook</td><td><code>FN-001</code></td><td style="text-align:center">3</td><td style="text-align:right">$29.85</td></tr>
<tr><td>Enamel Pin</td><td><code>PIN-07</code></td><td style="text-align:center">1</td><td style="text-align:right">$8.00</td></tr>
</tbody>
</table>
<table class="data order-total" style="border-radius:0 0 var(--radius-lg) var(--radius-lg); border-top:0">
<tbody>
<tr><td>Subtotal</td><td>$37.85</td></tr>
<tr><td>Shipping</td><td>$5.00</td></tr>
<tr><td>Discount — <span class="token">WELCOME10</span></td><td>−$3.79</td></tr>
<tr class="grand"><td>Total paid</td><td>$39.06</td></tr>
</tbody>
</table>
</div>
</div>

!!! note
    **Real orders.** Commerce exposes each amount on the order model (`order.itemSubtotal`, `order.totalShippingCost`, `order.totalDiscount`, `order.totalPaid`) already formatted through `|currency`. Loop `order.lineItems` for the rows and `order.adjustments` for discounts, shipping, and tax.
