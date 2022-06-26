import 'package:flutter/material.dart';
import 'package:radial_progress/pages/circular_graphs_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  MaterialApp build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CircularGraphs(),
  );
}
