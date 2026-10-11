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
| Compose | `LearnRoute`, `LearnRouteView`, `LearnRouteData`, `LearnRouteBar`, `LearnWindow`, `LearnPaneLayout`, `LearnNavigationLayout`, `LearnScrollLayout`, `LearnAreaClipper`, `mediaQueryForPane`, `LearnToolbar`, `LearnNavigationBar`, `LearnNavigationRail`, `LearnScrollAnchor` |

The catalog contains 16 foundation, 64 component and 8 compose contracts. This
table describes implemented APIs, not a claim that every catalog item is a
separate implemented widget.

## Adaptive app surface

```dart
final router = GoRouter(routes: [
  LearnRoute(
    path: '/lessons',
    builder: (context, state) => const LessonList(),
    details: [
      GoRoute(
        path: ':id',
        builder: (context, state) => LessonPage(
          id: state.pathParameters['id']!,
        ),
      ),
    ],
  ),
]);

MaterialApp.router(
  routerConfig: router,
  theme: learnTheme(Brightness.light),
  darkTheme: learnTheme(Brightness.dark),
  builder: (context, child) => LearnWindow(child: child!),
);
```

Import `package:go_router/go_router.dart` for `GoRouter` and `GoRoute`.
`LessonList` and `LessonPage` are your app's pages. Open a detail with
`context.go('/lessons/7')`; `context.pop()` returns to the list, including after
an initial deep link. Named routes, query parameters and nested details use
GoRouter as usual. Put detail routes in `details`, on this shell's Navigator;
a detail with a different `parentNavigatorKey` intentionally leaves its pane.

`LearnRoute` shows a full detail page on a small window, master left/detail
right on a wide window, and master above/detail below a tabletop division.
The same detail Navigator and page state stay mounted when the window changes.
Your app does not choose panes or move pages. Keep shared business controllers
outside the route so Back and reopening a detail can use the same session.

Optionally add `barBuilder` returning `LearnRouteBar`, with `destinations`,
`selected` and `onSelected`. The route reserves the bar's space and chooses a
bottom bar, rail or native edge strip. The native strip stays below camera/status
regions without subtracting safe padding twice. Destinations and taps belong
to the app. With no bar, no rail width is reserved.

The window wraps the navigator so menus and modal routes also receive current
native regions. Place pane SafeAreas inside it. `LearnWindowData.maybeOf(context)`
exposes readiness, active areas and the native navigation-side hint.
`LearnRouteData.of(context).frame` is the pane's target frame in window
coordinates; `size` is the whole window size. Ordinary pages use local
`MediaQuery` and constraints. Frame changes animate for 260 ms, or immediately
with reduced motion. During resize, the route waits for a matching native map
before choosing another split. A new revision in the same box is mapped in the
current frame, so a real division is not briefly removed.

For scrolling pages, keep the viewport edge-to-edge and add
`LearnScrollLayout.topPadding` to the initial content padding. Wrap only the first
header with `layout.header(...)`. Pass the header frame in window coordinates,
the pane/window top insets, current areas and `topRegionsReady`. Detailed iOS
regions may allow that header beside the status bar. An Android camera cutout
alone cannot establish where status icons are, so the OS inset remains the
fallback. `LearnWindow` protects status icon contrast over scrolled content.

See the [adaptive window contract](docs/compose/adaptive-window.md) for fallback,
coordinate and keyboard limits. Native measurements do not select a UX for the
application by themselves.

## Responsibilities

The package depends on Flutter, `foldable_info` for measurements and
`go_router` for its adaptive route shell. It owns
theme, reusable presentation and adaptive layout policy. It has no dependency
on applications, repositories, network, storage, authentication or playback
engines. App/domain owns lessons, session state, routes and persistence. Widgets
receive values and callbacks. The app continues to use clearly labeled mock
data.

Code and authored documentation use the [MIT license](LICENSE). SN Pro and
Pecita fonts retain SIL OFL 1.1; see [third-party notices](THIRD_PARTY_NOTICES.md).
