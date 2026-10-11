import 'package:flutter/material.dart';
import '../component/navigation.dart';
import '../foundation/theme.dart';

class LearnDestination {
  const LearnDestination({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

/// Bottom destinations keep labels and touch targets at large text scales.
/// Place in the active pane; SafeArea then applies only that pane's edge insets.
class LearnNavigationBar extends StatelessWidget {
  const LearnNavigationBar({
    super.key,
    required this.destinations,
    required this.selected,
    required this.onSelected,
  }) : assert(destinations.length > 0),
       assert(selected >= 0 && selected < destinations.length);
  final List<LearnDestination> destinations;
  final int selected;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Container(
      decoration: BoxDecoration(
        color: context.color('surface'),
        border: Border(top: BorderSide(color: context.color('border-subtle'))),
      ),
      padding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, box) {
          final minimum =
              64.0 *
              (MediaQuery.textScalerOf(context).scale(11) / 11).clamp(1.0, 1.5);
          final columns = (box.maxWidth / minimum).floor().clamp(
            1,
            destinations.length,
          );
          return Wrap(
            children: [
              for (var i = 0; i < destinations.length; i++)
                SizedBox(
                  width: box.maxWidth / columns,
                  child: LearnNavItem(
                    label: destinations[i].label,
                    icon: destinations[i].icon,
                    selected: selected == i,
                    compact: true,
                    onTap: () => onSelected(i),
                  ),
                ),
            ],
          );
        },
      ),
    ),
  );
}

class LearnNavigationRail extends StatelessWidget {
  const LearnNavigationRail({
    super.key,
    required this.destinations,
    required this.selected,
    required this.onSelected,
    required this.width,
    this.header,
    this.footer,
    this.showLabels = true,
    this.alignment = Alignment.topCenter,
  });
  final List<LearnDestination> destinations;
  final int selected;
  final ValueChanged<int> onSelected;
  final double width;
  final Widget? header, footer;
  final bool showLabels;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: Column(
      children: [
        ?header,
        Expanded(
          child: Align(
            alignment: alignment,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                for (var i = 0; i < destinations.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: LearnNavItem(
                      label: destinations[i].label,
                      icon: destinations[i].icon,
                      selected: selected == i,
                      compact: width < 180,
                      showLabel: showLabels,
                      onTap: () => onSelected(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
        ?footer,
      ],
    ),
  );
}
