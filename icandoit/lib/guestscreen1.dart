import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/screens/components/home_screen1.dart';
import 'package:icandoit/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'screens/components/purchase_app.dart';

class GuestScreenStart extends StatefulWidget {
  GuestScreenStart({Key key}) : super(key: key);

  @override
  _GuestScreenStartState createState() => _GuestScreenStartState();
}

class _GuestScreenStartState extends State<GuestScreenStart> {
  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    String switchIntro = variable.getChallengeyesterday().nbChallengeEnCours;
    return Container(
      child: switchIntro == "true" || switchIntro == ""
          ? ChangeNotifierProvider.value(value: variable, child: PurchaseApp())
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
