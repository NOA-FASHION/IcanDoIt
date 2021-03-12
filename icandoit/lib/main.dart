import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(ICanDoIt());

class ICanDoIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICanDoIt',
      home: ChangeNotifierProvider<Challengecontroller>(
          create: (context) => Challengecontroller(), child: Home()),
    );
  }
}
