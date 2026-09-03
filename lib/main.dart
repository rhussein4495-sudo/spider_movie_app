import 'package:flutter/material.dart';
import 'welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPIDER-MAN: BRAND NEW DAY',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}