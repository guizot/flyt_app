import 'dart:ui';
import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        borderColor: borderColor,
        borderWidth: borderWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = _createDashedPath(path);

    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source) {
    final Path dashedPath = Path();
    for (PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < pathMetric.length) {
        double length = draw ? dashWidth : dashSpace;
        if (distance + length > pathMetric.length) {
          length = pathMetric.length - distance;
        }
        final Path segment = pathMetric.extractPath(distance, distance + length);
        if (draw) {
          dashedPath.addPath(segment, Offset.zero);
        }
        distance += length;
        draw = !draw;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
