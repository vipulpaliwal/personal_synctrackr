import 'dart:math';

import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final double borderRadius;
  final Color topLeftColor;
  final Color topRightColor;
  final Color bottomLeftColor;
  final Color bottomRightColor;
  final Color? backgroundColor;

  const GradientBorderContainer({
    super.key,
    required this.child,
    this.borderWidth = 2.0,
    this.borderRadius = 0.0,
    required this.topLeftColor,
    required this.topRightColor,
    required this.bottomLeftColor,
    required this.bottomRightColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BlendedGradientBorderPainter(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        topLeftColor: topLeftColor,
        topRightColor: topRightColor,
        bottomLeftColor: bottomLeftColor,
        bottomRightColor: bottomRightColor,
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(
              borderRadius > borderWidth ? borderRadius - borderWidth : 0),
        ),
        child: child,
      ),
    );
  }
}
class BlendedGradientBorderPainter extends CustomPainter {
  final double borderWidth;
  final double borderRadius;
  final Color topLeftColor;
  final Color topRightColor;
  final Color bottomLeftColor;
  final Color bottomRightColor;

  BlendedGradientBorderPainter({
    required this.borderWidth,
    required this.borderRadius,
    required this.topLeftColor,
    required this.topRightColor,
    required this.bottomLeftColor,
    required this.bottomRightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect outerRect = Offset.zero & size;
    final RRect outerRRect = RRect.fromRectAndRadius(
      outerRect,
      Radius.circular(borderRadius),
    );

    final Rect innerRect = Rect.fromLTWH(
      borderWidth,
      borderWidth,
      size.width - 2 * borderWidth,
      size.height - 2 * borderWidth,
    );
    final RRect innerRRect = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular(borderRadius > borderWidth ? borderRadius - borderWidth : 0),
    );

    final Path path = Path()
      ..addRRect(outerRRect)
      ..addRRect(innerRRect)
      ..fillType = PathFillType.evenOdd;

    canvas.save();
    canvas.clipPath(path);

    final double width = size.width;
    final double height = size.height;
    final double borderWidth2x = borderWidth * 2;

    canvas.drawRect(
        Rect.fromLTWH(0, 0, width, borderWidth2x),
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [topLeftColor, topRightColor],
          ).createShader(Rect.fromLTWH(0, 0, width, borderWidth2x))
          ..style = PaintingStyle.fill
    );

    canvas.drawRect(
        Rect.fromLTWH(width - borderWidth2x, 0, borderWidth2x, height),
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topRightColor, bottomRightColor],
          ).createShader(Rect.fromLTWH(width - borderWidth2x, 0, borderWidth2x, height))
          ..style = PaintingStyle.fill
    );

    canvas.drawRect(
        Rect.fromLTWH(0, height - borderWidth2x, width, borderWidth2x),
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [bottomLeftColor, bottomRightColor],
          ).createShader(Rect.fromLTWH(0, height - borderWidth2x, width, borderWidth2x))
          ..style = PaintingStyle.fill
    );

    canvas.drawRect(
        Rect.fromLTWH(0, 0, borderWidth2x, height),
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topLeftColor, bottomLeftColor],
          ).createShader(Rect.fromLTWH(0, 0, borderWidth2x, height))
          ..style = PaintingStyle.fill
    );

    double cornerSize = max(borderRadius * 2, 20);

    _drawCorner(
        canvas,
        Rect.fromLTWH(0, 0, cornerSize, cornerSize),
        topLeftColor,
        Alignment.topLeft
    );

    _drawCorner(
        canvas,
        Rect.fromLTWH(width - cornerSize, 0, cornerSize, cornerSize),
        topRightColor,
        Alignment.topRight
    );

    _drawCorner(
        canvas,
        Rect.fromLTWH(0, height - cornerSize, cornerSize, cornerSize),
        bottomLeftColor,
        Alignment.bottomLeft
    );

    _drawCorner(
        canvas,
        Rect.fromLTWH(width - cornerSize, height - cornerSize, cornerSize, cornerSize),
        bottomRightColor,
        Alignment.bottomRight
    );

    canvas.restore();
  }

  void _drawCorner(Canvas canvas, Rect rect, Color color, Alignment alignment) {
    canvas.drawRect(
        rect,
        Paint()
          ..shader = RadialGradient(
            center: alignment,
            radius: 0.5,
            colors: [color, color.withOpacity(0.0)],
          ).createShader(rect)
          ..style = PaintingStyle.fill
    );
  }

  @override
  bool shouldRepaint(BlendedGradientBorderPainter oldDelegate) {
    return oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.topLeftColor != topLeftColor ||
        oldDelegate.topRightColor != topRightColor ||
        oldDelegate.bottomLeftColor != bottomLeftColor ||
        oldDelegate.bottomRightColor != bottomRightColor;
  }
}
