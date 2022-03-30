import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'screens/components/guest_screen.dart';
import 'screens/components/purchase_app.dart';

class GuestScreenStart1 extends StatefulWidget {
  GuestScreenStart1({Key key}) : super(key: key);

  @override
  _GuestScreenStart1State createState() => _GuestScreenStart1State();
}

class _GuestScreenStart1State extends State<GuestScreenStart1> {
  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  String test;
  modifDtabaseFirebase() async {
    await delay(1500);
    DateTime today = new DateTime.now();
    final databaseReference = FirebaseFirestore.instance;
    try {
      databaseReference.collection("activation").doc(test).update({
        "LastConnect": DateFormat('EEEE, d MMM, yyyy').format(today),
        // "LastConnect": "date test7",
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void getBoolActivation(Challengecontroller variable) async {
    await delay(1500);

    final databaseReference = FirebaseFirestore.instance;
    databaseReference.collection("activation").doc(test).get().then((value) {
      print(value.data()['activation']);
    });
  }

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    test = variable.getChallengeyesterday().nbtacheVallide;
    modifDtabaseFirebase();
    getBoolActivation(variable);
    String switchIntro1 = variable.getChallengeyesterday().nbchallengeVallide;

    String switchIntro = variable.getChallengeyesterday().nbChallengeEnCours;
    print(switchIntro);
    return Container(
        child: Container(
      child: switchIntro == "true" && switchIntro1 == "true"
          ? ChangeNotifierProvider.value(value: variable, child: PurchaseApp())
          : ChangeNotifierProvider.value(value: variable, child: GuestScreen()),
    ));
  }
}
