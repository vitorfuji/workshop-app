import 'package:flutter/material.dart';

import '../utils.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PodiColors.white.withOpacity(0.1)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      (size.width / 2 - 30) * 0.6,
      paint,
    );
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackgroundPainter oldDelegate) => false;
}
