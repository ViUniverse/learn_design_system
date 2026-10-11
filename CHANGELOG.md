# Changelog

## 0.1.2

- Add `LearnScrollLayout`: keep scroll viewports edge-to-edge while initial
  content avoids system UI, using current iOS top regions when a header fits
  beside the status bar.
- Preserve the OS top inset when regions are missing, stale, inactive, too
  narrow, or describe only an Android camera cutout.
- Protect system icon contrast over scrolling content without a fixed blank
  strip; expose `LearnWindowData.topRegionsReady` for the stricter readiness check.

## 0.1.1

- Keep Home/master on the left and player/detail on the right, independently of
  the native navigation edge, for flat and vertically divided windows.
- Apply the right camera inset only to the right pane; preserve native rail placement.

## 0.1.0

- Extract Learn Design System into a standalone Flutter package.
- Provide semantic light/dark themes, bundled SN Pro typography and controls.
- Add adaptive panes, toolbar/navigation layout and native window measurements.
- Include the foundation/component/compose specification, tokens and HTML showcase.
- Rename the workspace package from `vi_learn_design_system` to `learn_design_system`.
