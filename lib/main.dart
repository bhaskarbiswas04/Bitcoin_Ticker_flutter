import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(color: Colors.lightBlue[700]),
        scaffoldBackgroundColor: Colors.lightBlue,
      ),
      home: const priceScreen(),
    );
  }
}
