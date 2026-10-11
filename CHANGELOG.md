# Changelog

## 0.2.0

- Add `LearnRoute` for GoRouter: declare master and detail routes once. Compact
  windows show a normal detail page; wide windows show master left/detail right,
  and tabletop windows show master above/detail below.
- Keep one detail Navigator and its page state while panes move. Standard deep
  links, named routes, Back, changed IDs and nested detail routes use GoRouter.
- Add `LearnRouteData` and `LearnRouteBar`; the shell owns bottom, rail and native
  edge navigation placement. Bottom bars use a single layout pass.
- Use fresh same-size native revisions immediately; hold the chosen split while
  waiting for a resized view's native map and fit its frames to the new canvas.
- Avoid adding out-of-view distances to pane insets during a fold transition.
- Allow pane policy to omit navigation width when no bar is supplied.
- Support GoRouter 16.3 through 18.x without raising the Flutter 3.38 minimum.

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
