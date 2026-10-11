# Learn Design System

The current Vi Learn design, extracted from the ViListen prototype. Neutral
actions and surfaces, muted iris accents, SN Pro type and warm editorial art.
This package is distinct from the removed OpenAI Apps SDK UI port.

## Three groups

- **Foundation:** semantic color roles, light/dark theme, typography and tokens.
- **Component:** buttons, inputs, select, menu, navigation, cards and progress.
- **Compose:** responsive panes, scroll anchors, adaptive toolbars and navigation.

Import `package:learn_design_system/learn_design_system.dart`.

## Install from GitHub

```yaml
dependencies:
  learn_design_system:
    git:
      url: https://github.com/ViUniverse/learn_design_system.git
      ref: main
```

Requires Flutter 3.38 or newer and Dart 3.10 or newer. The GitHub package resolves
`foldable_info` from pub.dev; the ViAce workspace uses its local member.

```sh
flutter pub get
flutter analyze
flutter test
python3 docs/tools/validate.py
```

Run these commands from the package directory. Open the buildless HTML showcase
with `python3 -m http.server 18769 --bind 127.0.0.1 --directory docs`, then visit
`http://127.0.0.1:18769/showcase/`.

## Specification

The approved specification, JSON/CSS tokens, provenance, generators and HTML
showcase are copied into [docs](docs/README.md), organized in the same three
groups. The specification catalog is broader than the implemented Flutter
controls; implementation coverage is recorded separately.

| Group | Current Flutter API |
| --- | --- |
| Foundation | `lightTokens`, `darkTokens`, `learnTheme`, `LearnColors`, `LearnFreeSpace`, `LearnToolbarLayout` |
| Component | `LearnButton`, `LearnIconButton`, `LearnInput`, `LearnSelect`, `LearnMenu`, `showLearnDialog`, `LearnNavItem`, content cards/art/labels, listening progress |
| Compose | `LearnWindow`, `LearnPaneLayout`, `LearnNavigationLayout`, `LearnAreaClipper`, `mediaQueryForPane`, `LearnToolbar`, `LearnNavigationBar`, `LearnNavigationRail`, `LearnScrollAnchor` |

The catalog contains 16 foundation, 64 component and 8 compose contracts. This
table describes implemented APIs, not a claim that every catalog item is a
separate implemented widget.

## Adaptive app surface

```dart
MaterialApp(
  theme: learnTheme(Brightness.light),
  darkTheme: learnTheme(Brightness.dark),
  builder: (context, child) => LearnWindow(child: child!),
  home: const MyHome(),
);
```

The window wraps the navigator so menus and modal routes also receive current
native regions. Place pane SafeAreas inside it. `LearnWindowData.maybeOf(context)`
exposes readiness, active areas and the native navigation-side hint. The app
passes size, text scale, safe padding and display features to `LearnPaneLayout`;
it retains its controllers while moving existing content between panes.

See the [adaptive window contract](docs/compose/adaptive-window.md) for fallback,
coordinate and keyboard limits. Native measurements do not select a UX for the
application by themselves.

## Responsibilities

The package depends on Flutter and `foldable_info` for measurements. It owns
theme, reusable presentation and adaptive layout policy. It has no dependency
on applications, repositories, network, storage, authentication or playback
engines. App/domain owns lessons, session state, routes and persistence. Widgets
receive values and callbacks. The app continues to use clearly labeled mock
data.

Code and authored documentation use the [MIT license](LICENSE). SN Pro and
Pecita fonts retain SIL OFL 1.1; see [third-party notices](THIRD_PARTY_NOTICES.md).
