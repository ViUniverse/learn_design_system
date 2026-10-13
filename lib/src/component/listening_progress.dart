import 'package:flutter/material.dart';
import '../foundation/theme.dart';

class LearnListeningProgress extends StatelessWidget {
  const LearnListeningProgress({
    super.key,
    required this.title,
    required this.completed,
    required this.progress,
    required this.remainingSeconds,
    this.started = true,
  });
  final String title;
  final bool completed;
  final bool started;
  final double? progress;
  final int? remainingSeconds;
  @override
  Widget build(BuildContext context) {
    final remaining = remainingSeconds;
    final progress = this.progress;
    final label = !started && !completed
        ? 'Chưa nghe'
        : completed
        ? 'Đã nghe'
        : remaining == null
        ? 'Đang nghe'
        : 'Còn ${remaining ~/ 60}:${(remaining % 60).toString().padLeft(2, '0')}';
    return Semantics(
      label: 'Tiến độ nghe $title',
      value: !started && !completed
          ? 'Chưa nghe'
          : completed
          ? 'Đã nghe'
          : progress == null
          ? 'Đang nghe, chưa có tổng thời lượng'
          : 'Đã nghe ${(progress * 100).round()} phần trăm, $label',
      child: ExcludeSemantics(
        child: Wrap(
          spacing: 10,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (completed || progress == null || !started)
              Icon(
                completed ? Icons.check_rounded : Icons.headphones_rounded,
                size: 15,
                color: context.color('text-secondary'),
              )
            else
              SizedBox(
                width: 96,
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 3,
                  borderRadius: BorderRadius.circular(8),
                  color: context.color('progress-active'),
                  backgroundColor: context.color('progress-track'),
                ),
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: context.color('text-secondary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
