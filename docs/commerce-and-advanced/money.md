# Money & price

The money field pairs a currency label with a right-aligned, tabular-numbered input. Commerce uses it for every price, discount, and shipping amount. Values are stored as decimals in the store’s currency.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field" style="max-width:280px">
<div class="heading"><label>Purchase total</label></div>
<div class="instructions"><p>Minimum order value for this discount.</p></div>
<div class="input"><div class="money-container"><div class="money-currency-label"><span>USD $</span></div><input type="text" value="49.00"/></div></div>
</div>
</div>
</div>

```twig
{{ forms.moneyField({
    label: "Purchase Total"|t("commerce"),
    instructions: "Minimum order value for this discount."|t("commerce"),
    id: "purchaseTotal",
    name: "purchaseTotal",
    value: discount.purchaseTotal|number,
    currencyLabel: currency,   {# e.g. "USD $" #}
    decimals: decimals,
    showCurrency: true,
    showClear: false,
    errors: discount.getErrors("purchaseTotal"),
}) }}
```
