import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(SchoolAI());
}

class SchoolAI extends StatelessWidget {
  const SchoolAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professor AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(139, 95, 191, 1)),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Display SplashScreen initially
    );
  }
}
