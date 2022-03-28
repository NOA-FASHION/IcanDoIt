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
          return AddFirebase();
        }
        return const Loading();
      },
    );
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

class AddFirebase extends StatelessWidget {
  const AddFirebase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    String ducumentId = variable.getChallengeyesterday().nbtacheVallide;
    final databaseReference = FirebaseFirestore.instance;

    if (ducumentId.isNotEmpty) {
      databaseReference
          .collection("users")
          .doc("SA63wvKbU0zo3jFyqISt")
          .get()
          .then((value) {
        print(value.data());
        variable.switchTrueIntro(value.data()["activation"]);
      });
    }
    String switchIntro = variable.getChallengeyesterday().nbChallengeEnCours;

    return Container(
      child: switchIntro == "true" || switchIntro == ""
          ? ChangeNotifierProvider.value(value: variable, child: PurchaseApp())
          : ChangeNotifierProvider.value(value: variable, child: GuestScreen()),
    );
  }
}
