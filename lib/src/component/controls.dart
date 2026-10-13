import 'package:flutter/material.dart';
import '../foundation/theme.dart';

enum LearnButtonStyle { primary, outline, quiet }

/// App controls use Vi Learn roles; Flutter owns focus and keyboard behavior.
class LearnButton extends StatelessWidget {
  const LearnButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style = LearnButtonStyle.primary,
    this.leading,
    this.trailing,
    this.selected = false,
    this.iconOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.semanticLabel,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final LearnButtonStyle style;
  final Widget? leading, trailing;
  final bool selected, iconOnly, autofocus;
  final FocusNode? focusNode;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final primary = style == LearnButtonStyle.primary;
    final foreground = context.color(
      onPressed == null
          ? 'disabled-foreground'
          : selected
          ? 'selected-foreground'
          : primary
          ? 'on-primary'
          : 'text-primary',
    );
    return Semantics(
      label: semanticLabel,
      selected: selected,
      child: TextButton(
        onPressed: onPressed,
        autofocus: autofocus,
        focusNode: focusNode,
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: iconOnly ? 12 : 16, vertical: 12),
          ),
          alignment: Alignment.center,
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => context.color(
              states.contains(WidgetState.disabled)
                  ? 'disabled-foreground'
                  : selected
                  ? 'selected-foreground'
                  : primary
                  ? 'on-primary'
                  : 'text-primary',
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return context.color('disabled-background');
            }
            if (selected) {
              return context.color(
                states.contains(WidgetState.hovered)
                    ? 'selected-hover'
                    : 'selected-background',
              );
            }
            if (primary) {
              return context.color(
                states.contains(WidgetState.pressed)
                    ? 'primary-pressed'
                    : states.contains(WidgetState.hovered)
                    ? 'primary-hover'
                    : 'primary',
              );
            }
            return context.color(
              states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.pressed)
                  ? 'surface-hover'
                  : 'surface',
            );
          }),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              width: states.contains(WidgetState.focused) ? 2 : 1,
              color: states.contains(WidgetState.focused)
                  ? context.color('focus-ring')
                  : style == LearnButtonStyle.outline
                  ? context.color('border-control')
                  : Colors.transparent,
            ),
          ),
          shape: const WidgetStatePropertyAll(StadiumBorder()),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          animationDuration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 120),
        ),
        child: IconTheme.merge(
          data: IconThemeData(color: foreground, size: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 8)],
              Flexible(child: child),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ),
      ),
    );
  }
}

class LearnIconButton extends StatelessWidget {
  const LearnIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: label,
    excludeFromSemantics: true,
    child: LearnButton(
      onPressed: onPressed,
      style: LearnButtonStyle.quiet,
      iconOnly: true,
      semanticLabel: label,
      child: Icon(icon),
    ),
  );
}

class LearnInput extends StatelessWidget {
  const LearnInput({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.pill = false,
    this.autofocus = false,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
  });
  final TextEditingController? controller;
  final String? initialValue, label, placeholder, helperText, errorText;
  final ValueChanged<String>? onChanged, onSubmitted;
  final bool pill, autofocus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool enabled, readOnly;
  final Widget? prefixIcon, suffixIcon;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    initialValue: initialValue,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    autofocus: autofocus,
    textInputAction: textInputAction,
    focusNode: focusNode,
    enabled: enabled,
    readOnly: readOnly,
    maxLines: maxLines,
    maxLength: maxLength,
    style: Theme.of(context).textTheme.bodyMedium,
    decoration: InputDecoration(
      labelText: label,
      hintText: placeholder,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(pill ? 28 : 12),
      ),
    ),
  );
}

class LearnOption<T> {
  const LearnOption({required this.value, required this.label});
  final T value;
  final String label;
}

class LearnSelect<T> extends StatelessWidget {
  const LearnSelect({
    super.key,
    required this.value,
    required this.onChanged,
    required this.options,
    this.label,
    this.semanticLabel,
    this.block = true,
    this.enabled = true,
  });
  final T? value;
  final ValueChanged<T?> onChanged;
  final List<LearnOption<T>> options;
  final String? label, semanticLabel;
  final bool block, enabled;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    child: DropdownButtonFormField<T>(
      key: ValueKey(value),
      initialValue: value,
      onChanged: enabled ? onChanged : null,
      isExpanded: block,
      dropdownColor: context.color('surface'),
      borderRadius: BorderRadius.circular(12),
      decoration: InputDecoration(labelText: label),
      items: [
        for (final option in options)
          DropdownMenuItem(value: option.value, child: Text(option.label)),
      ],
    ),
  );
}

class LearnMenu extends StatefulWidget {
  const LearnMenu({
    super.key,
    required this.label,
    required this.triggerBuilder,
    required this.children,
    this.minWidth = 220,
  });
  final String label;
  final Widget Function(BuildContext, MenuController, FocusNode) triggerBuilder;
  final List<Widget> children;
  final double minWidth;

  @override
  State<LearnMenu> createState() => _LearnMenuState();
}

class _LearnMenuState extends State<LearnMenu> {
  final _focus = FocusNode();
  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MenuAnchor(
    childFocusNode: _focus,
    consumeOutsideTap: true,
    onClose: _focus.requestFocus,
    style: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(context.color('surface')),
      minimumSize: WidgetStatePropertyAll(Size(widget.minWidth, 0)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    menuChildren: widget.children,
    builder: (context, controller, child) => Semantics(
      label: widget.label,
      child: widget.triggerBuilder(context, controller, _focus),
    ),
  );
}

class LearnMenuItem extends StatelessWidget {
  const LearnMenuItem({super.key, required this.onSelect, required this.child});
  final VoidCallback onSelect;
  final Widget child;
  @override
  Widget build(BuildContext context) => MenuItemButton(
    onPressed: onSelect,
    style: const ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(44, 44))),
    child: child,
  );
}

Future<T?> showLearnDialog<T>({
  required BuildContext context,
  required String title,
  required Widget content,
  required List<Widget> actions,
}) => showDialog<T>(
  context: context,
  builder: (context) =>
      AlertDialog(title: Text(title), content: content, actions: actions),
);
