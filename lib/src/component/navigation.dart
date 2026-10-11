import 'package:flutter/material.dart';
import '../foundation/theme.dart';

class LearnNavItem extends StatelessWidget {
  const LearnNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.compact,
    required this.onTap,
    this.showLabel = true,
  });
  final String label;
  final IconData icon;
  final bool selected, compact;
  final bool showLabel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    label: label,
    excludeSemantics: true,
    child: Tooltip(
      message: label,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          minimumSize: const Size(44, 48),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          foregroundColor: context.color(
            selected ? 'selected-foreground' : 'text-secondary',
          ),
          backgroundColor: selected
              ? context.color('selected-background')
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: !showLabel
            ? Icon(icon, size: 23)
            : compact
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 23),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11, height: 1.2),
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(icon, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(label, style: const TextStyle(fontSize: 15)),
                  ),
                ],
              ),
      ),
    ),
  );
}
