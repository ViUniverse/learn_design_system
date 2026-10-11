import 'package:flutter/material.dart';
import 'colors.dart';

extension LearnColors on BuildContext {
  Color color(String role) => (Theme.of(this).brightness == Brightness.dark
      ? darkTokens
      : lightTokens)[role]!;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

ThemeData learnTheme(Brightness brightness) {
  final t = brightness == Brightness.dark ? darkTokens : lightTokens;
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: 'SN Pro',
    package: 'learn_design_system',
    colorScheme: ColorScheme.fromSeed(
      seedColor: t['link']!,
      brightness: brightness,
    ),
  );
  return base.copyWith(
    scaffoldBackgroundColor: t['background'],
    colorScheme: base.colorScheme.copyWith(
      primary: t['primary'],
      onPrimary: t['on-primary'],
      secondary: t['link'],
      surface: t['surface'],
      onSurface: t['text-primary'],
      outline: t['border-control'],
      outlineVariant: t['border-subtle'],
      onSurfaceVariant: t['text-secondary'],
      error: t['error-foreground'],
    ),
    dividerColor: t['border-subtle'],
    splashFactory: NoSplash.splashFactory,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: t['input-background'],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: t['border-control']!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: t['focus-ring']!, width: 2),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: t['surface'],
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        animationDuration: const Duration(milliseconds: 120),
        splashFactory: NoSplash.splashFactory,
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        overlayColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.focused)
              ? t['focus-ring']!.withValues(alpha: .12)
              : states.contains(WidgetState.hovered)
              ? t['text-primary']!.withValues(alpha: .04)
              : Colors.transparent,
        ),
      ),
    ),
    sliderTheme: base.sliderTheme.copyWith(
      activeTrackColor: t['progress-active'],
      inactiveTrackColor: t['progress-track'],
      thumbColor: t['progress-active'],
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: t['surface'],
      indicatorColor: t['selected-background'],
      height: 80,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          fontFamily: 'SN Pro',
          package: 'learn_design_system',
          color: t['text-primary'],
          fontSize: 12,
        ),
      ),
    ),
  );
}
