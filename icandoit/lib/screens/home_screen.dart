import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          title: Text('ICanDoIt'),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      backgroundColor: Color(0xff414a4c),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[900],
        onPressed: () {
          buildBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PersistentBottomSheetController buildBottomSheet() {
    return scaffoldkey.currentState.showBottomSheet((context) {
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Nom du challenge"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Objectif"),
                ),
                DropdownButtonFormField(
                  onChanged: (value) {},
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      value: "KG",
                      child: Text("Kg"),
                    ),
                    DropdownMenuItem(
                      value: "KM",
                      child: Text("Km"),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text("Ajouter le challenge"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
