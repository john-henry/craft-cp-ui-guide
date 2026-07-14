# Status labels

Beyond the bare [status dot](../components/status.md), Craft has a colored, uppercase **pill** — a dot plus a tinted label. Commerce leans on these heavily for order and payment states (Paid, Unpaid, Refunded…), and any custom element can define its own. The color comes from Craft’s `Color` enum, so the tint and text shade stay on-brand automatically.

<div class="cp-demo" markdown="0">
<div class="demo row" style="align-items:center">
<span class="status-label green"><span class="status"></span><span class="status-label-text">Paid</span></span>
<span class="status-label red"><span class="status"></span><span class="status-label-text">Unpaid</span></span>
<span class="status-label orange"><span class="status"></span><span class="status-label-text">Partially paid</span></span>
<span class="status-label blue"><span class="status"></span><span class="status-label-text">Refunded</span></span>
<span class="status-label gray"><span class="status"></span><span class="status-label-text">Draft</span></span>
</div>
</div>

```php
use craft\helpers\Cp;
use craft\enums\Color;

Cp::statusLabelHtml([
    'color' => Color::Green,        // red|orange|amber|green|teal|blue|gray…
    'label' => Craft::t('commerce', 'Paid'),
]);
```

```html title="HTML output"
<span class="status-label green">
  <span class="status green"></span>
  <span class="status-label-text">Paid</span>
</span>
```

!!! note
    **Element statuses.** If your element implements `Statusable`, define a `statuses()` map (`['paid' => ['color' => 'green', 'label' => 'Paid']]`) and Craft renders the pill via `Cp::componentStatusLabelHtml($element)` everywhere the element appears. Available colors: red, orange, amber, yellow, lime, green, emerald, teal, cyan, sky, blue, indigo, violet, purple, fuchsia, pink, rose, gray.
