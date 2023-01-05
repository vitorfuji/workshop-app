import 'dart:math';

import 'package:flutter/material.dart';

class IndicatorPainter extends CustomPainter {
  final double radius;

  IndicatorPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final arcPaint = Paint()
      // ..color = PodiColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    final arc = Path()
      ..moveTo(0, 0)
      ..relativeArcToPoint(
        Offset(size.width, 0),
        radius: Radius.circular(radius),
        clockwise: false,
      );
    canvas.drawPath(arc, arcPaint);

    final trianglePaint = Paint()
      // ..color = PodiColors.white
      ..style = PaintingStyle.fill;

    const triangleSize = 32.0;
    final triangle = Path()
      ..moveTo(size.width / 2, size.height)
      ..relativeLineTo(triangleSize / 2, -triangleSize / 2 * sqrt(3))
      ..relativeLineTo(-triangleSize, 0);
    canvas.drawPath(triangle, trianglePaint);
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IndicatorPainter oldDelegate) => false;
}
