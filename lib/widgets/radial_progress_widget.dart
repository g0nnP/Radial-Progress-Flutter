import 'dart:math' as Math;

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {

  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double secondaryThickness;
  final double primaryThickness;

  const RadialProgress({
    super.key,
    required this.percentage,
    required this.primaryColor,
    required this.secondaryColor,
    required this.secondaryThickness,
    required this.primaryThickness
  });

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {

  late AnimationController controller;

  late double lastPercentage;

  @override
  void initState() {
    lastPercentage = widget.percentage;
    controller =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    controller.forward(from: 0.0);

    final double animationDifference = widget.percentage - lastPercentage;

    lastPercentage = widget.percentage;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: CustomPaint(
            painter: _RadialProgressPainter(
              (widget.percentage - animationDifference) + (animationDifference * controller.value),
              widget.primaryColor,
              widget.secondaryColor,
              widget.primaryThickness,
              widget.secondaryThickness
            ),
          ),
        );
      },
    );

    /* return */
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _RadialProgressPainter extends CustomPainter {

  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryThickness;
  final double secondaryThickness;

  _RadialProgressPainter(
    this.percentage,
    this.primaryColor,
    this.secondaryColor,
    this.secondaryThickness,
    this.primaryThickness
  );

  @override
  void paint(Canvas canvas, Size size) {

    //Circulo completo
    final paint = Paint()
      ..strokeWidth = secondaryThickness
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    final c = Offset(size.width * 0.5, size.height * 0.5);
    final radius = Math.min(size.width / 2, size.height / 2);

    canvas.drawCircle(c, radius, paint);

    //Arco
    final paintArc = Paint()
      ..strokeWidth = primaryThickness
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double arcAngle = Math.pi * 2 * (percentage / 100);

    canvas.drawArc(
      Rect.fromCircle(center: c, radius: radius),
      -Math.pi / 2,
      arcAngle,
      false,
      paintArc
    );

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}