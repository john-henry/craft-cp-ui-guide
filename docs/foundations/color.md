# Color

Craft’s palette is a Tailwind-derived ramp plus a bespoke, slightly desaturated gray scale (defined in HSL). Everything is exposed as CSS custom properties, so prefer the semantic token over a raw hex whenever one exists.


## Brand & action

<div class="cp-demo" markdown="0">
<div class="pal">
<div class="chipc"><div class="sw" style="background:var(--red-600)"></div><div class="lb"><b>Craft Red</b><span>--red-600</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--red-700)"></div><div class="lb"><b>Red hover</b><span>--red-700</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-500)"></div><div class="lb"><b>Secondary</b><span>--gray-500</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--sky-600)"></div><div class="lb"><b>Focus/Link</b><span>--sky-600</span></div></div>
</div>
</div>

The primary *submit* button is Craft red (`--red-600`). This is the single loudest color in the CP — reserve it for the one primary action per screen. Secondary/neutral actions use the gray control fill.


## Gray ramp--gray-050 … --gray-1000

<div class="cp-demo" markdown="0">
<div class="pal">
<div class="chipc"><div class="sw" style="background:var(--gray-050)"></div><div class="lb"><b>050</b><span>surfaces</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-100)"></div><div class="lb"><b>100</b><span>body bg</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-150)"></div><div class="lb"><b>150</b><span>sidebar</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-200)"></div><div class="lb"><b>200</b><span>borders</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-400)"></div><div class="lb"><b>400</b><span> </span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-550)"></div><div class="lb"><b>550</b><span>subtle fg</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-700)"></div><div class="lb" style="background:var(--gray-050)"><b>700</b><span>text</span></div></div>
<div class="chipc"><div class="sw" style="background:var(--gray-900)"></div><div class="lb"><b>900</b><span>headings</span></div></div>
</div>
</div>


## Status & feedback

| Meaning | Foreground | Background | Used for |
| --- | --- | --- | --- |
| Enabled / success | `--fg-success` | `--bg-success` / `--bg-enabled` | Live entries, saved states, success notices |
| Pending | — | `--bg-pending` | Pending / scheduled status dots |
| Warning | `--fg-warning` | `--bg-warning` | Field warnings, cautionary notices |
| Error / disabled | `--fg-error` | `--bg-error` / `--bg-disabled` | Validation errors, off/expired status |
| Notice / info | `--fg-notice` | `--bg-notice` | Tips, informational callouts |
