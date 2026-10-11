import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:foldable_info/foldable_info.dart';
import '../foundation/space.dart';

/// Navigation occupies either content width or the native side control strip.
/// A native strip is already reserved by safe area: never subtract it twice.
class LearnNavigationLayout {
  const LearnNavigationLayout({this.railWidth = 0, this.edgeFrame});
  final double railWidth;
  final Rect? edgeFrame;

  static LearnNavigationLayout resolve({
    required Size size,
    required TextScaler textScaler,
    required EdgeInsets safeArea,
    required List<ui.DisplayFeature> features,
    BarSide? nativeSide,
    TextDirection direction = TextDirection.ltr,
    EdgeInsets viewInsets = EdgeInsets.zero,
  }) {
    if (nativeSide != null) {
      final right =
          (nativeSide == BarSide.end) == (direction == TextDirection.ltr);
      final width = math.min(88.0, right ? safeArea.right : safeArea.left);
      if (width >= 64) {
        final strip = Rect.fromLTRB(
          right ? size.width - width : 0,
          safeArea.top,
          right ? size.width : width,
          size.height - math.max(safeArea.bottom, viewInsets.bottom),
        );
        // Transpose the band to subtract camera/status/hinge rectangles along Y.
        Rect transpose(Rect rect) =>
            Rect.fromLTRB(rect.top, rect.left, rect.bottom, rect.right);
        final bands = LearnFreeSpace.inBand(
          transpose(strip),
          features
              .where(
                (f) =>
                    !f.bounds.isEmpty &&
                    (f.type == ui.DisplayFeatureType.cutout ||
                        f.type == ui.DisplayFeatureType.hinge ||
                        f.state == ui.DisplayFeatureState.postureHalfOpened),
              )
              .map((f) => transpose(f.bounds)),
        );
        final usable = bands
            .where((band) => band.end - band.start >= 64)
            .lastOrNull;
        if (usable != null) {
          return LearnNavigationLayout(
            edgeFrame: Rect.fromLTRB(
              strip.left,
              usable.start,
              strip.right,
              usable.end,
            ),
          );
        }
      }
      // A native hint is not permission to consume a second side column when
      // its control strip cannot hold a target (for example, with a keyboard).
      return const LearnNavigationLayout();
    }
    final tabletop = features.any(
      (f) =>
          f.state == ui.DisplayFeatureState.postureHalfOpened &&
          f.bounds.left <= .5 &&
          f.bounds.right >= size.width - .5,
    );
    final scale = textScaler.scale(16) / 16;
    return LearnNavigationLayout(
      railWidth:
          !tabletop &&
              size.width - safeArea.horizontal >= 600 &&
              size.height - safeArea.vertical >= 480 &&
              scale <= 1.5
          ? 88
          : 0,
    );
  }
}
