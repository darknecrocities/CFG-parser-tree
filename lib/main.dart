// main.dart
import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const CFGApp());
}

class CFGApp extends StatelessWidget {
  const CFGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CFG Parser Tree',
      home: CFGHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
