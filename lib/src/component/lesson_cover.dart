import 'package:flutter/material.dart';
import 'content.dart';

/// Original vector covers shared by discovery, library and collection previews.
/// IDs are stable public values; matching never depends on a mutable title.
abstract final class LearnDefaultCovers {
  static const labels = <String, String>{
    'coffee': 'Khoảng nghỉ',
    'flame': 'Ngọn lửa',
    'hills': 'Đồi nhỏ',
    'leaves': 'Mầm xanh',
    'waves': 'Sóng nhẹ',
    'moon': 'Đêm yên',
    'book': 'Trang sách',
    'headphones': 'Nhịp nghe',
  };
  static String forId(String id) {
    var hash = 2166136261;
    for (final unit in id.codeUnits) {
      hash = ((hash ^ unit) * 16777619) & 0xffffffff;
    }
    return labels.keys.elementAt(hash % labels.length);
  }

  static int variant(String coverId) =>
      labels.keys.toList().indexOf(coverId) + 1;
}

class LearnLessonCover extends StatelessWidget {
  const LearnLessonCover({
    super.key,
    required this.id,
    this.coverId,
    this.height = 180,
  });
  final String id;
  final String? coverId;
  final double height;
  @override
  Widget build(BuildContext context) {
    final chosen = LearnDefaultCovers.labels.containsKey(coverId)
        ? coverId!
        : LearnDefaultCovers.forId(id);
    return LearnLessonArt(
      variant: LearnDefaultCovers.variant(chosen),
      height: height,
    );
  }
}
