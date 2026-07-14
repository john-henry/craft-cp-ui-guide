# Typography

The CP uses the platform system-UI stack — no web fonts to load. Base size is **14px** with a **1.42** line-height, and body text sits at `--gray-700`. Headings darken to `--gray-900`; secondary text lightens to `--gray-550` (`--fg-subtle`).

<div class="cp-demo" markdown="0">
<div class="demo">
<div style="font-size:22px; color:var(--gray-900); font-weight:700; letter-spacing:-.01em">Heading — section title</div>
<div style="font-size:16px; color:var(--gray-800); font-weight:600; margin-top:10px">Subheading — field group label</div>
<p style="margin:10px 0 0; max-width:60ch">Body copy at the base 14px / 1.42 rhythm in <code>--gray-700</code>. This is the default for instructions, help text, and table cells. Links appear in <a href="#">sky blue</a>.</p>
<p style="margin:8px 0 0; color:var(--fg-subtle); font-size:12.5px">Subtle / instructions text — 12.5px, <code>--fg-subtle</code>. Used under labels.</p>
<p style="margin:8px 0 0; font-family:var(--mono); font-size:13px; background:var(--gray-050); display:inline-block; padding:2px 7px; border-radius:4px">Monospace for code, handles &amp; tokens</p>
</div>
</div>

```css
--font-size: 14px;      /* base */
--lh: 1.42em;          /* line-height */
--text-color: var(--gray-700);
font-family: system-ui, BlinkMacSystemFont, -apple-system,
             "Segoe UI", Roboto, sans-serif;
```
