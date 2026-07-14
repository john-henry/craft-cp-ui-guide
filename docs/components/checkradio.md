# Checkbox & radio

<div class="cp-demo" markdown="0">
<div class="grid2">
<div>
<div class="demo">
<label class="checkbox-row"><span class="cbx checked"></span> Enable comments</label>
<label class="checkbox-row"><span class="cbx"></span> Allow guest authors</label>
<label class="checkbox-row"><span class="cbx checked"></span> Send notifications</label>
</div>
<div class="code"><span class="tag">Twig</span><button class="cp-copy">Copy</button>
<pre><span class="tok-k">{{</span> forms.checkboxGroupField({
  label: <span class="tok-s">"Options"</span>,
  name: <span class="tok-s">"options"</span>,
  values: [<span class="tok-s">"comments"</span>,<span class="tok-s">"notify"</span>],
  options: [
    {label:<span class="tok-s">"Enable comments"</span>,value:<span class="tok-s">"comments"</span>},
    {label:<span class="tok-s">"Allow guests"</span>,value:<span class="tok-s">"guests"</span>},
    {label:<span class="tok-s">"Send notifications"</span>,value:<span class="tok-s">"notify"</span>},
  ],
}) <span class="tok-k">}}</span></pre></div>
</div>
<div>
<div class="demo">
<label class="radio-row"><span class="rdo checked"></span> Draft</label>
<label class="radio-row"><span class="rdo"></span> Pending review</label>
<label class="radio-row"><span class="rdo"></span> Published</label>
</div>
<div class="code"><span class="tag">Twig</span><button class="cp-copy">Copy</button>
<pre><span class="tok-k">{{</span> forms.radioGroupField({
  label: <span class="tok-s">"Status"</span>,
  name: <span class="tok-s">"status"</span>,
  value: <span class="tok-s">"draft"</span>,
  options: [
    {label:<span class="tok-s">"Draft"</span>,value:<span class="tok-s">"draft"</span>},
    {label:<span class="tok-s">"Pending review"</span>,value:<span class="tok-s">"pending"</span>},
    {label:<span class="tok-s">"Published"</span>,value:<span class="tok-s">"live"</span>},
  ],
}) <span class="tok-k">}}</span></pre></div>
</div>
</div>
</div>
