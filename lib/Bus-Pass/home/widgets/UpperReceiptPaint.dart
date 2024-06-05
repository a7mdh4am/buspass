import 'package:flutter/material.dart';

class UpperReceiptPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderRadius = 20.0;

    // Reflect the canvas vertically
    canvas.save();
    canvas.scale(1, -1);
    canvas.translate(0, -size.height);

    final path = Path()
      ..moveTo(borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..arcToPoint(
        Offset(size.width, borderRadius),
        radius: Radius.circular(borderRadius),
        clockwise: false, // Draw arc inward
      )
      ..lineTo(size.width, size.height - borderRadius)
      ..arcToPoint(
        Offset(size.width - borderRadius, size.height),
        radius: Radius.circular(borderRadius),
        clockwise: true, // Draw arc outward
      )
      ..lineTo(borderRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - borderRadius),
        radius: Radius.circular(borderRadius),
        clockwise: true, // Draw arc outward
      )
      ..lineTo(0, borderRadius)
      ..arcToPoint(
        Offset(borderRadius, 0),
        radius: Radius.circular(borderRadius),
        clockwise: false, // Draw arc inward
      )
      ..close();

    // Draw the ticket path
    canvas.drawPath(path, paint);

    // Restore the canvas to its original state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
