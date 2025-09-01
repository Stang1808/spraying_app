import 'package:flutter/material.dart';
import 'spraying_dashboard.dart';

void main() {
  runApp(const SprayingApp());
}

class SprayingApp extends StatelessWidget {
  const SprayingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SprayingDashboard(),
    );
  }
}
