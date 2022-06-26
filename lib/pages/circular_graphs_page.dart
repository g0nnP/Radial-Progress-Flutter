import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/radial_progress_widget.dart';

class CircularGraphs extends StatefulWidget {
  const CircularGraphs({Key? key}) : super(key: key);

  @override
  State<CircularGraphs> createState() => _CircularGraphsState();
}

class _CircularGraphsState extends State<CircularGraphs> {

  double percentage1 = 10;
  double percentage2 = 10;
  double percentage3 = 10;
  double percentage4 = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(
                percentage: percentage1,
                color: Colors.teal
              ),
              CustomRadialProgress(
                percentage: percentage2,
                color: Colors.deepPurpleAccent
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(
                percentage: percentage3,
                color: Colors.deepOrange
              ),
              CustomRadialProgress(
                percentage: percentage4,
                color: Colors.purple
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: (){
          final number1 = Random().nextInt(101).toDouble();
          final number2 = Random().nextInt(101).toDouble();
          final number3 = Random().nextInt(101).toDouble();
          final number4 = Random().nextInt(101).toDouble();

          percentage1 = number1;
          percentage2 = number2;
          percentage3 = number3;
          percentage4 = number4;
          setState(() {});
        },
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {

  final Color color;

  const CustomRadialProgress({
    Key? key,
    required this.percentage,
    required this.color
  }) : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: RadialProgress(
        percentage: percentage,
        primaryColor: color,
        secondaryColor: Colors.blueGrey,
        secondaryThickness: 8,
        primaryThickness: 4,
      ),
    );
  }
}