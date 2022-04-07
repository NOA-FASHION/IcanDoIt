import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/guestScreenStart.dart';

import 'package:icandoit/screens/components/challenge_list_save.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(IcanDoIt());
}

class IcanDoIt extends StatefulWidget {
  IcanDoIt({Key key}) : super(key: key);

  @override
  _IcanDoItState createState() => _IcanDoItState();
}

class _IcanDoItState extends State<IcanDoIt> {
  @override
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'ICanDoIt',
      routes: {
        '/list_save': (context) => ExampleApp(),
        '/settings': (context) => ExampleApp()
      },
      home: ChangeNotifierProvider<Challengecontroller>(
          create: (context) => Challengecontroller(),
          child: GuestScreenStart1()),
    );
  }
}
