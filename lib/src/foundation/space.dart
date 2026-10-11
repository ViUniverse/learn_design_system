import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A horizontal interval left after subtracting active obstacles from a band.
typedef LearnInterval = ({double start, double end});

abstract final class LearnFreeSpace {
  static List<LearnInterval> inBand(Rect band, Iterable<Rect> obstacles) {
    var result = <LearnInterval>[(start: band.left, end: band.right)];
    final blocks =
        obstacles
            .where(
              (rect) =>
                  rect.bottom > band.top &&
                  rect.top < band.bottom &&
                  rect.right >= band.left &&
                  rect.left <= band.right,
            )
            .toList()
          ..sort((a, b) => a.left.compareTo(b.left));
    for (final block in blocks) {
      result = [
        for (final segment in result)
          if (block.right <= segment.start || block.left >= segment.end)
            segment
          else ...[
            if (block.left > segment.start)
              (start: segment.start, end: math.min(block.left, segment.end)),
            if (block.right < segment.end)
              (start: math.max(block.right, segment.start), end: segment.end),
          ],
      ];
    }
    return result;
  }
}

/// Every control remains visible; narrow bars add rows rather than hiding
/// actions behind an unreachable overflow button. No fixed screen breakpoint.
class LearnToolbarLayout {
  const LearnToolbarLayout({required this.controls, required this.height});
  final List<Rect> controls;
  final double height;

  static LearnToolbarLayout resolve({
    required double width,
    required int count,
    List<Rect> obstacles = const [],
    double target = 48,
    double gap = 4,
    TextDirection direction = TextDirection.ltr,
  }) {
    if (count == 0) return const LearnToolbarLayout(controls: [], height: 0);
    if (width < target) {
      throw ArgumentError.value(
        width,
        'width',
        'A toolbar needs one full touch target.',
      );
    }
    final controls = <Rect>[];
    var y = 0.0;
    while (controls.length < count) {
      final segments = LearnFreeSpace.inBand(
        Rect.fromLTWH(0, y, width, target),
        obstacles,
      );
      final ordered = direction == TextDirection.ltr
          ? segments
          : segments.reversed;
      final before = controls.length;
      for (final segment in ordered) {
        final capacity = ((segment.end - segment.start + gap) / (target + gap))
            .floor();
        for (var i = 0; i < capacity && controls.length < count; i++) {
          final x = direction == TextDirection.ltr
              ? segment.start + i * (target + gap)
              : segment.end - target - i * (target + gap);
          controls.add(Rect.fromLTWH(x, y, target, target));
        }
      }
      if (controls.length == before) {
        // Skip a blocked camera/hinge band. Each step passes an obstacle edge,
        // so this terminates even if an entire first row is blocked.
        final bottoms = obstacles
            .where((r) => r.bottom > y && r.top < y + target)
            .map((r) => r.bottom);
        y = bottoms.isEmpty ? y + target + gap : bottoms.reduce(math.min) + gap;
      } else if (controls.length < count) {
        y += target + gap;
      }
    }
    return LearnToolbarLayout(controls: controls, height: y + target);
  }
}
