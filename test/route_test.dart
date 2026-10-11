import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foldable_info/foldable_info.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_design_system/learn_design_system.dart';
import 'window_test.dart' show TestInfo, snapshot, ready;

class CounterPage extends StatefulWidget {
  const CounterPage(this.label, {super.key});
  final String label;
  @override
  State<CounterPage> createState() => CounterPageState();
}

class CounterPageState extends State<CounterPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Text('${widget.label}: $count'),
          TextButton(
            onPressed: () => setState(() => count++),
            child: Text('Add ${widget.label}'),
          ),
          TextButton(
            onPressed: () => context.go('/home/7?mode=read#word'),
            child: const Text('Open 7'),
          ),
          TextButton(onPressed: () => context.pop(), child: const Text('Back')),
        ],
      ),
    ),
  );
}

void main() {
  Future<GoRouter> start(
    WidgetTester tester, {
    Size size = const Size(1000, 700),
    String location = '/home',
    List<ui.DisplayFeature> features = const [],
    TestInfo? info,
    bool bar = false,
    EdgeInsets padding = EdgeInsets.zero,
    bool reduce = false,
    bool toolbar = false,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.reset);
    final router = GoRouter(
      initialLocation: location,
      routes: [
        LearnRoute(
          path: '/home',
          builder: (_, _) => const CounterPage('Home'),
          barBuilder: bar
              ? (_, _) => LearnRouteBar(
                  destinations: const [
                    LearnDestination(label: 'Home', icon: Icons.home),
                    LearnDestination(label: 'Library', icon: Icons.book),
                  ],
                  selected: 0,
                  onSelected: (_) {},
                )
              : null,
          details: [
            GoRoute(
              path: ':id',
              name: 'detail',
              builder: (_, state) => toolbar
                  ? const Scaffold(
                      body: SafeArea(
                        child: LearnToolbar(actions: [Icon(Icons.book)]),
                      ),
                    )
                  : CounterPage(
                      'Detail ${state.pathParameters['id']} '
                      '${state.uri.queryParameters['mode'] ?? ''}',
                    ),
              routes: [
                GoRoute(
                  path: 'note',
                  builder: (_, _) => const CounterPage('Note'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        theme: learnTheme(Brightness.light),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            displayFeatures: features,
            padding: padding,
            viewPadding: padding,
            disableAnimations: reduce,
          ),
          child: LearnWindow(info: info, child: child!),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return router;
  }

  Rect pane(WidgetTester tester, String name) =>
      tester.getRect(find.byKey(ValueKey('learn-$name-pane')));

  testWidgets('Deep link opens two panes and Back returns to the list', (
    tester,
  ) async {
    final router = await start(tester, location: '/home/7?mode=read#word');
    expect(find.text('Detail 7 read: 0'), findsOneWidget);
    expect(pane(tester, 'master').right, lessThan(pane(tester, 'detail').left));
    expect(router.canPop(), true);
    router.pop();
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/home');
    expect(find.text('Home: 0'), findsOneWidget);
    expect(pane(tester, 'master'), const Rect.fromLTWH(0, 0, 1000, 700));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Compact detail is one screen; widening keeps both page states', (
    tester,
  ) async {
    final router = await start(tester, size: const Size(390, 844));
    await tester.tap(find.text('Add Home'));
    await tester.tap(find.text('Open 7').first);
    await tester.pumpAndSettle();
    expect(pane(tester, 'detail'), const Rect.fromLTWH(0, 0, 390, 844));
    final detail = tester.state(
      find.byWidgetPredicate(
        (w) => w is CounterPage && w.label.startsWith('Detail'),
      ),
    );
    await tester.tap(find.text('Add Detail 7 read'));
    tester.view.physicalSize = const Size(1000, 700);
    await tester.pumpAndSettle();
    expect(find.text('Home: 1'), findsOneWidget);
    expect(find.text('Detail 7 read: 1'), findsOneWidget);
    expect(
      tester.state(
        find.byWidgetPredicate(
          (w) => w is CounterPage && w.label.startsWith('Detail'),
        ),
      ),
      same(detail),
    );
    expect(
      router.routeInformationProvider.value.uri.toString(),
      '/home/7?mode=read#word',
    );
    tester.view.physicalSize = const Size(390, 844);
    await tester.pumpAndSettle();
    router.pop();
    await tester.pumpAndSettle();
    expect(find.text('Home: 1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Nested details, named routes and replaced IDs use GoRouter', (
    tester,
  ) async {
    final router = await start(tester);
    router.goNamed('detail', pathParameters: {'id': '9'});
    await tester.pumpAndSettle();
    expect(find.text('Detail 9 : 0'), findsOneWidget);
    router.go('/home/10');
    await tester.pumpAndSettle();
    expect(find.text('Detail 10 : 0'), findsOneWidget);
    router.push('/home/10/note');
    await tester.pumpAndSettle();
    expect(find.text('Note: 0'), findsOneWidget);
    router.pop();
    await tester.pumpAndSettle();
    expect(find.text('Detail 10 : 0'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tabletop uses the actual division and keeps the same detail', (
    tester,
  ) async {
    await start(
      tester,
      size: const Size(900, 900),
      location: '/home/7',
      features: const [
        ui.DisplayFeature(
          bounds: Rect.fromLTWH(0, 430, 900, 40),
          type: ui.DisplayFeatureType.hinge,
          state: ui.DisplayFeatureState.postureHalfOpened,
        ),
      ],
    );
    expect(pane(tester, 'master').bottom, 430);
    expect(pane(tester, 'detail').top, 470);
    expect(find.text('Detail 7 : 0'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('A native revision never inserts a flat layout between hinges', (
    tester,
  ) async {
    final info = TestInfo();
    addTearDown(info.handle.controller.close);
    await start(
      tester,
      size: const Size(1000, 600),
      location: '/home/7',
      info: info,
    );
    info.handle.controller.add(snapshot(tester.view));
    await tester.pumpAndSettle();
    expect(pane(tester, 'detail').left, 410);
    final before = pane(tester, 'detail');
    info.handle.controller.add(
      snapshot(tester.view, revision: 2).copyWith(
        areas: ready([
          ViewArea(
            type: AreaType.fold,
            rect: const Rect.fromLTWH(510, 0, 20, 600),
            isActive: true,
            source: DataSource.ios,
            direction: AreaDirection.topToBottom,
            cover: AreaCover.unknown,
          ),
        ]),
      ),
    );
    await tester.pump();
    expect(pane(tester, 'detail').left, before.left);
    for (var frame = 0; frame < 20; frame++) {
      await tester.pump(const Duration(milliseconds: 16));
      final left = pane(tester, 'detail').left;
      expect(left, inInclusiveRange(410, 530));
      expect(
        LearnWindowData.maybeOf(
          tester.element(find.byType(LearnRouteView)),
        )!.nativeReady,
        true,
      );
    }
    expect(pane(tester, 'detail').left, 530);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Bottom and rail bars reserve only their own content space', (
    tester,
  ) async {
    final router = await start(tester, size: const Size(390, 844), bar: true);
    final bottom = tester.getRect(find.byType(LearnNavigationBar));
    final masterPage = find.descendant(
      of: find.byWidgetPredicate((w) => w is CounterPage && w.label == 'Home'),
      matching: find.byType(Scaffold),
    );
    expect(tester.getRect(masterPage).bottom, bottom.top);
    expect(bottom.bottom, 844);
    router.go('/home/7');
    await tester.pumpAndSettle();
    expect(find.byType(LearnNavigationBar), findsNothing);
    expect(pane(tester, 'detail'), const Rect.fromLTWH(0, 0, 390, 844));
    tester.view.physicalSize = const Size(1000, 700);
    await tester.pumpAndSettle();
    final rail = tester.getRect(find.byType(LearnNavigationRail));
    expect(pane(tester, 'master').left, rail.right);
    expect(pane(tester, 'master').right, lessThan(pane(tester, 'detail').left));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Duo bar stays beneath camera without double safe padding', (
    tester,
  ) async {
    final info = TestInfo();
    addTearDown(info.handle.controller.close);
    await start(
      tester,
      size: const Size(1000, 700),
      location: '/home/7',
      info: info,
      bar: true,
    );
    info.handle.controller.add(
      snapshot(tester.view).copyWith(
        ios: ready(
          IosInfo(
            widthClass: ready(IosSize.regular),
            heightClass: ready(IosSize.regular),
            barSide: ready(BarSide.end),
            safeArea: ready(const EdgeInsets.only(right: 88, bottom: 20)),
          ),
        ),
        areas: ready([
          ViewArea(
            type: AreaType.blocked,
            rect: const Rect.fromLTWH(912, 0, 88, 150),
            isActive: true,
            source: DataSource.ios,
            direction: AreaDirection.unknown,
            cover: AreaCover.unknown,
          ),
        ]),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.getRect(find.byKey(const ValueKey('native-edge-navigation'))),
      const Rect.fromLTWH(912, 158, 88, 514),
    );
    expect(pane(tester, 'master').left, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Resize waits for the matching native map without a flat detour',
    (tester) async {
      final info = TestInfo();
      addTearDown(info.handle.controller.close);
      await start(
        tester,
        size: const Size(1000, 600),
        location: '/home/7',
        info: info,
      );
      info.handle.controller.add(snapshot(tester.view));
      await tester.pumpAndSettle();
      tester.view.physicalSize = const Size(1100, 600);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 80));
      expect(pane(tester, 'detail').left, 410);
      expect(
        LearnWindowData.maybeOf(
          tester.element(find.byType(LearnRouteView)),
        )!.isChanging,
        true,
      );
      info.handle.controller.add(
        snapshot(tester.view, revision: 2).copyWith(
          areas: ready([
            ViewArea(
              type: AreaType.fold,
              rect: const Rect.fromLTWH(530, 0, 20, 600),
              isActive: true,
              source: DataSource.ios,
              direction: AreaDirection.topToBottom,
              cover: AreaCover.unknown,
            ),
          ]),
        ),
      );
      await tester.pump();
      for (var frame = 0; frame < 20; frame++) {
        await tester.pump(const Duration(milliseconds: 16));
        expect(pane(tester, 'detail').left, inInclusiveRange(410, 550));
      }
      expect(pane(tester, 'detail').left, 550);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('Closing while native is late keeps a usable toolbar', (
    tester,
  ) async {
    final info = TestInfo();
    addTearDown(info.handle.controller.close);
    await start(
      tester,
      size: const Size(1000, 600),
      location: '/home/7',
      info: info,
      toolbar: true,
    );
    info.handle.controller.add(snapshot(tester.view));
    await tester.pumpAndSettle();
    tester.view.physicalSize = const Size(390, 844);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(pane(tester, 'detail').left, 0);
    expect(pane(tester, 'detail').width, 390);
    expect(
      tester.getSize(find.byType(LearnToolbar)).width,
      greaterThanOrEqualTo(48),
    );
    expect(tester.takeException(), isNull);
    info.handle.controller.add(
      snapshot(tester.view, revision: 2).copyWith(areas: ready([])),
    );
    await tester.pumpAndSettle();
    expect(pane(tester, 'detail'), const Rect.fromLTWH(0, 0, 390, 844));
    expect(tester.takeException(), isNull);
  });

  testWidgets('A route without a bar can split without reserving a rail', (
    tester,
  ) async {
    await start(
      tester,
      size: const Size(720, 700),
      location: '/home/7',
      reduce: true,
    );
    expect(pane(tester, 'master').right, lessThan(pane(tester, 'detail').left));
    expect(
      LearnRouteData.of(
        tester.element(find.text('Home: 0')),
      ).layout.navigationWidth,
      0,
    );
    tester.view.physicalSize = const Size(390, 700);
    await tester.pump();
    expect(pane(tester, 'detail'), const Rect.fromLTWH(0, 0, 390, 700));
    expect(tester.takeException(), isNull);
  });
}
