# Modals & HUDs

Craft floats transient UI in a **modal** — a white card with an optional gray `.header`, a `.body`, and a right-aligned `.footer` of actions — over a dark *shade*. Alerts add a warning glyph; the smaller **HUD** is a popover anchored to a trigger. Modals are driven by JavaScript (`Garnish.Modal` / `Craft.CpModal`), so the markup below is what you place inside the floated container.


## Standard modal

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="modal-stage shaded">
<div class="modal">
<div class="header"><h1>Choose a new entry type</h1></div>
<div class="body">
<p>Select which entry type to add to this section. You can reorder and rename types later in the section’s settings.</p>
</div>
<div class="footer"><button class="btn">Cancel</button><button class="btn submit">Add</button></div>
</div>
</div>
</div>
</div>

```html
<div class="modal">
  <div class="header"><h1>Choose a new entry type</h1></div>
  <div class="body">
    <p>Select which entry type to add…</p>
  </div>
  <div class="footer">
    <button class="btn">Cancel</button>
    <button class="btn submit">Add</button>
  </div>
</div>

// Float it over a shade and manage focus/escape:
new Garnish.Modal($container, { resizable: false });
```


## Alert modal

Add `.alert` to the modal (or use `Craft.confirm()`) to inset a warning icon beside the body — the pattern for destructive confirmations.

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="modal-stage shaded">
<div class="modal alert">
<div class="body"><span class="alert-ic"><svg class="ic"><use href="#i-warning"></use></svg></span>
<p>Are you sure you want to delete “Spring Sale” and all of its related content? This can’t be undone.</p>
</div>
<div class="footer"><button class="btn">Cancel</button><button class="btn submit" style="--red-600:#dc2626">Delete</button></div>
</div>
</div>
</div>
</div>


## HUD (popover)

A `.hud` is a lightweight popover with a tip arrow, anchored to whatever triggered it — used for inline editors, quick settings, and element previews.

<div class="cp-demo" markdown="0">
<div class="demo" style="justify-content:flex-start">
<div class="hud">
<div class="hud-header"><h1>Quick edit</h1></div>
<div class="main">Title, slug, and status without leaving the index.</div>
</div>
</div>
</div>

| Class | Use |
| --- | --- |
| `.modal` | Base card. Sizes to 66% of the viewport unless modified |
| `.modal.fitted` | Shrinks to its content instead of a fixed size |
| `.modal.fullscreen` | Fills the viewport, square corners |
| `.modal.alert` | Insets a warning icon beside the body |
| `.hud` | Small anchored popover with a tip arrow |
