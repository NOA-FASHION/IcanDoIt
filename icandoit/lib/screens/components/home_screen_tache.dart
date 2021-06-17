// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:colour/colour.dart';

import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
// import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/build_challenge_list_tache.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../main.dart';
import '../home_screen.dart';

class HomeTaches extends StatefulWidget {
  final String id;
  final String something;
  final bool animatedpadding;
  final int indexChallenge;

  HomeTaches(
      this.id, this.indexChallenge, this.something, this.animatedpadding);
  @override
  _HomeTachesState createState() =>
      _HomeTachesState(indexChallenge, something, animatedpadding);
}

class _HomeTachesState extends State<HomeTaches> {
  Formation formations = Formation(
    chapitre: 'Chapitre',
    duree: 'Duree',
    theoriePratique: 'Theorie-pratique',
  );
  String nombreEchenace;
  String nomAdresse;
  String villeAdresse;
  String adresse;
  String paysAdresse;
  String prixProduit;
  String coutPaiment;
  List<String> docPaths;
  String _image;
  String _video;
  String wait = "assets/wait.json";
  final picker = ImagePicker();
  bool _visibility1 = true;

  Future getImageCamera() async {
    _bottomSheetController.setState(() {
      _changeVisibility(false);
    });
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        dataJoin = pickedFile.path;
        _image = pickedFile.path;
        _bottomSheetController.setState(() {
          wait = "assets/picture.json";
        });
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    _bottomSheetController.setState(() {
      _changeVisibility(false);
    });
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        dataJoin = pickedFile.path;
        _image = pickedFile.path;
        _bottomSheetController.setState(() {
          wait = "assets/picture.json";
        });
      } else {
        print('No image selected.');
      }
    });
  }

  Future getVideoCamera() async {
    _bottomSheetController.setState(() {
      _changeVisibility(false);
    });
    final pickedFile = await picker.getVideo(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        dataJoin = pickedFile.path;
        _video = pickedFile.path;
        _bottomSheetController.setState(() {
          wait = "assets/video.json";
        });
      } else {
        print('No image selected.');
      }
    });
  }

  Future getVideoGallery() async {
    _bottomSheetController.setState(() {
      _changeVisibility(false);
    });
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        dataJoin = pickedFile.path;
        _video = pickedFile.path;
        _bottomSheetController.setState(() {
          wait = "assets/video.json";
        });
      } else {
        print('No image selected.');
      }
    });
  }

  void _changeVisibility(bool visibility) {
    setState(() {
      _visibility1 = visibility;
    });
  }

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  void initState() {
    super.initState();
    coutPaiment = "0";
    prixProduit = "0";
    courBool = false;
    paimentBool = false;
  }

  var courBool;
  var paimentBool;
  final bool animatedpadding;
  final String something;
  final int indexChallenge;
  String dataJoin;
  _HomeTachesState(this.indexChallenge, this.something, this.animatedpadding);
  final GlobalKey<ScaffoldState> scaffoldkeyTache = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKeyTache = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  String unityChallenge = "evenement";
  String targetChallenge;
  String totalChallengeEnCours;
  int totaChallengeEnCours1 = 0;
  double percentok = 0;
  String percentokString = "0";
  double percentage(String percent) {
    var percent1;

    percent1 = (double.parse(percent) / 100);
    return percent1;
  }

  Widget selectdropdown(String resultat) {
    Widget documentJoint = SizedBox(
      width: 1.0,
    );
    if (resultat == "video") {
      // _visibility1 = true;
      // wait = "assets/wait.json";
      documentJoint = Column(
        children: [
          Offstage(
            offstage: _visibility1,
            child: Container(
              height: 100,
              width: 100,
              child: Center(child: Lottie.asset(wait)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    getVideoGallery();
                    // _playVideo(_video);
                  },
                  child: Container(
                      width: 120.0,
                      height: 120.0,
                      child: Lottie.asset('assets/upload.json'))),
              SizedBox(
                width: 15.0,
              ),
              InkWell(
                  onTap: () async {
                    getVideoCamera();
                    // _playVideo(_video);
                  },
                  child: Container(
                      width: 120.0,
                      height: 120.0,
                      child: Lottie.asset('assets/cam.json'))),
            ],
          ),
        ],
      );
    } else if (resultat == "image") {
      // _visibility1 = true;
      // wait = "assets/wait.json";
      documentJoint = Column(
        children: [
          Offstage(
            offstage: _visibility1,
            child: Container(
              height: 100,
              width: 100,
              child: Center(child: Lottie.asset(wait)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    getImageGallery();
                  },
                  child: Container(
                      width: 120.0,
                      height: 120.0,
                      child: Lottie.asset('assets/upload.json'))),
              SizedBox(
                width: 15.0,
              ),
              InkWell(
                  onTap: () async {
                    getImageCamera();
                  },
                  child: Container(
                      width: 120.0,
                      height: 120.0,
                      child: Lottie.asset('assets/photo.json'))),
            ],
          ),
        ],
      );
    } else if (resultat == "url") {
      documentJoint = TextFormField(
        onSaved: (value) {
          dataJoin = value;
        },
        validator: (value) {
          if (value.isEmpty) {
            return "Merci d'entrer l'url";
          }
          return null;
        },
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(15.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(15.0)),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            labelText: "url",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      );
    } else if (resultat == "adresse") {
      documentJoint = Column(
        children: [
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              nomAdresse = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Merci d'entrer un nom";
              }
              return null;
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: "Nom",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          ),
          SizedBox(
            height: 7.0,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              adresse = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Merci d'entrer une adresse";
              }
              return null;
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: "Adresse",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          ),
          SizedBox(
            height: 7.0,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              villeAdresse = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Merci d'entrer une ville";
              }
              return null;
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: "ville",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          ),
          SizedBox(
            height: 7.0,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              paysAdresse = value;
              dataJoin = nomAdresse +
                  ", " +
                  adresse +
                  ", " +
                  villeAdresse +
                  ", " +
                  paysAdresse;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Merci d'entrer un pays";
              }
              return null;
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: "pays",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          )
        ],
      );
    } else if (resultat == "youtube") {
      documentJoint = TextFormField(
        onSaved: (value) {
          dataJoin = value;
        },
        validator: (value) {
          if (value.isEmpty) {
            return "Merci d'entrer l'url";
          }
          return null;
        },
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(15.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(15.0)),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            labelText: "youtube",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      );
    } else if (resultat == "commentaire") {
      documentJoint = SizedBox(
        width: 200.0,
        height: 300.0,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          maxLines: 30,
          onSaved: (value) {
            dataJoin = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return "Merci de laisser un commentaire";
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(15.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(15.0)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              labelText: "commentaire",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
        ),
      );
    } else if (resultat == "achat") {
      documentJoint = Row(
        children: [
          Container(
            width: 100,
            child: TextFormField(
              onSaved: (value) {
                prixProduit = value;
              },
              validator: (value) {
                if (!isNumericUsingRegularExpression(value)) {
                  return "rentrer un prix";
                }
                return null;
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  labelText: "achat",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ),
          Text("€")
        ],
      );
    } else if (resultat == "paiement") {
      documentJoint = Row(
        children: [
          Container(
            width: 100,
            child: TextFormField(
              onSaved: (value) {
                coutPaiment = value;
              },
              validator: (value) {
                if (!isNumericUsingRegularExpression(value)) {
                  return "rentrer un montant";
                }
                return null;
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  labelText: "paiment",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ),
          Text("€")
        ],
      );
    } else if (resultat == "echeancier") {
      documentJoint = Row(
        children: [
          Column(
            children: [
              Container(
                width: 100,
                child: TextFormField(
                  onSaved: (value) {
                    coutPaiment = value;
                  },
                  validator: (value) {
                    if (!isNumericUsingRegularExpression(value)) {
                      return "montant d'une échéance";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(15.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(15.0)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: "echeance",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              Container(
                width: 100,
                child: TextFormField(
                  onSaved: (value) {
                    nombreEchenace = value;
                  },
                  validator: (value) {
                    if (!isNumericUsingRegularExpression(value)) {
                      return "nombre d'échéance";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(15.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(15.0)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: "Nombre d'échéance",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
            ],
          ),
          Text("€")
        ],
      );
    }
    return documentJoint;
  }

  @override
  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengesListget = variable.getChallenges();

    if (_challengesListget[widget.indexChallenge].coutTotal > 0) {
      courBool = true;
    }
    return Scaffold(
      key: scaffoldkeyTache,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SafeArea(
          child: AppBar(
            title: Text(something),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                child: SizedBox.fromSize(
                  size: Size(50, 50), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.purple, // button color
                      child: InkWell(
                        // splash color
                        splashColor: Colors.white,
                        onTap: () {
                          Provider.of<Challengecontroller>(context,
                                  listen: false)
                              .writeContent(id: widget.id);
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.share_rounded,
                              size: 20,
                              color: Colors.white,
                            ), // icon
                            Text(
                              "Share",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.blue,
            centerTitle: true,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 40.0, right: 30.0),
              alignment: Alignment.center,
              height: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _challengesListget[widget.indexChallenge].prixTotalBool
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 25.0,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.only(right: 7),
                                    child: Column(
                                      children: [
                                        Text(
                                          _challengesListget[
                                                      widget.indexChallenge]
                                                  .previsions
                                                  .toStringAsFixed(2) +
                                              "€",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "previsions",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text(
                                          _challengesListget[
                                                      widget.indexChallenge]
                                                  .prixTotal
                                                  .toStringAsFixed(2) +
                                              "€",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "prix total",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ), // icon
                            // text
                          ],
                        )
                      : SizedBox(width: 10),
                  Image.asset(
                    'assets/logo.png',
                    width: 55,
                  ),
                  _challengesListget[widget.indexChallenge].coutTotalBool
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 25.0,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.only(right: 7),
                                    child: Column(
                                      children: [
                                        Text(
                                          _challengesListget[indexChallenge]
                                                  .coutTotal
                                                  .toStringAsFixed(2) +
                                              "€",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Total paiment",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text(
                                          _challengesListget[indexChallenge]
                                                  .restePaiement
                                                  .toStringAsFixed(2) +
                                              "€",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "reste a payer",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ), // icon
                            // text
                          ],
                        )
                      : SizedBox(width: 10),
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
          child: ChallengesListBuilderTaches(
            id: widget.id,
            indexChallenge: indexChallenge,
            nameChallenge: something,
          ),
        ),
      ),
      backgroundColor: Color(0xff414a4c),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildBottomSheet(),
    );
  }

  updateController(dynamic value) {
    _bottomSheetController.setState(() {
      unityChallenge = value;
    });
  }

  FloatingActionButton buildBottomSheet() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[900],
        onPressed: () {
          _image = "";
          _bottomSheetController =
              scaffoldkeyTache.currentState.showBottomSheet(
            (context) {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Form(
                    key: formKeyTache,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        children: [
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
                              _visibility1 = true;
                              wait = "assets/wait.json";
                            },
                            onSaved: (value) {
                              updateController(value);
                            },
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: "evenement",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.event,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("evenement"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "achat",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("achat"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "tache",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.event_available,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("tache"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "mission",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.assignment,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("mission"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "projet",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.build,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("projet"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "adresse",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.living,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("adresse"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "informations",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.perm_device_information,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("informations"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "paiement",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("paiement"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "echeancier",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("echeancier"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "formation",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.model_training,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("formation"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "youtube",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.youtube_searched_for_outlined,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("youtube"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "commentaire",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("commentaire"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "video",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.video_label,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("video"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "image",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.text_fields,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("image"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "url",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cloud,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("url"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                labelText: "Description",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          selectdropdown(unityChallenge),
                          InkWell(
                              onTap: () {
                                if (unityChallenge == "echeancier") {
                                  if (formKeyTache.currentState.validate()) {
                                    formKeyTache.currentState.save();
                                    Provider.of<Challengecontroller>(context,
                                            listen: false)
                                        .generateList(
                                      widget.id,
                                      widget.indexChallenge,
                                      int.parse(nombreEchenace),
                                      double.parse(coutPaiment),
                                      unityChallenge,
                                      targetChallenge,
                                      formations,
                                      double.parse(prixProduit),
                                    );
                                    Navigator.pop(context);
                                  }
                                } else if (formKeyTache.currentState
                                    .validate()) {
                                  formKeyTache.currentState.save();
                                  setState(() {
                                    Provider.of<Challengecontroller>(context,
                                            listen: false)
                                        .addChallenge2(
                                            prix: double.parse(prixProduit),
                                            cout: double.parse(coutPaiment),
                                            id: nanoid(10),
                                            index: widget.indexChallenge,
                                            animatedpadding: animatedpadding,
                                            totalChallenge: '1',
                                            idListChallenge: widget.id,
                                            name: dataJoin,
                                            description: unityChallenge,
                                            tache: targetChallenge,
                                            formation: formations);
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                  width: 120.0,
                                  height: 120.0,
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
