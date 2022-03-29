import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  intialiseFirebase() async {
    await Firebase.initializeApp();
  }

  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  bool content1 = true;

  // ActiveBool(Challengecontroller variable) async {
  //   await delay(1000);
  //   variable.switchTrueIntro(content1);
  // }

  // getBoolActivation() async {
  //   // String documentId = variable.getChallengeyesterday().nbtacheVallide;

  //   final databaseReference = FirebaseFirestore.instance;

  //   DocumentReference documentRef =
  //       databaseReference.collection("activation").doc("scRiUq3wMUdJfgOB0Zgl");
  //   bool content = (await documentRef.get()).get('activation');

  // }

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

// class CommonService {
//   Future<bool> getBoolActivation() async {
//     // String documentId = variable.getChallengeyesterday().nbtacheVallide;

//     final databaseReference = FirebaseFirestore.instance;

//     DocumentReference documentRef =
//         databaseReference.collection("activation").doc("scRiUq3wMUdJfgOB0Zgl");
//     bool content = (await documentRef.get()).get('activation');

//     return content;
//   }
// }

// class AddFirebase extends StatelessWidget {
//   const AddFirebase({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Challengecontroller variable = Provider.of<Challengecontroller>(context);
//     // String documentId = variable.getChallengeyesterday().nbtacheVallide;
//     final databaseReference = FirebaseFirestore.instance;
//     Future<QuerySnapshot> getDiscussions() {
//       return databaseReference.collection("Activation EASYTODO").get();
//     }

//     return FutureBuilder(
//         future: getDiscussions(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//           for (var p in snapshot.data.docs) {
//             if (p.data() == 'LUOwDqKQ0hRHrWHIUfij') {
//               bool test = p['activation'];
//               print(test);
//             }
//           }
//           print(snapshot.data.docs);
//           // variable.switchTrueIntro(snapshot.data.docs);
//           String switchIntro =
//               variable.getChallengeyesterday().nbChallengeEnCours;
//           return Container(
//             child: switchIntro == "true" || switchIntro == ""
//                 ? ChangeNotifierProvider.value(
//                     value: variable, child: PurchaseApp())
//                 : ChangeNotifierProvider.value(
//                     value: variable, child: GuestScreen()),
//           );
//         });
//   }
// }

// class AddFirebase1 extends StatelessWidget {
//   const AddFirebase1({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Challengecontroller variable = Provider.of<Challengecontroller>(context);
//     // String documentId = variable.getChallengeyesterday().nbtacheVallide;
//     final databaseReference = FirebaseFirestore.instance;

//     databaseReference
//         .collection("activation")
//         .doc("Y6Qt6mARaJmdczcSEoFE")
//         .get()
//         .then((value) {
//       print(value.data());
//     });
//     variable.switchTrueIntro(true);
//     String switchIntro = variable.getChallengeyesterday().nbChallengeEnCours;
//     return Container(
//         child: Container(
//       child: switchIntro == "true" || switchIntro == ""
//           ? ChangeNotifierProvider.value(value: variable, child: PurchaseApp())
//           : ChangeNotifierProvider.value(value: variable, child: GuestScreen()),
//     ));
//   }
// }
