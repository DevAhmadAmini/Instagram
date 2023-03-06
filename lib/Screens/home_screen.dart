import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String id = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
    );
  }
}
