import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../foundation/theme.dart';
import 'controls.dart';

class LearnBrand extends StatelessWidget {
  const LearnBrand({super.key, this.compact = false});
  final bool compact;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFFA18ABD), Color(0xFF71608D)],
          ),
        ),
        child: const Icon(
          Icons.graphic_eq_rounded,
          color: Colors.white,
          size: 23,
        ),
      ),
      if (!compact) ...[
        const SizedBox(width: 10),
        const Flexible(
          child: Text(
            'Vi Learn',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              letterSpacing: -.7,
            ),
          ),
        ),
      ],
    ],
  );
}

class LearnSectionTitle extends StatelessWidget {
  const LearnSectionTitle(
    this.title, {
    super.key,
    this.trailing,
    this.subtitle,
  });
  final String title;
  final String? subtitle;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 23,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -.5,
                ),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 14,
                  color: context.color('text-secondary'),
                ),
              ),
            ],
          ],
        ),
        ?trailing,
      ],
    ),
  );
}

class LearnCard extends StatelessWidget {
  const LearnCard({
    super.key,
    required this.child,
    this.padding = 24,
    this.color,
  });
  final Widget child;
  final double padding;
  final Color? color;
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: color ?? context.color('surface'),
      border: Border.all(color: context.color('border-subtle')),
      borderRadius: BorderRadius.circular(24),
    ),
    child: child,
  );
}

class LearnPill extends StatelessWidget {
  const LearnPill(this.text, {super.key, this.icon, this.warm = false});
  final String text;
  final IconData? icon;
  final bool warm;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
    decoration: BoxDecoration(
      color: context.color(warm ? 'peach-background' : 'background-subtle'),
      borderRadius: BorderRadius.circular(99),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: context.color(warm ? 'peach-foreground' : 'text-secondary'),
          ),
          const SizedBox(width: 5),
        ],
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: context.color(
                warm ? 'peach-foreground' : 'text-secondary',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class LearnLessonArt extends StatelessWidget {
  const LearnLessonArt({super.key, this.variant = 2, this.height = 180});
  final int variant;
  final double height;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(painter: _CoverPainter(variant, context.isDark)),
      ),
    ),
  );
}

class _CoverPainter extends CustomPainter {
  _CoverPainter(this.variant, this.dark);
  final int variant;
  final bool dark;
  @override
  void paint(Canvas c, Size s) {
    final bg = dark ? const Color(0xFF3D332A) : const Color(0xFFF1E5D5);
    final ink = dark ? const Color(0xFFEED9BF) : const Color(0xFF5B493A);
    c.drawRect(Offset.zero & s, Paint()..color = bg);
    for (var i = 0; i < 85; i++) {
      c.drawCircle(
        Offset((i * 43.7) % s.width, (i * 21.3) % s.height),
        .7,
        Paint()..color = ink.withValues(alpha: .055),
      );
    }
    final middle = Offset(s.width * .52, s.height * .55);
    if (variant == 2) {
      final flame = Path()
        ..moveTo(middle.dx, s.height * .13)
        ..cubicTo(
          s.width * .49,
          s.height * .4,
          s.width * .78,
          s.height * .55,
          s.width * .62,
          s.height * .78,
        )
        ..cubicTo(
          s.width * .5,
          s.height * .95,
          s.width * .28,
          s.height * .78,
          s.width * .36,
          s.height * .55,
        )
        ..cubicTo(
          s.width * .38,
          s.height * .41,
          s.width * .49,
          s.height * .37,
          middle.dx,
          s.height * .13,
        );
      c.drawPath(flame, Paint()..color = const Color(0xFFB57156));
      final core = Path()
        ..moveTo(middle.dx, s.height * .5)
        ..quadraticBezierTo(
          s.width * .65,
          s.height * .85,
          middle.dx,
          s.height * .84,
        )
        ..quadraticBezierTo(
          s.width * .4,
          s.height * .79,
          middle.dx,
          s.height * .5,
        );
      c.drawPath(core, Paint()..color = const Color(0xFFE9BC83));
    } else if (variant == 1) {
      c.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: middle,
            width: s.width * .34,
            height: s.height * .32,
          ),
          const Radius.circular(12),
        ),
        Paint()..color = const Color(0xFFB57156),
      );
      c.drawArc(
        Rect.fromCenter(
          center: Offset(s.width * .72, middle.dy),
          width: s.width * .16,
          height: s.height * .25,
        ),
        -math.pi / 2,
        math.pi,
        false,
        Paint()
          ..color = const Color(0xFFB57156)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7,
      );
      for (var i = 0; i < 3; i++) {
        c.drawPath(
          Path()
            ..moveTo(s.width * (.43 + i * .07), s.height * .31)
            ..quadraticBezierTo(
              s.width * (.38 + i * .07),
              s.height * .19,
              s.width * (.45 + i * .07),
              s.height * .11,
            ),
          Paint()
            ..color = ink.withValues(alpha: .35)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      }
    } else if (variant >= 4 && variant <= 8) {
      final accent = Paint()..color = const Color(0xFFB57156);
      final line = Paint()
        ..color = ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = s.shortestSide * .035
        ..strokeCap = StrokeCap.round;
      final w = s.width, h = s.height;
      switch (variant) {
        case 4:
          c.drawLine(Offset(w * .5, h * .78), Offset(w * .5, h * .29), line);
          for (final (x, y) in [(0.27, 0.4), (0.56, 0.25), (0.56, 0.49)]) {
            c.drawOval(Rect.fromLTWH(w * x, h * y, w * .22, h * .18), accent);
          }
        case 5:
          c.drawCircle(Offset(w * .7, h * .27), h * .11, accent);
          for (var i = 0; i < 3; i++) {
            c.drawPath(
              Path()
                ..moveTo(w * .1, h * (.48 + i * .12))
                ..cubicTo(
                  w * .32,
                  h * (.22 + i * .12),
                  w * .66,
                  h * (.7 + i * .12),
                  w * .9,
                  h * (.45 + i * .12),
                ),
              line,
            );
          }
        case 6:
          c.drawCircle(Offset(w * .51, h * .46), s.shortestSide * .25, accent);
          c.drawCircle(
            Offset(w * .65, h * .33),
            s.shortestSide * .22,
            Paint()..color = bg,
          );
          for (final (x, y) in [(0.22, 0.24), (0.79, 0.7), (0.24, 0.75)]) {
            c.drawCircle(
              Offset(w * x, h * y),
              s.shortestSide * .018,
              line..style = PaintingStyle.fill,
            );
          }
        case 7:
          final book = Path()
            ..moveTo(w * .18, h * .29)
            ..quadraticBezierTo(w * .36, h * .19, w * .5, h * .34)
            ..quadraticBezierTo(w * .64, h * .19, w * .82, h * .29)
            ..lineTo(w * .82, h * .74)
            ..quadraticBezierTo(w * .64, h * .64, w * .5, h * .8)
            ..quadraticBezierTo(w * .36, h * .64, w * .18, h * .74)
            ..close();
          c.drawPath(book, accent);
          c.drawLine(Offset(w * .5, h * .36), Offset(w * .5, h * .74), line);
          c.drawLine(Offset(w * .26, h * .43), Offset(w * .41, h * .46), line);
          c.drawLine(Offset(w * .6, h * .46), Offset(w * .74, h * .43), line);
        case 8:
          c.drawArc(
            Rect.fromLTWH(w * .23, h * .21, w * .54, h * .62),
            math.pi,
            math.pi,
            false,
            line..strokeWidth = s.shortestSide * .065,
          );
          for (final x in [.18, .69]) {
            c.drawRRect(
              RRect.fromRectAndRadius(
                Rect.fromLTWH(w * x, h * .47, w * .14, h * .29),
                Radius.circular(s.shortestSide * .06),
              ),
              accent,
            );
          }
      }
    } else {
      c.drawCircle(
        Offset(s.width * .69, s.height * .3),
        s.height * .16,
        Paint()..color = const Color(0xFFB57156),
      );
      c.drawPath(
        Path()
          ..moveTo(0, s.height * .73)
          ..quadraticBezierTo(
            s.width * .45,
            s.height * .1,
            s.width,
            s.height * .77,
          )
          ..lineTo(s.width, s.height)
          ..lineTo(0, s.height),
        Paint()
          ..color = dark ? const Color(0xFF514536) : const Color(0xFFA38B73),
      );
      c.drawPath(
        Path()
          ..moveTo(0, s.height * .9)
          ..quadraticBezierTo(
            s.width * .65,
            s.height * .35,
            s.width,
            s.height * .92,
          )
          ..lineTo(s.width, s.height)
          ..lineTo(0, s.height),
        Paint()
          ..color = dark ? const Color(0xFF685441) : const Color(0xFFC7AD88),
      );
    }
  }

  @override
  bool shouldRepaint(_CoverPainter old) =>
      old.variant != variant || old.dark != dark;
}

class LearnMainAction extends StatelessWidget {
  const LearnMainAction(
    this.label,
    this.onPressed, {
    super.key,
    this.icon = Icons.arrow_forward_rounded,
  });
  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) => LearnButton(
    onPressed: onPressed,

    trailing: Icon(icon, size: 20),
    child: Text(label),
  );
}
