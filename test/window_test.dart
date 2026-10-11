import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foldable_info/foldable_info.dart';
import 'package:learn_design_system/learn_design_system.dart';

DataValue<T> ready<T>(T value) => DataValue.ready(
  value,
  source: DataSource.ios,
  readAt: DateTime.utc(2026, 10, 11),
);

class TestInfo extends FoldableInfo {
  final handle = TestView();
  @override
  FoldableView forView(ui.FlutterView view) {
    handle.id = view.viewId;
    return handle;
  }
}

class TestView implements FoldableView {
  int id = 0, subscriptions = 0, cancellations = 0;
  late final controller = StreamController<FoldableData>.broadcast(
    onListen: () => subscriptions++,
    onCancel: () => cancellations++,
  );
  @override
  int get viewId => id;
  @override
  Stream<FoldableData> watch() => controller.stream;
  @override
  Future<FoldableData> read({Duration timeout = const Duration(seconds: 5)}) =>
      throw UnimplementedError();
  @override
  Future<FoldAngles> readAngles({
    Duration timeout = const Duration(seconds: 5),
  }) => throw StateError('Layout must not subscribe to angle data');
  @override
  Stream<FoldAngles> watchAngles() =>
      throw StateError('Layout must not subscribe to angle data');
}

FoldableData snapshot(ui.FlutterView view, {int revision = 1, Size? size}) =>
    FoldableData(
      viewId: view.viewId,
      sessionId: 'native',
      revision: revision,
      viewState: ViewState.ready,
      view: ready(
        ViewInfo(
          size: size ?? view.physicalSize / view.devicePixelRatio,
          pixelRatio: view.devicePixelRatio,
          padding: EdgeInsets.zero,
          insets: EdgeInsets.zero,
          gestureInsets: EdgeInsets.zero,
        ),
      ),
      isFoldable: ready(true),
      folds: ready([]),
      areas: ready([
        ViewArea(
          type: AreaType.fold,
          rect: const Rect.fromLTWH(390, 0, 20, 600),
          isActive: true,
          source: DataSource.ios,
          direction: AreaDirection.topToBottom,
          cover: AreaCover.unknown,
        ),
        ViewArea(
          type: AreaType.blocked,
          rect: const Rect.fromLTWH(0, 0, 800, 300),
          isActive: false,
          source: DataSource.ios,
          direction: AreaDirection.unknown,
          cover: AreaCover.unknown,
        ),
      ]),
      ios: ready(
        IosInfo(
          widthClass: ready(IosSize.regular),
          heightClass: ready(IosSize.regular),
          barSide: ready(BarSide.end),
          safeArea: ready(const EdgeInsets.only(right: 40)),
        ),
      ),
    );

void main() {
  for (final brightness in Brightness.values) {
    testWidgets('Reserved margins keep an opaque $brightness background', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final info = TestInfo();
      addTearDown(info.handle.controller.close);
      final capture = GlobalKey();
      var taps = 0;
      Color? background;
      await tester.pumpWidget(
        MaterialApp(
          theme: learnTheme(brightness),
          home: RepaintBoundary(
            key: capture,
            child: LearnWindow(
              info: info,
              child: Builder(
                builder: (context) {
                  background = context.color('background');
                  return ClipPath(
                    clipper: LearnAreaClipper(
                      MediaQuery.of(context).displayFeatures,
                    ),
                    child: GestureDetector(
                      onTap: () => taps++,
                      child: const ColoredBox(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
      info.handle.controller.add(snapshot(tester.view));
      await tester.pumpAndSettle();
      final boundary =
          capture.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final pixels = await tester.runAsync(() async {
        final image = await boundary.toImage();
        try {
          return await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        } finally {
          image.dispose();
        }
      });
      final offset = (200 * 800 + 400) * 4;
      final argb = background!.toARGB32();
      expect(pixels!.buffer.asUint8List(offset, 4), [
        (argb >> 16) & 255,
        (argb >> 8) & 255,
        argb & 255,
        255,
      ]);
      await tester.tapAt(const Offset(400, 200));
      expect(taps, 0);
      await tester.tapAt(const Offset(200, 200));
      expect(taps, 1);
      final style = tester
          .widget<AnnotatedRegion<SystemUiOverlayStyle>>(
            find.byType(AnnotatedRegion<SystemUiOverlayStyle>),
          )
          .value;
      expect(
        style.statusBarIconBrightness,
        brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      );
      expect(style.statusBarColor, Colors.transparent);
    });
  }
  for (final ratio in [1.0, 3.0]) {
    testWidgets(
      'Native areas stay current and cancel with the surface at ratio $ratio',
      (tester) async {
        tester.view.physicalSize = const Size(800, 600) * ratio;
        tester.view.devicePixelRatio = ratio;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final info = TestInfo();
        addTearDown(info.handle.controller.close);
        LearnWindowData? window;
        MediaQueryData? media;
        await tester.pumpWidget(
          MaterialApp(
            home: LearnWindow(
              info: info,
              child: Builder(
                builder: (context) {
                  window = LearnWindowData.maybeOf(context);
                  media = MediaQuery.of(context);
                  return const SizedBox.expand();
                },
              ),
            ),
          ),
        );
        info.handle.controller.add(snapshot(tester.view));
        await tester.pumpAndSettle();
        expect(window!.nativeReady, true);
        expect(window!.areas, hasLength(1));
        expect(
          media!.displayFeatures.single.bounds,
          const Rect.fromLTWH(390, 0, 20, 600),
        );
        expect(media!.viewPadding.right, 40);
        expect(window!.navigationSide, BarSide.end);
        expect(info.handle.subscriptions, 1);

        tester.view.physicalSize = const Size(600, 800) * ratio;
        await tester.pumpAndSettle();
        expect(window!.nativeReady, false);
        expect(media!.displayFeatures, isEmpty);
        expect(media!.viewPadding.right, 0);
        info.handle.controller.add(snapshot(tester.view, revision: 2));
        await tester.pumpAndSettle();
        expect(window!.nativeReady, true);
        expect(info.handle.subscriptions, 1);

        info.handle.controller.addError(StateError('Bridge paused'));
        await tester.pumpAndSettle();
        expect(window!.nativeReady, false);
        expect(media!.displayFeatures, isEmpty);
        await tester.pumpWidget(const SizedBox());
        expect(info.handle.cancellations, 1);
        expect(tester.takeException(), isNull);
      },
    );
  }
  test('A native trailing rail respects an off-center hinge and RTL', () {
    final layout = LearnPaneLayout.resolve(
      size: const Size(1000, 700),
      textScaler: TextScaler.noScaling,
      navigationSide: BarSide.end,
      features: const [
        ui.DisplayFeature(
          bounds: Rect.fromLTWH(420, 0, 24, 700),
          type: ui.DisplayFeatureType.hinge,
          state: ui.DisplayFeatureState.postureHalfOpened,
        ),
      ],
    );
    expect(layout.browse, const Rect.fromLTWH(444, 0, 556, 700));
    expect(layout.detail, const Rect.fromLTWH(0, 0, 420, 700));
    expect(layout.navigationOnRight, true);
    expect(layout.split, true);
    expect(
      LearnPaneLayout.resolve(
        size: const Size(1000, 700),
        textScaler: TextScaler.noScaling,
        direction: TextDirection.rtl,
        navigationSide: BarSide.end,
      ).navigationOnRight,
      false,
    );
  });

  test('Subpixel fold coordinates still separate the whole surface', () {
    final layout = LearnPaneLayout.resolve(
      size: const Size(669, 951),
      textScaler: TextScaler.noScaling,
      features: const [
        ui.DisplayFeature(
          bounds: Rect.fromLTRB(0, 455.5, 668.9999999999, 495.5),
          type: ui.DisplayFeatureType.fold,
          state: ui.DisplayFeatureState.postureHalfOpened,
        ),
      ],
    );
    expect(layout.axis, Axis.vertical);
    expect(layout.separated, true);
    expect(layout.detail.top, 495.5);
  });

  test(
    'A narrow native fold pane reuses its side strip without losing split',
    () {
      final layout = LearnPaneLayout.resolve(
        size: const Size(951, 669),
        textScaler: TextScaler.noScaling,
        safeArea: const EdgeInsets.only(right: 84),
        navigationSide: BarSide.end,
        features: const [
          ui.DisplayFeature(
            bounds: Rect.fromLTRB(455.5, 0, 495.5, 669),
            type: ui.DisplayFeatureType.fold,
            state: ui.DisplayFeatureState.postureHalfOpened,
          ),
        ],
      );
      expect(layout.navigationWidth, 0);
      expect(layout.edgeNavigationFrame!.left, 867);
      expect(layout.split, true);
      expect(layout.browse.left, 495.5);
      expect(layout.detail.right, 455.5);
    },
  );

  test('An active fold band is excluded from painting and pointer paths', () {
    const fold = ui.DisplayFeature(
      bounds: Rect.fromLTRB(0, 455.5, 669, 495.5),
      type: ui.DisplayFeatureType.fold,
      state: ui.DisplayFeatureState.postureHalfOpened,
    );
    final path = const LearnAreaClipper([fold]).getClip(const Size(669, 951));
    expect(path.contains(const Offset(100, 475)), false);
    expect(path.contains(const Offset(100, 450)), true);
    expect(path.contains(const Offset(100, 500)), true);
  });
}
