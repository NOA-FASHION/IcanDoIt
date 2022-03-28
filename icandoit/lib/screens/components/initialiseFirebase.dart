import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class InitializeApp extends StatelessWidget {
  const InitializeApp({Key key}) : super(key: key);
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
