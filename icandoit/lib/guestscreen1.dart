
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';

import 'package:provider/provider.dart';

import 'screens/components/guest_screen.dart';
import 'screens/components/purchase_app.dart';

class GuestScreenStart extends StatefulWidget {
  GuestScreenStart({Key key}) : super(key: key);

  @override
  _GuestScreenStartState createState() => _GuestScreenStartState();
}

class _GuestScreenStartState extends State<GuestScreenStart> {
  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  bool content1 = true;

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);

    // getBoolActivation();
    String switchIntro1 = variable.getChallengeyesterday().nbchallengeVallide;

    String switchIntro = variable.getChallengeyesterday().nbChallengeEnCours;
    return Container(
        child: Container(
      child: switchIntro == "true" && switchIntro1 == "true"
          ? ChangeNotifierProvider.value(value: variable, child: PurchaseApp())
          : ChangeNotifierProvider.value(value: variable, child: GuestScreen()),
    ));
  }
}
 