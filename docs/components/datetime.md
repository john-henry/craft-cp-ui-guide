# Date & time

Craft renders date and time pickers as plain text inputs with a trailing glyph — the calendar
and clock are cues, not native `<input type="date">` controls. On touch devices Craft swaps in
native `date`/`time` inputs instead, so the desktop markup below isn't what mobile users get.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="field"><div class="heading"><label>Post date</label></div><div class="input"><div class="datetimewrapper"><div class="datewrapper"><span class="visually-hidden">M/D/YYYY</span><input autocomplete="off" class="text" placeholder=" " size="10" type="text" value="7/16/2026"/><div data-icon="date"><svg class="ic"><use href="#i-calendar"></use></svg></div></div></div></div></div>
<div class="field"><div class="heading"><label>Doors open</label></div><div class="input"><div class="datetimewrapper"><div class="timewrapper"><input autocomplete="off" class="text" placeholder=" " size="10" type="text" value="7:30 PM"/><div data-icon="time"><svg class="ic"><use href="#i-clock"></use></svg></div></div></div></div></div>
<div class="field"><div class="heading"><label>Expiry</label></div><div class="instructions"><p>Leave blank to never expire.</p></div><div class="input"><div class="datetimewrapper"><div class="datewrapper"><span class="visually-hidden">M/D/YYYY</span><input aria-label="Date" autocomplete="off" class="text" placeholder=" " size="10" type="text" value="7/31/2026"/><div data-icon="date"><svg class="ic"><use href="#i-calendar"></use></svg></div></div><div class="timewrapper"><input aria-label="Time" autocomplete="off" class="text" placeholder=" " size="10" type="text" value="11:59 PM"/><div data-icon="time"><svg class="ic"><use href="#i-clock"></use></svg></div></div></div></div></div>
</div>
</div>

```twig
{{ forms.dateField({ label: "Post date", name: "postDate", value: entry.postDate }) }}

{{ forms.timeField({ label: "Doors open", name: "doorsAt", value: value }) }}

{{ forms.dateTimeField({
    label: "Expiry",
    instructions: "Leave blank to never expire.",
    name: "expiryDate",
    value: entry.expiryDate,
}) }}
```

Pass a `DateTime` (or anything Twig's `date()` accepts) as `value`; pass `null` for an empty
field. `dateTimeField` sets `fieldset: true`, since it groups two labelled controls.

## What gets submitted

A date field doesn't post a single string. It posts an array — the visible value plus the
locale and timezone needed to interpret it:

```
postDate[date]      => "7/16/2026"   // formatted in the user's locale, not ISO
postDate[locale]    => "en-US"
postDate[timezone]  => "America/Los_Angeles"
```

`dateTimeField` adds `postDate[time]`, and emits the locale and timezone once rather than per
control. Craft's `DateTimeHelper` normalises this shape for you, so prefer

```php
$date = DateTimeHelper::toDateTime($request->getBodyParam('postDate'));
```

over reading `[date]` directly — parsing the localised string yourself will break for any user
whose formatting locale isn't yours. Set `outputLocaleParam: false` or `outputTzParam: false`
to suppress the hidden inputs when you're handling conversion another way.

!!! note
    **Mobile is different markup.** Craft checks `craft.app.request.isMobileBrowser` and, on a
    match, renders a native `<input type="date">`/`type="time"` with an `.empty-value` class when
    unset — no datepicker JS, no calendar glyph. Don't target `.datewrapper input[type=text]` in
    plugin CSS or your styles will silently drop on touch devices.
