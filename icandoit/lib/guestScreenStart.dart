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

  bool test1;
  String test = '';
  modifDtabaseFirebase() async {
    await delay(1500);
    if (test != null && test.isNotEmpty) {
      DateTime today = new DateTime.now();

      try {
        final databaseReference = FirebaseFirestore.instance;
        // var a =
        //     await databaseReference.collection("activation").doc(test).get();
        // if (a.exists) {
        databaseReference.collection("activation").doc(test).update({
          "LastConnect": DateFormat('EEEE, d MMM, yyyy').format(today),
          // "LastConnect": "date test7",
        });
        // }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<bool> getBoolActivation(Challengecontroller variable) async {
    await delay(2500);

    if (test != null && test.isNotEmpty) {
      final databaseReference = FirebaseFirestore.instance;
      // var a = await databaseReference.collection("activation").doc(test).get();
      // if (a.exists) {
      databaseReference.collection("activation").doc(test).get().then((value) {
        print(value.data()['activation']);
        test1 = value.data()['activation'];
      });
    }
    // }
    return test1;
    // switIntro(variable);
  }

  void switIntro(Challengecontroller variable) async {
    if (test1 != null) {
      await delay(3500);
      variable.switchTrueIntro(test1);
    }
  }

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    test = variable.getChallengeyesterday().nbtacheVallide;
    modifDtabaseFirebase();
    getBoolActivation(variable).then((value) => switIntro(variable));
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
