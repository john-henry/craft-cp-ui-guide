# Modals & HUDs

Craft floats transient UI in a **modal** over a dark `.modal-shade` overlay. A bare `Garnish.Modal` is just a `.modal` card you fill yourself — `.body` is the conventional content class, and there is **no** `.header` or `.footer` class. The higher-level `Craft.CpModal` adds structure: a `.cpmodal-body` (wrapping `.cpmodal-content`) plus a `.cpmodal-footer` for the action buttons. Alerts add a warning glyph; the smaller **HUD** is a popover anchored to a trigger.


## Standard modal

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="modal-stage shaded">
<div class="cpmodal modal">
<div class="cpmodal-body"><div class="cpmodal-content">
<h1>Choose a new entry type</h1>
<p>Select which entry type to add to this section. You can reorder and rename types later in the section’s settings.</p>
</div></div>
<div class="cpmodal-footer"><button class="btn">Cancel</button><button class="btn submit">Add</button></div>
</div>
</div>
</div>
</div>

```html
<div class="cpmodal modal">
  <div class="cpmodal-body">
    <div class="cpmodal-content">
      <h1>Choose a new entry type</h1>
      <p>Select which entry type to add…</p>
    </div>
  </div>
  <div class="cpmodal-footer">
    <button class="btn">Cancel</button>
    <button class="btn submit">Add</button>
  </div>
</div>

// Craft.CpModal builds this structure for you and manages focus/escape:
new Craft.CpModal(/* … */);

// A bare Garnish.Modal just floats a .modal — you supply the .body:
new Garnish.Modal($container, { resizable: false });
```


## Alert modal

Add `.alert` to a bare modal to inset a warning icon beside the body — the pattern for destructive confirmations. (There is no `Craft.confirm()` helper; for a plain yes/no, wire a native `confirm()` through a `data-confirm` attribute.)

<div class="cp-demo" markdown="0">
<div class="demo">
<div class="modal-stage shaded">
<div class="modal alert">
<div class="body"><span class="alert-ic"><svg class="ic"><use href="#i-warning"></use></svg></span>
<p>Are you sure you want to delete “Spring Sale” and all of its related content? This can’t be undone.</p>
</div>
<div class="buttons right"><button class="btn">Cancel</button><button class="btn submit" style="--red-600:#dc2626">Delete</button></div>
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
| `.modal .body` | Conventional content region of a bare modal (there is no `.header` / `.footer` class) |
| `.modal.fitted` | Shrinks to its content instead of a fixed size |
| `.modal.fullscreen` | Fills the viewport, square corners |
| `.modal.alert` | Insets a warning icon beside the body |
| `.cpmodal` | Structured modal built by `Craft.CpModal`: `.cpmodal-body` › `.cpmodal-content` + `.cpmodal-footer` |
| `.hud` | Small anchored popover with a tip arrow |
