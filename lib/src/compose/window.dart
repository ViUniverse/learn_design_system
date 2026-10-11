import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foldable_info/foldable_info.dart';
import '../foundation/theme.dart';
import 'scroll_layout.dart';

/// Measurements used by compositions, scoped to the Flutter view and box.
class LearnWindowData {
  const LearnWindowData({
    required this.size,
    this.areas = const [],
    this.navigationSide,
    this.nativeReady = false,
    this.origin = Offset.zero,
    this.topRegionsReady = false,
  });
  final Size size;
  final List<ViewArea> areas;
  final BarSide? navigationSide;
  final bool nativeReady;
  final Offset origin;

  /// True only for current, available iOS reserved-region measurements.
  final bool topRegionsReady;

  static LearnWindowData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_WindowScope>()?.data;
}

/// Share native observations once, then translate them to this widget's box.
/// Place around the full app surface, before pane SafeAreas. This scope uses
/// app-surface coordinates; use FoldableSpace directly for transformed widgets.
class LearnWindow extends StatefulWidget {
  const LearnWindow({super.key, required this.child, this.info});
  final Widget child;
  final FoldableInfo? info;
  @override
  State<LearnWindow> createState() => _LearnWindowState();
}

class _LearnWindowState extends State<LearnWindow> {
  final _box = GlobalKey();
  ui.FlutterView? _view;
  FoldableView? _handle;
  StreamSubscription<FoldableData>? _subscription;
  FoldableData? _snapshot;
  LocalAreas? _local;
  Rect? _frame;
  bool _pending = false;
  int _generation = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _connect();
  }

  @override
  void didUpdateWidget(LearnWindow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.info != widget.info) _connect(force: true);
  }

  void _connect({bool force = false}) {
    final view = View.of(context);
    if (!force && identical(view, _view)) return;
    _subscription?.cancel();
    final generation = ++_generation;
    _view = view;
    _handle = (widget.info ?? FoldableInfo.instance).forView(view);
    _snapshot = null;
    _local = null;
    _subscription = _handle!.watch().listen(
      (data) {
        if (!mounted || generation != _generation) return;
        setState(() => _snapshot = data);
      },
      onError: (Object error) {
        // Measurements are optional. Keep Flutter insets/features usable while
        // the bridge is absent, paused, or reports unsupported native APIs.
        if (!mounted || generation != _generation) return;
        setState(() {
          _snapshot = null;
          _local = null;
        });
      },
    );
  }

  @override
  void dispose() {
    ++_generation;
    _subscription?.cancel();
    super.dispose();
  }

  void _measure() {
    if (_pending) return;
    _pending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pending = false;
      if (!mounted) return;
      final render = _box.currentContext?.findRenderObject();
      if (render is! RenderBox || !render.hasSize) return;
      final snapshot = _snapshot;
      final next = snapshot == null
          ? null
          : FoldableSpace.toBox(data: snapshot, target: render, view: _view!);
      final origin = render.localToGlobal(Offset.zero);
      final frame = origin & render.size;
      if (next != _local || frame != _frame) {
        setState(() {
          _local = next;
          _frame = frame;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      _measure();
      final media = MediaQuery.of(context);
      final data = _snapshot;
      final local = _local;
      final view = _view!;
      final current =
          data != null &&
          data.viewState == ViewState.ready &&
          data.view.value?.size == view.physicalSize / view.devicePixelRatio &&
          data.view.value?.pixelRatio == view.devicePixelRatio &&
          local?.state == LocalState.ready &&
          local?.size == box.biggest &&
          local?.sessionId == data.sessionId &&
          local?.revision == data.revision;
      final areas = current
          ? local!.areas.where((a) => a.isActive != false).toList()
          : <ViewArea>[];
      final nativeFeatures = areas.map(_asFeature).nonNulls.toList();
      final features = <ui.DisplayFeature>[
        ...media.displayFeatures.where(
          (old) => !nativeFeatures.any(
            (fresh) => old.bounds == fresh.bounds && old.type == fresh.type,
          ),
        ),
        ...nativeFeatures,
      ];
      final nativePadding = current ? data.ios.value?.safeArea.value : null;
      final frame = _frame;
      EdgeInsets localPadding(EdgeInsets edges) => frame == null
          ? EdgeInsets.zero
          : EdgeInsets.fromLTRB(
              math.max(0, edges.left - frame.left),
              math.max(0, edges.top - frame.top),
              math.max(
                0,
                edges.right -
                    (view.physicalSize.width / view.devicePixelRatio -
                        frame.right),
              ),
              math.max(
                0,
                edges.bottom -
                    (view.physicalSize.height / view.devicePixelRatio -
                        frame.bottom),
              ),
            );
      EdgeInsets merge(EdgeInsets a, EdgeInsets b) => EdgeInsets.fromLTRB(
        math.max(a.left, b.left),
        math.max(a.top, b.top),
        math.max(a.right, b.right),
        math.max(a.bottom, b.bottom),
      );
      final padding = nativePadding == null
          ? EdgeInsets.zero
          : localPadding(nativePadding);
      final safeTop = math.max(media.padding.top, padding.top);
      final topRegionsReady = current && data.ios.isReady && data.areas.isReady;
      final cornerStatus = LearnScrollLayout.resolve(
        headerFrame: Rect.fromLTWH(0, 0, box.maxWidth, safeTop),
        safeTop: safeTop,
        windowSafeTop: safeTop,
        topRegionsReady: topRegionsReady,
        areas: areas,
        minimumWidth: 1,
      ).usesTopRegions;
      return SizedBox(
        key: _box,
        width: box.maxWidth,
        height: box.maxHeight,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: context.isDark
                ? Brightness.light
                : Brightness.dark,
            statusBarBrightness: context.isDark
                ? Brightness.dark
                : Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: context.isDark
                ? Brightness.light
                : Brightness.dark,
            systemStatusBarContrastEnforced: false,
            systemNavigationBarContrastEnforced: false,
          ),
          // Paint underneath the content clip as well. Reserved-region margins
          // are not physical holes: transparent pixels expose a black OS surface.
          child: ColoredBox(
            key: const ValueKey('learn-window-background'),
            color: context.color('background'),
            child: _WindowScope(
              data: LearnWindowData(
                size: box.biggest,
                origin: _frame?.topLeft ?? Offset.zero,
                areas: areas,
                nativeReady: current,
                topRegionsReady: topRegionsReady,
                navigationSide: current ? data.ios.value?.barSide.value : null,
              ),
              child: MediaQuery(
                data: media.copyWith(
                  displayFeatures: features,
                  viewPadding: merge(media.viewPadding, padding),
                  padding: merge(
                    media.padding,
                    EdgeInsets.fromLTRB(
                      padding.left,
                      padding.top,
                      padding.right,
                      media.viewInsets.bottom > 0 ? 0 : padding.bottom,
                    ),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    widget.child,
                    // Scrolling backgrounds may reach the edge. Keep system
                    // icons legible without reserving a second layout row.
                    if (safeTop > 0 && !cornerStatus)
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        height: safeTop + 12,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            key: const ValueKey('learn-status-shade'),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  context.color('background'),
                                  context
                                      .color('background')
                                      .withValues(alpha: .94),
                                  context
                                      .color('background')
                                      .withValues(alpha: 0),
                                ],
                                stops: [0, safeTop / (safeTop + 12), 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

ui.DisplayFeature? _asFeature(ViewArea area) {
  if (area.type == AreaType.fold || area.type == AreaType.hinge) {
    // An active UIKit division is a layout constraint, without pretending to
    // know its physical hinge state. A flat Android crease need not split.
    final separates =
        area.splitsView == true ||
        area.type == AreaType.hinge ||
        (area.source == DataSource.ios && area.isActive == true);
    return ui.DisplayFeature(
      bounds: area.rect,
      type: area.type == AreaType.hinge
          ? ui.DisplayFeatureType.hinge
          : ui.DisplayFeatureType.fold,
      state: separates
          ? ui.DisplayFeatureState.postureHalfOpened
          : ui.DisplayFeatureState.postureFlat,
    );
  }
  if (area.cover != AreaCover.none && !area.rect.isEmpty) {
    return ui.DisplayFeature(
      bounds: area.rect,
      type: ui.DisplayFeatureType.cutout,
      state: ui.DisplayFeatureState.unknown,
    );
  }
  return null;
}

class _WindowScope extends InheritedWidget {
  const _WindowScope({required this.data, required super.child});
  final LearnWindowData data;
  @override
  bool updateShouldNotify(_WindowScope oldWidget) =>
      oldWidget.data.size != data.size ||
      oldWidget.data.origin != data.origin ||
      oldWidget.data.nativeReady != data.nativeReady ||
      oldWidget.data.topRegionsReady != data.topRegionsReady ||
      oldWidget.data.navigationSide != data.navigationSide ||
      !listEquals(oldWidget.data.areas, data.areas);
}
