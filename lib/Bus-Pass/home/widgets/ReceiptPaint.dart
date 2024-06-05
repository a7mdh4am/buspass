import 'package:flutter/material.dart';

class ReceiptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderRadius = 20.0;
    final notchRadius = 20.0;
    final notchPosition = size.height / 3; // One-third of the height

    final path = Path()
      ..moveTo(borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..arcToPoint(
        Offset(size.width, borderRadius),
        radius: Radius.circular(borderRadius),
        clockwise: true,
      )
      ..lineTo(size.width, notchPosition - notchRadius)
      ..arcToPoint(
        Offset(size.width, notchPosition + notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height - borderRadius)
      ..arcToPoint(
        Offset(size.width - borderRadius, size.height),
        radius: Radius.circular(borderRadius),
        clockwise: true,
      )
      ..lineTo(borderRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - borderRadius),
        radius: Radius.circular(borderRadius),
        clockwise: true,
      )
      ..lineTo(0, notchPosition + notchRadius)
      ..arcToPoint(
        Offset(0, notchPosition - notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(0, borderRadius)
      ..arcToPoint(
        Offset(borderRadius, 0),
        radius: Radius.circular(borderRadius),
        clockwise: true,
      )
      ..close();

    // Draw the reflected ticket vertically
    canvas.save();
    canvas.scale(1.0, -1.0); // Reflect vertically
    canvas.translate(0.0, -size.height); // Move back to original position

    // Drawing ticket path
    canvas.drawPath(path, paint);

    // Drawing dashed line from right notch to left notch
    final dashedLinePaint = Paint()
      ..color = const Color.fromARGB(255, 224, 224, 224) // Change color to grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final dashWidth = 5;
    final dashSpace = 4.5;

    // Calculate total length of the path
    final totalLength = size.width - notchRadius;

    // Draw dashes along the path
    for (double i = totalLength; i > 20; i -= dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(i, notchPosition),
        Offset(i - dashWidth, notchPosition),
        dashedLinePaint,
      );
    }

    canvas.restore(); // Restore the canvas to its original state
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
