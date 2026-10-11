import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_design_system/learn_design_system.dart';

void main() {
  for (final direction in TextDirection.values) {
    test(
      'Every target clears a camera, fold line, and blocked first band in $direction',
      () {
        const blocks = [
          Rect.fromLTWH(0, 0, 320, 50),
          Rect.fromLTWH(120, 50, 20, 180),
          Rect.fromLTWH(240, 50, 0, 180),
        ];
        final layout = LearnToolbarLayout.resolve(
          width: 320,
          count: 18,
          direction: direction,
          obstacles: blocks,
        );
        expect(layout.controls, hasLength(18));
        for (final target in layout.controls) {
          expect(target.size, const Size(48, 48));
          expect(target.left, greaterThanOrEqualTo(0));
          expect(target.right, lessThanOrEqualTo(320));
          expect(target.bottom, lessThanOrEqualTo(layout.height));
          for (final block in blocks) {
            expect(target.overlaps(block), false);
            if (block.width == 0 && target.top < block.bottom) {
              expect(
                target.left < block.left && target.right > block.left,
                false,
              );
            }
          }
        }
        for (var i = 0; i < layout.controls.length; i++) {
          for (var j = i + 1; j < layout.controls.length; j++) {
            expect(layout.controls[i].overlaps(layout.controls[j]), false);
          }
        }
      },
    );
  }

  testWidgets(
    'Toolbar actions remain tappable after wrapping and title returns at larger widths',
    (tester) async {
      var tapped = -1;
      Widget surface(double width) => MaterialApp(
        theme: learnTheme(Brightness.light),
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: width,
              child: LearnToolbar(
                title: const Text('Công cụ'),
                actions: [
                  for (var i = 0; i < 8; i++)
                    LearnIconButton(
                      icon: Icons.add,
                      label: 'Action $i',
                      onPressed: () => tapped = i,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpWidget(surface(160));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Công cụ'), findsNothing);
      for (var i = 0; i < 8; i++) {
        await tester.tap(find.byTooltip('Action $i'));
        expect(tapped, i);
      }
      await tester.pumpWidget(surface(700));
      await tester.pumpAndSettle();
      expect(find.text('Công cụ'), findsOneWidget);
      for (var i = 0; i < 8; i++) {
        final rect = tester.getRect(find.byTooltip('Action $i'));
        expect(rect.right, lessThanOrEqualTo(700));
      }
      expect(tester.takeException(), isNull);
    },
  );
}
