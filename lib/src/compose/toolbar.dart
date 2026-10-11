import 'dart:ui' show DisplayFeature, DisplayFeatureType, DisplayFeatureState;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../foundation/space.dart';
import 'window.dart';

/// A row or several rows of 48 px icon controls, excluding native obstacles.
/// Callers own actions and menus. Supply icon buttons, including menu triggers,
/// as children; no action is dropped when capacity changes.
class LearnToolbar extends StatefulWidget {
  const LearnToolbar({super.key, required this.actions, this.title});
  final List<Widget> actions;
  final Widget? title;
  @override
  State<LearnToolbar> createState() => _LearnToolbarState();
}

class _LearnToolbarState extends State<LearnToolbar> {
  final _box = GlobalKey();
  List<Rect> _obstacles = const [];
  bool _pending = false;
  void _measure(LearnWindowData? window, List<DisplayFeature> features) {
    if (_pending) return;
    _pending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pending = false;
      if (!mounted) return;
      final box = _box.currentContext?.findRenderObject();
      if (box is! RenderBox || !box.hasSize) return;
      final origin =
          box.localToGlobal(Offset.zero) - (window?.origin ?? Offset.zero);
      final rects = <Rect>[
        ...features
            .where(
              (f) =>
                  f.type == DisplayFeatureType.hinge ||
                  f.type == DisplayFeatureType.cutout ||
                  f.state == DisplayFeatureState.postureHalfOpened,
            )
            .map((f) => f.bounds.shift(-origin)),
      ];
      if (!listEquals(_obstacles, rects)) setState(() => _obstacles = rects);
    });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final window = LearnWindowData.maybeOf(context);
      _measure(window, MediaQuery.of(context).displayFeatures);
      final layout = LearnToolbarLayout.resolve(
        width: box.maxWidth,
        count: widget.actions.length,
        direction: Directionality.of(context),
        obstacles: _obstacles,
      );
      // A title can occupy the unused first-row interval without squeezing icons.
      final oneRow =
          layout.height == 48 &&
          layout.controls.isNotEmpty &&
          LearnFreeSpace.inBand(
                Rect.fromLTWH(0, 0, box.maxWidth, 48),
                _obstacles,
              ).singleOrNull ==
              (start: 0.0, end: box.maxWidth);
      final titleWidth = box.maxWidth - (widget.actions.length * 52) - 8;
      final showTitle =
          widget.title != null &&
          oneRow &&
          titleWidth >= MediaQuery.textScalerOf(context).scale(120);
      return SizedBox(
        key: _box,
        width: box.maxWidth,
        height: layout.height,
        child: Stack(
          children: [
            if (showTitle)
              PositionedDirectional(
                start: 56,
                top: 0,
                width: titleWidth,
                height: 48,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: widget.title,
                ),
              ),
            for (var i = 0; i < widget.actions.length; i++)
              Positioned.fromRect(
                rect: showTitle && i > 0
                    ? layout.controls[i].shift(
                        Offset(
                          Directionality.of(context) == TextDirection.ltr
                              ? titleWidth + 8
                              : -titleWidth - 8,
                          0,
                        ),
                      )
                    : layout.controls[i],
                child: widget.actions[i],
              ),
          ],
        ),
      );
    },
  );
}
