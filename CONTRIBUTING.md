# Contributing

Thanks for helping keep this reference accurate! It's a community resource, and the most
valuable contributions are **corrections where the guide has drifted from current Craft**.

**The contributing guide lives in the docs:
[Contributing](https://john-henry.github.io/craft-cp-ui-guide/contributing/)** — ground rules,
how to run the site locally, how the live previews are built, and how to add a page. Source:
[`docs/contributing.md`](docs/contributing.md).

It's kept there rather than duplicated here so it can't drift out of sync with the guide it
describes.

## The short version

```bash
make serve      # preview at http://localhost:8000/craft-cp-ui-guide/
make build      # render with --strict — run this before opening a PR
```

- Documents **Craft CMS 5.x**; note the version your change applies to.
- Cite **primary sources** — the file/line in `craftcms/cms`, `craftcms/commerce`, or
  `craftcms/shopify` your change is based on.
- Use the class names Craft **actually emits**, not an approximation that looks right.

Open a PR against `main`; the deploy workflow publishes automatically once merged.
