import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_design_system/learn_design_system.dart';

void main() {
  testWidgets('Cover override, automatic fallback and decorative semantics', (
    tester,
  ) async {
    final key = LearnDefaultCovers.forId('stable-lesson-id');
    Future<int> variant(String? cover) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LearnLessonCover(id: 'stable-lesson-id', coverId: cover),
        ),
      );
      return tester.widget<LearnLessonArt>(find.byType(LearnLessonArt)).variant;
    }

    expect(await variant(null), LearnDefaultCovers.variant(key));
    expect(await variant('waves'), LearnDefaultCovers.variant('waves'));
    expect(
      await variant('unknown-future-cover'),
      LearnDefaultCovers.variant(key),
    );
    expect(LearnDefaultCovers.labels.length, 8);
  });
  for (final dark in [false, true]) {
    for (final width in [320.0, 390.0, 768.0, 1440.0]) {
      for (final scale in [1.0, 2.0]) {
        testWidgets(
          'Cards retain description, listening facts and separate actions $width $dark $scale',
          (tester) async {
            tester.view.physicalSize = Size(width, 1200);
            tester.view.devicePixelRatio = 1;
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(tester.view.resetDevicePixelRatio);
            var opens = 0;
            var actions = 0;
            Widget card(
              String title,
              bool started,
              bool done,
              double? progress,
            ) => LearnLessonCard(
              title: title,
              description:
                  'Một đoạn nghe có dấu tiếng Việt để luyện tập mỗi ngày.',
              metadata: 'Tiếng Anh · MP3',
              cover: LearnLessonCover(id: title),
              onOpen: () => opens++,
              progress: LearnListeningProgress(
                title: title,
                started: started,
                completed: done,
                progress: progress,
                remainingSeconds: progress == null ? null : 90,
              ),
              actions: LearnButton(
                style: LearnButtonStyle.quiet,
                onPressed: () => actions++,
                child: const Text('Thao tác'),
              ),
            );
            await tester.pumpWidget(
              MaterialApp(
                theme: learnTheme(dark ? Brightness.dark : Brightness.light),
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(scale)),
                  child: child!,
                ),
                home: Scaffold(
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          LearnCollectionCard(
                            title: 'Các bài nghe buổi sáng',
                            covers: [
                              for (final id in ['a', 'b', 'c'])
                                LearnLessonCover(id: id),
                            ],
                            count: 3,
                            onOpen: () {},
                          ),
                          card('Bài mới', false, false, null),
                          card('Bài đang nghe', true, false, .25),
                          card('Bài đã nghe', true, true, 1),
                          card('Chưa biết thời lượng', true, false, null),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            await tester.pumpAndSettle();
            expect(find.text('Bộ sưu tập'), findsOneWidget);
            expect(find.text('3 bài'), findsOneWidget);
            expect(find.text('Chưa nghe'), findsOneWidget);
            expect(find.text('Còn 1:30'), findsOneWidget);
            expect(find.text('Đã nghe'), findsOneWidget);
            expect(find.text('Đang nghe'), findsOneWidget);
            expect(tester.takeException(), isNull);
            final action = find.text('Thao tác').first;
            await tester.ensureVisible(action);
            await tester.tap(action);
            expect(actions, 1);
            expect(opens, 0);
            await tester.ensureVisible(find.text('Bài mới'));
            await tester.tap(find.text('Bài mới'));
            expect(opens, 1);
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }
}
