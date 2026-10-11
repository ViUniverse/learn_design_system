import 'package:flutter/material.dart';

/// Keeps a visible browse item in place when columns reflow. The page registers
/// meaningful anchors explicitly; no widget-tree scanning or playback coupling.
class LearnScrollAnchor extends StatefulWidget {
  const LearnScrollAnchor({super.key, required this.builder});
  final Widget Function(BuildContext, GlobalKey Function(String)) builder;
  @override
  State<LearnScrollAnchor> createState() => _LearnScrollAnchorState();
}

class _LearnScrollAnchorState extends State<LearnScrollAnchor> {
  final keys = <String, GlobalKey>{};
  double? width, scale;
  String? anchor;
  double fraction = 0;
  int generation = 0;
  GlobalKey keyFor(String id) =>
      keys.putIfAbsent(id, () => GlobalKey(debugLabel: id));
  RenderBox? get viewport {
    final render = Scrollable.maybeOf(context)?.context.findRenderObject();
    return render is RenderBox && render.hasSize ? render : null;
  }

  void capture() {
    final view = viewport;
    if (view == null) return;
    final top = view.localToGlobal(Offset.zero).dy;
    Rect? best;
    anchor = null;
    for (final entry in keys.entries) {
      final render = entry.value.currentContext?.findRenderObject();
      if (render is! RenderBox || !render.hasSize) continue;
      final rect = render.localToGlobal(Offset.zero) & render.size;
      if (rect.top > top || rect.bottom <= top) continue;
      if (best != null &&
          (rect.left > best.left ||
              (rect.left == best.left && rect.height >= best.height))) {
        continue;
      }
      best = rect;
      anchor = entry.key;
      fraction = ((top - rect.top) / rect.height).clamp(0, 1);
    }
  }

  void restore(int expectedGeneration) {
    if (!mounted || generation != expectedGeneration || anchor == null) return;
    final view = viewport;
    final render = keys[anchor]?.currentContext?.findRenderObject();
    final position = Scrollable.maybeOf(context)?.position;
    if (view == null ||
        render is! RenderBox ||
        !render.hasSize ||
        position == null) {
      return;
    }
    final delta =
        render.localToGlobal(Offset.zero).dy -
        view.localToGlobal(Offset.zero).dy;
    position.jumpTo(
      (position.pixels + delta + fraction * render.size.height).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final nextScale = MediaQuery.textScalerOf(context).scale(16);
      if (box.maxWidth != width || nextScale != scale) {
        if (width != null) capture();
        width = box.maxWidth;
        scale = nextScale;
        final expectedGeneration = ++generation;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => restore(expectedGeneration),
        );
      }
      return widget.builder(context, keyFor);
    },
  );
}
