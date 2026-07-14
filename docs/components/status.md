# Status indicators

A small dot that communicates state. Use the semantic class (`on`, `pending`, `off`, `disabled`, `expired`, `suspended`) so the color stays consistent with the rest of the CP. Note that `off`, `suspended`, and `expired` are distinct element statuses that happen to share the same muted fill — they aren't interchangeable.

<div class="cp-demo" markdown="0">
<div class="demo">
<span class="status-item"><span class="status on"></span> Live</span>
<span class="status-item"><span class="status pending"></span> Pending</span>
<span class="status-item"><span class="status expired"></span> Expired</span>
<span class="status-item"><span class="status disabled"></span> Disabled</span>
</div>
</div>

```html
<span class="status on"></span> Live
<span class="status pending"></span> Pending
<span class="status expired"></span> Expired
<span class="status disabled"></span> Disabled
```

!!! note
    **Color aliases.** Beyond the semantic classes, Craft accepts named colors (`green`, `amber`, `sky`, `violet`, `rose`…) for custom element statuses — e.g. `<span class="status teal">`. Element types can define their own status set this way.
