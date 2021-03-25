import 'package:colour/colour.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/build_challenge_list.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
// import 'package:slide_drawer/slide_drawer.dart';

import 'components/challenge_list_save.dart';
import 'components/resultat_challenge.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  String unityChallenge = "haute";
  String nameChallenge;
  String targetChallenge;
  List<Challengemodel2> challengeListTache = [];
  String totalChallenge = "0";
  FancyDrawerController _controller;
  void initState() {
    super.initState();
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.blue,
        controller: _controller,
        drawerItems: <Widget>[
          InkWell(
            onTap: () {
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: Home())));
              setState(() {});
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Go to home",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: ExampleApp())));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.save_rounded),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Sauvegare challenge",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: ResultaChallenge())));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.save_rounded),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "score des challenges",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //         value: variable, child: ExampleApp())));
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.support),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Support us",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //         value: variable, child: Home())));
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.policy),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "About us",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        child: Scaffold(
          key: scaffoldkey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: SafeArea(
              child: AppBar(
                leading: IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _controller.toggle();
                  },
                ),
                centerTitle: true,
                flexibleSpace: Container(
                  padding: EdgeInsets.only(right: 30.0),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 60,
                      ),
                      InkWell(
                        onTap: () {
                          variable.uploadChallenge();
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          elevation: 35.0,
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colour('#265FBC'),
                              shape: CircleBorder(),
                            ),
                            child: Icon(
                              Icons.upload_sharp,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[Colors.purple, Colors.blue])),
                ),
              ),
            ),
          ),
          body: Shimmer(
            duration: Duration(seconds: 3),
            interval: Duration(seconds: 5),
            color: Colors.white,
            enabled: true,
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.purple, Colors.blue])),
              child: ChallengesListBuilder(),
            ),
          ),
          // backgroundColor: Color(0xff414a4c),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: buildBottomSheet(),
        ),
      ),
    );
  }

  updateController(dynamic value) {
    _bottomSheetController.setState(() {
      unityChallenge = value;
    });
  }

  FloatingActionButton buildBottomSheet() {
    return FloatingActionButton(
        child: Lottie.asset('assets/float.json'),
        onPressed: () {
          _bottomSheetController = scaffoldkey.currentState.showBottomSheet(
            (context) {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              nameChallenge = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Merci d'entrer un nom pour le challenge";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                labelText: "Nom de la mission",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              targetChallenge = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Merci d'entrer une description pour la mission";
                              } else if (value.length > 35) {
                                return "pas plus de 50 caracteres";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Description",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                            value: unityChallenge,
                            onChanged: (value) {
                              updateController(value);
                            },
                            onSaved: (value) {
                              updateController(value);
                            },
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: "haute",
                                child: Text("haute"),
                              ),
                              DropdownMenuItem(
                                value: "normal",
                                child: Text("normal"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          InkWell(
                              onTap: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  Provider.of<Challengecontroller>(context,
                                          listen: false)
                                      .addChallenge(
                                          name: nameChallenge,
                                          totalChallenge: totalChallenge,
                                          description: targetChallenge,
                                          unity: unityChallenge,
                                          challengeListTache:
                                              challengeListTache);

                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                  width: 200.0,
                                  height: 200.0,
                                  child: Lottie.asset('assets/save1.json'))),
                        ],
                      ),
                    ),
                  ));
            },
          );
        });
  }
}
