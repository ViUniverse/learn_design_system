import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foldable_info/foldable_info.dart';
import 'package:learn_design_system/learn_design_system.dart';

final corner = ViewArea(
  type: AreaType.blocked,
  rect: Rect.fromLTRB(535, 0, 669, 82),
  isActive: true,
  source: DataSource.ios,
  direction: AreaDirection.unknown,
  cover: AreaCover.unknown,
);

LearnScrollLayout layout({
  Rect frame = const Rect.fromLTRB(32, 16, 637, 82),
  bool ready = true,
  List<ViewArea>? areas,
  double minimumWidth = 320,
}) => LearnScrollLayout.resolve(
  headerFrame: frame,
  safeTop: 82,
  windowSafeTop: 82,
  topRegionsReady: ready,
  areas: areas ?? [corner],
  minimumWidth: minimumWidth,
);

void main() {
  test('Duo corner reserves only the intersecting header interval', () {
    final value = layout();
    expect(value.topPadding, 0);
    expect(value.headerInsets, const EdgeInsets.only(right: 102));
    expect(value.headerMinHeight, 66);
    expect(value.usesTopRegions, true);
  });
  test('A master pane left of the status area needs no top strip', () {
    final value = layout(frame: const Rect.fromLTRB(20, 16, 500, 82));
    expect(value.headerInsets, EdgeInsets.zero);
    expect(value.headerMinHeight, 0);
    expect(value.topPadding, 0);
  });
  test('A left status corner moves only the first header to the right', () {
    final value = layout(
      areas: [
        ViewArea(
          type: AreaType.blocked,
          rect: Rect.fromLTRB(0, 0, 134, 82),
          source: DataSource.ios,
          direction: AreaDirection.unknown,
          cover: AreaCover.unknown,
        ),
      ],
    );
    expect(value.headerInsets, const EdgeInsets.only(left: 102));
    expect(value.topPadding, 0);
    expect(value.headerMinHeight, 66);
  });
  test(
    'Stale, missing, inactive or Android cutout data cannot waive safe area',
    () {
      expect(layout(ready: false).topPadding, 82);
      expect(layout(areas: []).topPadding, 82);
      expect(
        layout(
          areas: [
            ViewArea(
              type: AreaType.blocked,
              rect: Rect.fromLTRB(535, 0, 669, 82),
              isActive: false,
              source: DataSource.ios,
              direction: AreaDirection.unknown,
              cover: AreaCover.unknown,
            ),
          ],
        ).topPadding,
        82,
      );
      expect(
        layout(
          areas: [
            ViewArea(
              type: AreaType.blocked,
              rect: Rect.fromLTRB(180, 0, 240, 82),
              source: DataSource.android,
              direction: AreaDirection.unknown,
              cover: AreaCover.unknown,
            ),
          ],
        ).topPadding,
        82,
      );
    },
  );
  test('Full-width status or large text falls back to the OS top inset', () {
    expect(
      layout(
        areas: [
          ViewArea(
            type: AreaType.blocked,
            rect: Rect.fromLTRB(0, 0, 669, 82),
            source: DataSource.ios,
            direction: AreaDirection.unknown,
            cover: AreaCover.unknown,
          ),
        ],
      ).topPadding,
      82,
    );
    expect(layout(minimumWidth: 640).topPadding, 82);
  });
  testWidgets('Header clears the corner and body starts below status', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(669, 951);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final value = layout();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
              children: [
                value.header(
                  const SizedBox(
                    key: ValueKey('header'),
                    height: 54,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(
                  key: ValueKey('body'),
                  height: 1000,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    expect(
      tester
          .getRect(find.byKey(const ValueKey('header')))
          .overlaps(corner.rect),
      false,
    );
    expect(
      tester.getRect(find.byKey(const ValueKey('body'))).top,
      greaterThanOrEqualTo(82),
    );
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    expect(tester.getRect(find.byType(SingleChildScrollView)).top, 0);
    expect(tester.getRect(find.byKey(const ValueKey('body'))).top, lessThan(0));
  });
}
