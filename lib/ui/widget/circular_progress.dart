import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final double percent;
  final double size;
  final TextStyle textStyle;
  final double strokeWidth;
  const CircularProgress({super.key,  
    required this.size, 
    required this.strokeWidth,
    required this.percent, 
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: _CircularPainter(percent, strokeWidth),
        child: Center(child: Text("${(percent).round()}%", style: textStyle,)),
      ),
    );
  }
}

class _CircularPainter extends CustomPainter {
  final double percent;
  final double strokeWidth;
  
  _CircularPainter(this.percent, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    // final rect = Offset.zero & size;

    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final fgPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      2 * pi,
      false,
      bgPaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      2 * pi * percent,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}