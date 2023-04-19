import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WindDirectionIndicator extends StatelessWidget {
  final int windDegree;

  WindDirectionIndicator({super.key, required this.windDegree, width, height});

  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 60.w,
      height: height ?? 50.h,
      child: CustomPaint(
        painter: _WindDirectionPainter(windDegree: windDegree),
      ),
    );
  }
}

class _WindDirectionPainter extends CustomPainter {
  final int windDegree;

  _WindDirectionPainter({required this.windDegree});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final angle = (windDegree - 180) % 360; //- 90
    final radians = angle * math.pi / 180;

    final path = Path()
      ..moveTo(center.dx, center.dy - radius * 0.7)
      ..lineTo(center.dx - radius * 0.15, center.dy + radius * 0.35)
      ..lineTo(center.dx + radius * 0.15, center.dy + radius * 0.35)
      ..close();

    final paint = Paint()
      ..color = Colors.lightBlue[200]!
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(radians);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
