import 'package:flutter/material.dart';
import 'dart:math' as math;

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const borderRadius = 30.0;
    const notchRadius = 15.0;
    final ticketHeight = size.height * 1.1; // Make height a bit larger
    final ticketWidth = size.width * 1; // Reduce width
    final notchPosition =
        (ticketWidth / 2) * (2 / 3); // Move notches into 2/3 of their space

    // Rotate the canvas by 90 degrees
    canvas.save();
    canvas.translate(size.width, 0);
    canvas.rotate(math.pi / 2);

    final path = Path()
      ..moveTo(borderRadius, 0)
      ..lineTo(ticketHeight - borderRadius, 0)
      ..arcToPoint(
        Offset(ticketHeight, borderRadius),
        radius: const Radius.circular(borderRadius),
        clockwise: true,
      )
      ..lineTo(ticketHeight, notchPosition - notchRadius)
      ..arcToPoint(
        Offset(ticketHeight, notchPosition + notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(ticketHeight, ticketWidth - borderRadius)
      ..arcToPoint(
        Offset(ticketHeight - borderRadius, ticketWidth),
        radius: const Radius.circular(borderRadius),
        clockwise: true,
      )
      ..lineTo(borderRadius, ticketWidth)
      ..arcToPoint(
        Offset(0, ticketWidth - borderRadius),
        radius: const Radius.circular(borderRadius),
        clockwise: true,
      )
      ..lineTo(0, notchPosition + notchRadius)
      ..arcToPoint(
        Offset(0, notchPosition - notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(0, borderRadius)
      ..arcToPoint(
        const Offset(borderRadius, 0),
        radius: const Radius.circular(borderRadius),
        clockwise: true,
      )
      ..close();

    // Draw shadow for the entire ticket
    final shadowPath = path.shift(const Offset(0, 3));
    canvas.drawShadow(shadowPath, Colors.black, 7.0, true);

    // Clip the upper part and fill with red
    canvas.save();
    canvas.clipPath(
        Path()..addRect(Rect.fromLTWH(0, 0, ticketHeight, notchPosition)));
    final upperPaint = Paint()
      //..color = Color.fromRGBO(86, 111, 193, 1)
      ..color = const Color.fromRGBO(255, 255, 255, 1)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, upperPaint);
    canvas.restore();

    // Clip the lower part and fill with white
    canvas.save();
    canvas.clipPath(Path()
      ..addRect(Rect.fromLTWH(
          0, notchPosition, ticketHeight, ticketWidth - notchPosition)));
    final lowerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, lowerPaint);
    canvas.restore();

    // Draw the dashed line between the notches
    final linePaint = Paint()
      ..color = const Color.fromARGB(255, 224, 224, 224)
      ..strokeWidth = 2.0;
    const dashWidth = 5;
    const dashSpace = 5;
    double startX = 15;
    while (startX < ticketHeight - 15) {
      canvas.drawLine(
        Offset(startX, notchPosition),
        Offset(startX + dashWidth, notchPosition),
        linePaint,
      );
      startX += dashWidth + dashSpace;
    }

    // Restore the canvas to its original orientation
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
