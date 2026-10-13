import 'package:flutter/material.dart';

/// Application roles from docs/tokens/design-tokens.json (not marketing type).
abstract final class LearnType {
  static const h1 = TextStyle(
    fontSize: 32,
    height: 1.2,
    fontWeight: FontWeight.w600,
    letterSpacing: -.8,
  );
  static const h2 = TextStyle(
    fontSize: 24,
    height: 1.25,
    fontWeight: FontWeight.w600,
    letterSpacing: -.48,
  );
  static const h3 = TextStyle(
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: -.3,
  );
  static const title = TextStyle(
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );
  static const body = TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static const bodyLarge = TextStyle(
    fontSize: 18,
    height: 1.6,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static const small = TextStyle(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static const caption = TextStyle(
    fontSize: 12,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static const label = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
}
