# Typography

The CP uses the platform system-UI stack — no web fonts to load. Body text renders at roughly **14px** with `--size-line-height: 1.42em`; secondary text uses `--fg-subtle` (`var(--gray-550)`). The pixel sizes here are rendered values applied at runtime — Craft doesn't expose a `--font-size` token, so match against the tokens that *do* exist (`--size-line-height`, `--fg-subtle`, and the `--gray-*` scale) rather than hard-coding sizes.

<div class="cp-demo" markdown="0">
<div class="demo">
<div style="font-size:22px; color:var(--gray-900); font-weight:700; letter-spacing:-.01em">Heading — section title</div>
<div style="font-size:16px; color:var(--gray-800); font-weight:600; margin-top:10px">Subheading — field group label</div>
<p style="margin:10px 0 0; max-width:60ch">Body copy at the base 14px / 1.42 rhythm in <code>--gray-700</code>. This is the default for instructions, help text, and table cells. Links appear in <a href="#">sky blue</a>.</p>
<p style="margin:8px 0 0; color:var(--fg-subtle); font-size:12.5px">Subtle / instructions text — <code>--fg-subtle</code>. Used under labels.</p>
<p style="margin:8px 0 0; font-family:var(--mono); font-size:13px; background:var(--gray-050); display:inline-block; padding:2px 7px; border-radius:4px">Monospace for code, handles &amp; tokens</p>
</div>
</div>

```css
--size-line-height: 1.42em;    /* real CP token */
--fg-subtle: var(--gray-550);  /* secondary / instructions text */
/* Base font-size (~14px) is applied at runtime — there is no --font-size token */
font-family: system-ui, BlinkMacSystemFont, -apple-system,
             "Segoe UI", Roboto, sans-serif;
```
