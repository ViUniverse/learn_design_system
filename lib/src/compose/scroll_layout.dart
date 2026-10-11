import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:foldable_info/foldable_info.dart';
import '../foundation/space.dart';

/// Initial scroll content avoids system UI without shrinking its viewport.
/// Detailed iOS reserved regions can leave room for a header beside the status
/// bar. A cutout alone (for example on Android) never proves that room is safe.
class LearnScrollLayout {
  const LearnScrollLayout({
    required this.topPadding,
    this.headerInsets = EdgeInsets.zero,
    this.headerMinHeight = 0,
    this.usesTopRegions = false,
  });
  final double topPadding, headerMinHeight;
  final EdgeInsets headerInsets;
  final bool usesTopRegions;

  static LearnScrollLayout resolve({
    required Rect headerFrame,
    required double safeTop,
    required double windowSafeTop,
    required bool topRegionsReady,
    required List<ViewArea> areas,
    double minimumWidth = 320,
  }) {
    final fallback = LearnScrollLayout(topPadding: safeTop);
    if (!topRegionsReady || safeTop <= 0 || windowSafeTop <= 0) return fallback;
    final top = areas
        .where(
          (area) =>
              area.source == DataSource.ios &&
              area.isActive != false &&
              area.type == AreaType.blocked &&
              area.cover != AreaCover.none &&
              area.rect.top <= .5 &&
              area.rect.bottom <= windowSafeTop + .5 &&
              !area.rect.isEmpty,
        )
        .map((area) => area.rect)
        .toList();
    if (top.isEmpty) return fallback;
    final band = Rect.fromLTRB(
      headerFrame.left,
      headerFrame.top,
      headerFrame.right,
      math.max(headerFrame.top, windowSafeTop),
    );
    final spaces = LearnFreeSpace.inBand(band, top);
    if (spaces.isEmpty) return fallback;
    final space = spaces.reduce(
      (a, b) => a.end - a.start >= b.end - b.start ? a : b,
    );
    if (space.end - space.start < minimumWidth) return fallback;
    final intersects = top.any((rect) => rect.overlaps(band));
    return LearnScrollLayout(
      topPadding: 0,
      usesTopRegions: true,
      headerInsets: EdgeInsets.only(
        left: space.start - headerFrame.left,
        right: headerFrame.right - space.end,
      ),
      headerMinHeight: intersects ? band.height : 0,
    );
  }

  /// Only the first header is narrowed; later content uses the full width.
  Widget header(Widget child) => Padding(
    padding: headerInsets,
    child: ConstrainedBox(
      constraints: BoxConstraints(minHeight: headerMinHeight),
      child: child,
    ),
  );
}
