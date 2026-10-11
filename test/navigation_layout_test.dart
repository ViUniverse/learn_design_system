import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foldable_info/foldable_info.dart';
import 'package:learn_design_system/learn_design_system.dart';

void main() {
  const camera = ui.DisplayFeature(
    bounds: Rect.fromLTRB(867, 0, 951, 120),
    type: ui.DisplayFeatureType.cutout,
    state: ui.DisplayFeatureState.unknown,
  );
  test(
    'Duo landscape puts controls below status in the existing right strip',
    () {
      final nav = LearnNavigationLayout.resolve(
        size: const Size(951, 669),
        textScaler: TextScaler.noScaling,
        safeArea: const EdgeInsets.fromLTRB(0, 0, 84, 21),
        features: const [camera],
        nativeSide: BarSide.end,
      );
      expect(nav.railWidth, 0);
      expect(nav.edgeFrame, const Rect.fromLTRB(867, 120, 951, 648));
      expect(nav.edgeFrame!.overlaps(camera.bounds), false);
    },
  );
  test(
    'Outer portrait keeps native side navigation and subtracts camera/status',
    () {
      final nav = LearnNavigationLayout.resolve(
        size: const Size(466, 678),
        textScaler: TextScaler.linear(2),
        safeArea: const EdgeInsets.fromLTRB(0, 0, 84, 21),
        nativeSide: BarSide.end,
        features: const [
          ui.DisplayFeature(
            bounds: Rect.fromLTRB(382, 0, 466, 170),
            type: ui.DisplayFeatureType.cutout,
            state: ui.DisplayFeatureState.unknown,
          ),
        ],
      );
      expect(nav.edgeFrame, const Rect.fromLTRB(382, 170, 466, 657));
    },
  );
  test('RTL/Split View leading controls use the actual left strip', () {
    final nav = LearnNavigationLayout.resolve(
      size: const Size(466, 678),
      textScaler: TextScaler.noScaling,
      safeArea: const EdgeInsets.fromLTRB(84, 0, 0, 21),
      nativeSide: BarSide.end,
      direction: TextDirection.rtl,
      features: const [
        ui.DisplayFeature(
          bounds: Rect.fromLTRB(0, 0, 84, 170),
          type: ui.DisplayFeatureType.cutout,
          state: ui.DisplayFeatureState.unknown,
        ),
      ],
    );
    expect(nav.edgeFrame, const Rect.fromLTRB(0, 170, 84, 657));
  });
  test('Keyboard and a horizontal division cannot be used as bar space', () {
    final nav = LearnNavigationLayout.resolve(
      size: const Size(951, 669),
      textScaler: TextScaler.noScaling,
      safeArea: const EdgeInsets.only(right: 84),
      nativeSide: BarSide.end,
      viewInsets: const EdgeInsets.only(bottom: 200),
      features: const [
        camera,
        ui.DisplayFeature(
          bounds: Rect.fromLTRB(0, 300, 951, 330),
          type: ui.DisplayFeatureType.fold,
          state: ui.DisplayFeatureState.postureHalfOpened,
        ),
      ],
    );
    expect(nav.edgeFrame, const Rect.fromLTRB(867, 330, 951, 469));
  });
  test('A strip with no full target falls back to bottom navigation', () {
    final nav = LearnNavigationLayout.resolve(
      size: const Size(951, 669),
      textScaler: TextScaler.noScaling,
      safeArea: const EdgeInsets.only(right: 84),
      nativeSide: BarSide.end,
      viewInsets: const EdgeInsets.only(bottom: 520),
      features: const [camera],
    );
    expect(nav.edgeFrame, isNull);
    expect(nav.railWidth, 0);
  });
  test('Android compact height and tabletop use bottom navigation', () {
    LearnNavigationLayout layout(
      Size size, [
      List<ui.DisplayFeature> features = const [],
    ]) => LearnNavigationLayout.resolve(
      size: size,
      textScaler: TextScaler.noScaling,
      safeArea: const EdgeInsets.only(top: 24),
      features: features,
    );
    expect(layout(const Size(851, 883)).railWidth, 88);
    expect(layout(const Size(883, 420)).railWidth, 0);
    expect(
      layout(const Size(851, 883), const [
        ui.DisplayFeature(
          bounds: Rect.fromLTWH(0, 441.5, 851, 0),
          type: ui.DisplayFeatureType.fold,
          state: ui.DisplayFeatureState.postureHalfOpened,
        ),
      ]).railWidth,
      0,
    );
  });

  test('A crease uses the full Home surface and separates the open player', () {
    for (final bounds in [
      const Rect.fromLTWH(425.5, 0, 0, 883),
      const Rect.fromLTWH(0, 441.5, 851, 0),
    ]) {
      final layout = LearnPaneLayout.resolve(
        size: const Size(851, 883),
        textScaler: TextScaler.noScaling,
        features: [
          ui.DisplayFeature(
            bounds: bounds,
            type: ui.DisplayFeatureType.fold,
            state: ui.DisplayFeatureState.postureHalfOpened,
          ),
        ],
      );
      expect(layout.fullBrowse, const Rect.fromLTWH(0, 0, 851, 883));
      expect(layout.separated, true);
      expect(layout.split, true);
      expect(layout.browse.overlaps(layout.detail), false);
    }
  });
}
