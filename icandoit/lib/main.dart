import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(ICanDoIt());

class ICanDoIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICanDoIt',
      home: Home(),
    );
  }
}
