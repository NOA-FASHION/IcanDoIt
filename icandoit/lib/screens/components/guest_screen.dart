import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/screens/components/home_screen1.dart';
import 'package:icandoit/screens/home_screen.dart';
import 'package:provider/provider.dart';

class GuestScreen extends StatefulWidget {
  GuestScreen({Key key}) : super(key: key);

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    String switchIntro = variable.getChallengeyesterday().commentaire;
    return Container(
      child: switchIntro == "true" || switchIntro == ""
          ? ChangeNotifierProvider.value(value: variable, child: HomeScreen())
          : ChangeNotifierProvider.value(
              value: variable,
              child: Home(
                id: "",
                idChallenge1: '',
                namechallenge: '',
                returnRaccourci: false,
              )),
    );
  }
}
