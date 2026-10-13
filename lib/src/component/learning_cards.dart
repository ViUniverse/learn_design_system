import 'package:flutter/material.dart';
import '../foundation/theme.dart';
import '../foundation/typography.dart';

/// One visual contract for a lesson, independent of storage or playback engine.
class LearnLessonCard extends StatelessWidget {
  const LearnLessonCard({
    super.key,
    required this.title,
    required this.cover,
    required this.onOpen,
    this.description,
    this.metadata,
    this.progress,
    this.actions,
    this.leading,
    this.grid = false,
    this.selected = false,
    this.selecting = false,
  });
  final String title;
  final Widget cover;
  final String? description, metadata;
  final Widget? progress, actions, leading;
  final VoidCallback onOpen;
  final bool grid, selected, selecting;
  @override
  Widget build(BuildContext context) => _ContentCard(
    onOpen: onOpen,
    selected: selected,
    selecting: selecting,
    footer: progress == null && actions == null && leading == null
        ? null
        : LayoutBuilder(
            builder: (context, box) {
              if (box.maxWidth < 280 ||
                  MediaQuery.textScalerOf(context).scale(16) > 24) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ?progress,
                    if (leading != null || actions != null) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [?leading, ?actions],
                      ),
                    ],
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ?leading,
                  Expanded(child: progress ?? const SizedBox.shrink()),
                  ?actions,
                ],
              );
            },
          ),
    child: LayoutBuilder(
      builder: (context, box) {
        final stack =
            grid ||
            box.maxWidth < 260 ||
            MediaQuery.textScalerOf(context).scale(16) > 24;
        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: LearnType.h3),
            if (description?.isNotEmpty == true) ...[
              const SizedBox(height: 6),
              Text(
                description!,
                style: LearnType.small.copyWith(
                  color: context.color('text-secondary'),
                ),
              ),
            ],
            if (metadata?.isNotEmpty == true) ...[
              const SizedBox(height: 10),
              Text(
                metadata!,
                style: LearnType.small.copyWith(
                  color: context.color('text-secondary'),
                ),
              ),
            ],
          ],
        );
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (grid)
                AspectRatio(aspectRatio: 1, child: cover)
              else
                SizedBox(width: 96, height: 96, child: cover),
              const SizedBox(height: 14),
              details,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 80, height: 80, child: cover),
            const SizedBox(width: 16),
            Expanded(child: details),
          ],
        );
      },
    ),
  );
}

/// Collections are containers: a stack of covers, a category label and counts.
/// Their hierarchy is expressed by structure, rather than a second lesson icon.
class LearnCollectionCard extends StatelessWidget {
  const LearnCollectionCard({
    super.key,
    required this.title,
    required this.covers,
    required this.count,
    required this.onOpen,
    this.groupCount = 0,
    this.actions,
  });
  final String title;
  final List<Widget> covers;
  final int count, groupCount;
  final VoidCallback onOpen;
  final Widget? actions;
  @override
  Widget build(BuildContext context) => _ContentCard(
    onOpen: onOpen,
    footer: Row(
      children: [
        Expanded(
          child: Text(
            '$count bài${groupCount > 0 ? ' · $groupCount nhóm' : ''}',
            style: LearnType.small.copyWith(
              color: context.color('text-secondary'),
            ),
          ),
        ),
        if (actions != null)
          actions!
        else
          const Icon(Icons.chevron_right_rounded),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.folder_open_rounded,
              size: 16,
              color: context.color('text-secondary'),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Bộ sưu tập',
                style: LearnType.label.copyWith(
                  color: context.color('text-secondary'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, box) {
            final art = SizedBox(
              width: 106,
              height: 82,
              child: Stack(
                children: [
                  for (final (index, cover)
                      in covers.take(3).indexed.toList().reversed)
                    Positioned(
                      left: index * 11,
                      top: index * 5,
                      width: 76,
                      height: 72,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: context.color('surface'),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: cover,
                        ),
                      ),
                    ),
                ],
              ),
            );
            final name = Text(title, style: LearnType.h3);
            if (box.maxWidth < 260 ||
                MediaQuery.textScalerOf(context).scale(16) > 24) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [art, const SizedBox(height: 12), name],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                art,
                const SizedBox(width: 12),
                Expanded(child: name),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _ContentCard extends StatefulWidget {
  const _ContentCard({
    required this.onOpen,
    required this.child,
    this.footer,
    this.selected = false,
    this.selecting = false,
  });
  final VoidCallback onOpen;
  final Widget child;
  final Widget? footer;
  final bool selected, selecting;
  @override
  State<_ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<_ContentCard> {
  bool focused = false;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        width: 2,
        color: focused ? context.color('focus-ring') : Colors.transparent,
      ),
    ),
    child: Material(
      color: context.color(
        widget.selected ? 'selected-background' : 'background-subtle',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: context.color('border-subtle')),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            link: !widget.selecting,
            button: widget.selecting,
            selected: widget.selected,
            child: InkWell(
              onTap: widget.onOpen,
              onFocusChange: (value) => setState(() => focused = value),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: widget.child,
              ),
            ),
          ),
          if (widget.footer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: widget.footer,
            ),
        ],
      ),
    ),
  );
}
