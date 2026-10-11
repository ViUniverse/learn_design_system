import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_design_system/learn_design_system.dart';

void main() {
  test('Both runtime palettes match every approved semantic JSON role', () {
    final tokens = jsonDecode(File('docs/tokens/design-tokens.json').readAsStringSync()) as Map;
    final themes = tokens['color']['themes'] as Map;
    for (final (name, runtime) in [('light', lightTokens), ('dark', darkTokens)]) {
      final expected = themes[name] as Map;
      expect(runtime.keys.toSet(), expected.keys.toSet());
      for (final role in expected.keys) {
        final hex = (expected[role] as String).substring(1);
        final argb = hex.length == 6 ? 'FF$hex' : '${hex.substring(6)}${hex.substring(0, 6)}';
        expect(runtime[role], Color(int.parse(argb, radix: 16)), reason: '$name.$role');
      }
    }
  });
}
