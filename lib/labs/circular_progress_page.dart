import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({Key? key}) : super(key: key);

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  double percentage = 10.0;
  double newPercentage = 0.0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 800));

    controller.addListener((){
      percentage
        = lerpDouble(percentage, newPercentage, controller.value)!.toDouble();
      
      setState(() {});
    });
    super.initState();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          padding: const EdgeInsets.all(5),
          child: CustomPaint(
            painter: _RadialProgressPainter(percentage),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          percentage = newPercentage;
          double number = Math.Random().nextInt(100).toDouble();
          setState(() => newPercentage = number);
          controller.forward(from: 0.0);
        },
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _RadialProgressPainter extends CustomPainter {

  final double percentage;

  _RadialProgressPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {

    //Circulo completo
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey.shade600
      ..style = PaintingStyle.stroke;

    final c = Offset(size.width * 0.5, size.height * 0.5);
    final radius = Math.min(size.width / 2, size.height / 2);

    canvas.drawCircle(c, radius, paint);

    //Arco
    final paintArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.deepPurpleAccent
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