import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_design_system/learn_design_system.dart';

const destinations = [
  LearnDestination(label: 'Trang chủ', icon: Icons.home),
  LearnDestination(label: 'Thư viện', icon: Icons.book),
  LearnDestination(label: 'Ôn tập', icon: Icons.school),
  LearnDestination(label: 'Cá nhân', icon: Icons.person),
];

void main() {
  testWidgets(
    'Narrow navigation wraps labels and keeps every target reachable',
    (tester) async {
      tester.view.physicalSize = const Size(320, 780);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var selected = -1;
      await tester.pumpWidget(
        MaterialApp(
          theme: learnTheme(Brightness.light),
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(320, 780),
              textScaler: TextScaler.linear(2),
            ),
            child: Scaffold(
              bottomNavigationBar: LearnNavigationBar(
                destinations: destinations,
                selected: 0,
                onSelected: (value) => selected = value,
              ),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byType(LearnNavigationBar)).height,
        lessThan(300),
      );
      for (final (index, destination) in destinations.indexed) {
        final target = find.widgetWithText(TextButton, destination.label);
        final rect = tester.getRect(target);
        expect(rect.width, greaterThanOrEqualTo(44));
        expect(rect.height, greaterThanOrEqualTo(48));
        await tester.tap(target);
        expect(selected, index);
      }
    },
  );
}
