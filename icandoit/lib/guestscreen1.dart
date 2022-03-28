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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorFirebase();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return DataFirebase();
        }
        return const Loading();
      },
    );
    // Challengecontroller variable = Provider.of<Challengecontroller>(context);
    // String switchIntro = variable.getChallengeyesterday().nbChallengeEnCours;
    // return Container(
    //   child: switchIntro == "true" || switchIntro == ""
    //       ? ChangeNotifierProvider.value(value: variable, child: PurchaseApp())
    //       : ChangeNotifierProvider.value(value: variable, child: GuestScreen()),
    // );
  }
}

class ErrorFirebase extends StatelessWidget {
  const ErrorFirebase({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: const Center(
            child: Text('Erreur de chargement des données'),
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: const Center(
            child: Text('Chargement'),
          ),
        ),
      ),
    );
  }
}

class DataFirebase extends StatelessWidget {
  const DataFirebase({Key key}) : super(key: key);

//     String _firebase(BuildContext context){
//     return new StreamBuilder(
//       stream: Firestore
//       .collection()
//       .document()
//       .snapshots()
//       builder: (context,snapshot){
//         if(!snapshot.hasdata){
//           return CircularProgressIndicator();

//         }
//         var userDociment=snapshot.data;
//       }
//   }

// }

  @override
  Widget build(BuildContext context) {
    final databaseReference = FirebaseFirestore.instance;
    void addDataToFirebse() {
      try {
        databaseReference.collection("Activation EASYTODO").add({
          "Achat": true,
          "activation": true,
          "IdCommade": "125436",
          "Installation": true,
          "LastConnect": "20-02-1977",
          "Restor": true
        }).then((value) => print(value.id));
      } catch (e) {
        print(e.toString());
      }
    }

    return Center(child: RaisedButton(onPressed: () {
      addDataToFirebse();
    }));
  }
}
