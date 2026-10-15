import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../foundation/theme.dart';
import 'pane_layout.dart';
import 'window.dart';
import 'navigation.dart';

/// Declare a list and its detail routes once, for every window size.
/// The same detail Navigator stays mounted while its pane moves.
class LearnRoute extends ShellRoute {
  factory LearnRoute({
    required String path,
    String? name,
    required GoRouterWidgetBuilder builder,
    required List<RouteBase> details,
    GoRouterRedirect? redirect,
    ExitCallback? onExit,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterWidgetBuilder? barBuilder,
  }) {
    final root = GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      onExit: onExit,
      pageBuilder: (_, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const SizedBox.shrink(),
      ),
      routes: details,
    );
    return LearnRoute._(
      navigatorKey: navigatorKey,
      routes: [root],
      masterBuilder: builder,
      barBuilder: barBuilder,
    );
  }

  LearnRoute._({
    super.navigatorKey,
    required super.routes,
    required GoRouterWidgetBuilder masterBuilder,
    GoRouterWidgetBuilder? barBuilder,
  }) : _masterBuilder = masterBuilder,
       _barBuilder = barBuilder,
       super(builder: (_, _, navigator) => navigator);

  final GoRouterWidgetBuilder _masterBuilder;
  final GoRouterWidgetBuilder? _barBuilder;

  @override
  Widget buildWidget(
    BuildContext context,
    GoRouterState state,
    ShellRouteContext shellRouteContext,
  ) => LearnRouteView(
    // The global top route may be a login/dialog on another Navigator.
    // Only routes in this shell's own stack can open the detail pane.
    hasDetail: shellRouteContext.match.matches.last.route != routes.single,
    master: _masterBuilder(context, state),
    detail: super.buildWidget(context, state, shellRouteContext)!,
    bar: _barBuilder?.call(context, state),
  );
}

/// Current pane geometry, for controls that need window coordinates.
class LearnRouteData extends InheritedWidget {
  const LearnRouteData({
    super.key,
    required this.frame,
    required this.layout,
    required this.hasDetail,
    required this.size,
    required super.child,
  });
  final Rect frame;
  final LearnPaneLayout layout;
  final bool hasDetail;
  final Size size;

  static LearnRouteData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LearnRouteData>()!;

  @override
  bool updateShouldNotify(LearnRouteData old) =>
      frame != old.frame ||
      layout != old.layout ||
      hasDetail != old.hasDetail ||
      size != old.size;
}

/// Move two mounted children. Routing and window size never create a copy.
class LearnRouteView extends StatefulWidget {
  const LearnRouteView({
    super.key,
    required this.hasDetail,
    required this.master,
    required this.detail,
    this.bar,
  });
  final bool hasDetail;
  final Widget master, detail;
  final Widget? bar;

  @override
  State<LearnRouteView> createState() => _LearnRouteViewState();
}

class _LearnRouteViewState extends State<LearnRouteView> {
  LearnPaneLayout? _layout;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final media = MediaQuery.of(context);
      final window = LearnWindowData.maybeOf(context);
      // During a resize, wait for the matching native map. Do not move first
      // to an invented flat split and then back to the actual hinge split.
      if (window?.isChanging != true || _layout == null) {
        _layout = LearnPaneLayout.resolve(
          size: box.biggest,
          textScaler: media.textScaler,
          features: media.displayFeatures,
          wasSplit: _layout?.split ?? false,
          navigationSide: window?.navigationSide,
          direction: Directionality.of(context),
          safeArea: media.padding,
          viewInsets: media.viewInsets,
          showNavigation: widget.bar != null,
        );
      }
      final layout = _layout!;
      // Keep the old split while native catches up, but fit its frames into
      // the resized canvas. A former right pane may now be outside the view.
      Rect fit(Rect frame) {
        final width = frame.width.clamp(0.0, box.maxWidth);
        final height = frame.height.clamp(0.0, box.maxHeight);
        return Rect.fromLTWH(
          frame.left.clamp(0.0, box.maxWidth - width),
          frame.top.clamp(0.0, box.maxHeight - height),
          width,
          height,
        );
      }

      final browse = fit(
        widget.hasDetail && layout.split ? layout.browse : layout.fullBrowse,
      );
      final verticalBar =
          layout.edgeNavigationFrame != null || layout.navigationWidth > 0;
      final hasBar = widget.bar != null;
      final rail = hasBar ? layout.navigationWidth : 0.0;
      final master = Rect.fromLTRB(
        browse.left + (layout.navigationOnRight ? 0 : rail),
        browse.top,
        browse.right - (layout.navigationOnRight ? rail : 0),
        browse.bottom,
      );
      final detail = fit(layout.detail);
      final duration = media.disableAnimations
          ? Duration.zero
          : const Duration(milliseconds: 260);
      Widget pane(Rect frame, Widget child, {bool enabled = true}) => ClipRect(
        child: ExcludeFocus(
          excluding: !enabled,
          child: ExcludeSemantics(
            excluding: !enabled,
            child: IgnorePointer(
              ignoring: !enabled,
              child: LearnRouteData(
                frame: frame,
                layout: layout,
                hasDetail: widget.hasDetail,
                size: box.biggest,
                child: MediaQuery(
                  data: mediaQueryForPane(media, frame, box.biggest),
                  // Reflow once at the new pane size. Only its outside clip moves.
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    minWidth: frame.width,
                    maxWidth: frame.width,
                    minHeight: frame.height,
                    maxHeight: frame.height,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      return ColoredBox(
        color: context.color('background'),
        child: ClipPath(
          clipper: LearnAreaClipper(media.displayFeatures),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedPositioned.fromRect(
                key: const ValueKey('learn-master-pane'),
                rect: master,
                duration: duration,
                curve: Curves.easeOutCubic,
                child: pane(
                  master,
                  Column(
                    children: [
                      Expanded(child: widget.master),
                      if (hasBar &&
                          !verticalBar &&
                          (!widget.hasDetail || layout.split))
                        widget.bar!,
                    ],
                  ),
                  enabled: !widget.hasDetail || layout.split,
                ),
              ),
              AnimatedPositioned.fromRect(
                key: const ValueKey('learn-detail-pane'),
                rect: detail,
                duration: duration,
                curve: Curves.easeOutCubic,
                child: pane(detail, widget.detail, enabled: widget.hasDetail),
              ),
              if (hasBar &&
                  verticalBar &&
                  (!widget.hasDetail ||
                      layout.split ||
                      layout.edgeNavigationFrame != null))
                Positioned(
                  left:
                      layout.edgeNavigationFrame?.left ??
                      (layout.navigationOnRight && verticalBar
                          ? browse.right - rail
                          : browse.left),
                  width:
                      layout.edgeNavigationFrame?.width ??
                      (verticalBar ? rail : browse.width),
                  top: verticalBar
                      ? layout.edgeNavigationFrame?.top ?? browse.top
                      : null,
                  bottom:
                      box.maxHeight -
                      (layout.edgeNavigationFrame?.bottom ?? browse.bottom),
                  child: LearnRouteData(
                    frame: browse,
                    layout: layout,
                    hasDetail: widget.hasDetail,
                    size: box.biggest,
                    child: MediaQuery(
                      data: mediaQueryForPane(media, browse, box.biggest),
                      child: SizedBox(
                        height:
                            layout.edgeNavigationFrame?.height ?? browse.height,
                        child: widget.bar,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

/// The route places this bar; app code only supplies destinations and taps.
class LearnRouteBar extends StatelessWidget {
  const LearnRouteBar({
    super.key,
    required this.destinations,
    required this.selected,
    required this.onSelected,
  });
  final List<LearnDestination> destinations;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final layout = LearnRouteData.of(context).layout;
    final edge = layout.edgeNavigationFrame;
    return edge != null || layout.navigationWidth > 0
        ? ColoredBox(
            color: context.color('background-subtle'),
            child: SafeArea(
              top: edge == null,
              bottom: edge == null,
              left: false,
              right: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: LearnNavigationRail(
                  key: edge == null
                      ? null
                      : const ValueKey('native-edge-navigation'),
                  width: edge?.width ?? layout.navigationWidth,
                  showLabels: edge == null,
                  alignment: edge == null
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  destinations: destinations,
                  selected: selected,
                  onSelected: onSelected,
                ),
              ),
            ),
          )
        : LearnNavigationBar(
            destinations: destinations,
            selected: selected,
            onSelected: onSelected,
          );
  }
}
