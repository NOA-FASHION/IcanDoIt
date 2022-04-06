import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    variable.demarageSwitchIntro();
    test = variable.getChallengeyesterday().nbtacheVallide;
    modifDtabaseFirebase();
    bool activationManuel = variable.getActivationmanuelle();
    String switchIntro1 = variable.getChallengeyesterday().nbchallengeVallide;
    return Container(
      child: (switchIntro1 == "false" && activationManuel == false) ||
              (switchIntro1 == "true" && activationManuel == true)
          ? ChangeNotifierProvider.value(value: variable, child: PurchaseApp())
          : ChangeNotifierProvider.value(value: variable, child: GuestScreen()),
    );

    // String switchIntro = variable.getChallengeyesterday().nbChallengeEnCours;

    // print(switchIntro);
    // return FutureBuilder<bool>(
    //     future: switIntro(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return CircularProgressIndicator();
    //       } else {
    //         // return (Container(child: Text(snapshot.data.toString())));
    //         return Container(
    //           child: (switchIntro1 == "false" && snapshot.data == false) ||
    //                   (switchIntro1 == "true" && snapshot.data == true)
    //               ? ChangeNotifierProvider.value(
    //                   value: variable, child: PurchaseApp())
    //               : ChangeNotifierProvider.value(
    //                   value: variable, child: GuestScreen()),
    //         );
    //       }
    //     });
  }
}
