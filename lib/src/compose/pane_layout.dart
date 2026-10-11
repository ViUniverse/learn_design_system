import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:foldable_info/foldable_info.dart';
import 'navigation_layout.dart';

/// Express window edge obstructions in a pane's own coordinate space.
/// A trailing camera inset belongs only to panes touching that window edge.
MediaQueryData mediaQueryForPane(MediaQueryData window, Rect pane, Size size) {
  EdgeInsets local(EdgeInsets edges) => EdgeInsets.fromLTRB(
    (edges.left - pane.left).clamp(0.0, pane.width),
    (edges.top - pane.top).clamp(0.0, pane.height),
    (edges.right - (size.width - pane.right)).clamp(0.0, pane.width),
    (edges.bottom - (size.height - pane.bottom)).clamp(0.0, pane.height),
  );
  return window.copyWith(
    size: pane.size,
    padding: local(window.padding),
    viewPadding: local(window.viewPadding),
    viewInsets: local(window.viewInsets),
  );
}

/// Available-space policy, independent of playback and device model names.
@immutable
class LearnPaneLayout {
  const LearnPaneLayout({
    required this.browse,
    required this.detail,
    required this.fullBrowse,
    required this.split,
    required this.navigationWidth,
    this.axis = Axis.horizontal,
    this.separated = false,
    this.navigationOnRight = false,
    this.edgeNavigationFrame,
  });
  final Rect browse, detail, fullBrowse;
  final bool split, separated;
  final double navigationWidth;
  final Axis axis;
  final bool navigationOnRight;
  final Rect? edgeNavigationFrame;

  static LearnPaneLayout resolve({
    required Size size,
    required TextScaler textScaler,
    List<ui.DisplayFeature> features = const [],
    bool wasSplit = false,
    BarSide? navigationSide,
    TextDirection direction = TextDirection.ltr,
    EdgeInsets safeArea = EdgeInsets.zero,
    EdgeInsets viewInsets = EdgeInsets.zero,
  }) {
    final onRight =
        (navigationSide == BarSide.end) == (direction == TextDirection.ltr);
    final navigation = LearnNavigationLayout.resolve(
      size: size,
      textScaler: textScaler,
      safeArea: safeArea,
      features: features,
      nativeSide: navigationSide,
      direction: direction,
      viewInsets: viewInsets,
    );
    // Navigation edge hints position controls, never reorder master/detail.
    LearnPaneLayout placed(LearnPaneLayout layout) => LearnPaneLayout(
      browse: layout.browse,
      detail: layout.detail,
      fullBrowse: layout.fullBrowse,
      split: layout.split,
      navigationWidth: layout.navigationWidth,
      axis: layout.axis,
      separated: layout.separated,
      navigationOnRight: onRight,
      edgeNavigationFrame: navigation.edgeFrame,
    );
    final scale = math.max(1.0, textScaler.scale(16) / 16);
    final nav = navigation.railWidth;
    final masterMin = 320 * scale;
    final detailMin = 360 * scale;
    final full = Offset.zero & size;
    double usableWidth(Rect pane) =>
        pane.width -
        math.max(0, safeArea.left - pane.left) -
        math.max(0, safeArea.right - (size.width - pane.right));
    for (final feature in features) {
      final bounds = feature.bounds;
      final obstructs =
          feature.type == ui.DisplayFeatureType.hinge ||
          feature.state == ui.DisplayFeatureState.postureHalfOpened;
      if (!obstructs) continue;
      if (bounds.top <= .5 &&
          bounds.bottom >= size.height - .5 &&
          bounds.left > 0 &&
          bounds.right < size.width) {
        final left = Rect.fromLTRB(0, 0, bounds.left, size.height);
        final right = Rect.fromLTRB(bounds.right, 0, size.width, size.height);
        final browse = left;
        final detail = right;
        // A rail must fit its own pane, not just the full unfolded display.
        // Fall back to bottom destinations before sacrificing readable content.
        final paneNav = usableWidth(browse) >= nav + masterMin ? nav : 0.0;
        return placed(
          LearnPaneLayout(
            browse: browse,
            // A zero-width crease separates panes while listening, but does
            // not occlude Home when there is no second pane to display.
            fullBrowse: bounds.isEmpty ? full : browse,
            detail: detail,
            split:
                usableWidth(browse) >= paneNav + masterMin &&
                usableWidth(detail) >= detailMin,
            navigationWidth: paneNav,
            separated: true,
          ),
        );
      }
      if (bounds.left <= .5 &&
          bounds.right >= size.width - .5 &&
          bounds.top > 0 &&
          bounds.bottom < size.height) {
        final top = Rect.fromLTRB(0, 0, size.width, bounds.top);
        final bottom = Rect.fromLTRB(0, bounds.bottom, size.width, size.height);
        return placed(
          LearnPaneLayout(
            browse: top,
            fullBrowse: bounds.isEmpty ? full : top,
            detail: bottom,
            split:
                top.height >= 320 &&
                bottom.height >= 320 &&
                usableWidth(top) >= nav + masterMin &&
                usableWidth(bottom) >= detailMin,
            navigationWidth: nav,
            axis: Axis.vertical,
            separated: true,
          ),
        );
      }
    }
    final needed = nav + masterMin + detailMin + 16 + safeArea.horizontal;
    final split =
        size.width >= needed + (wasSplit ? 0 : 16) && size.height >= 360;
    if (!split) {
      return placed(
        LearnPaneLayout(
          browse: full,
          fullBrowse: full,
          detail: full,
          split: false,
          navigationWidth: nav,
        ),
      );
    }
    final master = ((size.width - safeArea.horizontal - nav) * .36).clamp(
      masterMin,
      math.max(masterMin, 440 * scale),
    );
    final divider = nav + master + safeArea.left;
    return placed(
      LearnPaneLayout(
        browse: Rect.fromLTRB(0, 0, divider, size.height),
        detail: Rect.fromLTRB(divider + 16, 0, size.width, size.height),
        fullBrowse: full,
        split: true,
        navigationWidth: nav,
      ),
    );
  }
}

/// The occlusion is excluded from both painting and pointer hit testing,
/// including while the two pane rectangles are moving between layouts.
class LearnAreaClipper extends CustomClipper<Path> {
  const LearnAreaClipper(this.features);
  final List<ui.DisplayFeature> features;
  @override
  Path getClip(Size size) {
    var path = Path()..addRect(Offset.zero & size);
    for (final feature in features) {
      if (feature.bounds.isEmpty ||
          (feature.type != ui.DisplayFeatureType.hinge &&
              feature.type != ui.DisplayFeatureType.cutout &&
              feature.state != ui.DisplayFeatureState.postureHalfOpened)) {
        continue;
      }
      path = Path.combine(
        PathOperation.difference,
        path,
        Path()..addRect(feature.bounds),
      );
    }
    return path;
  }

  @override
  bool shouldReclip(LearnAreaClipper oldClipper) =>
      !listEquals(features, oldClipper.features);
}
