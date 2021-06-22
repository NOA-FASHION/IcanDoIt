// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:colour/colour.dart';

import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
// import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/build_challenge_list_tache.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/screens/components/playAllYoutube.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:youtube_parser/youtube_parser.dart';

// import '../../main.dart';
// import '../home_screen.dart';

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
    duree: 'Durée',
    theoriePratique: 'Théorie-pratique',
  );
  bool isSwitched = false;
  String unityPattern = "unity_challenge1.";
  String idChallenge1;
  String nombreEchenace;
  String nomAdresse;
  String villeAdresse;
  String adresse;
  String telephone;
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
        coutPaiment = "0";
        prixProduit = "0";
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
        coutPaiment = "0";
        prixProduit = "0";
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
        coutPaiment = "0";
        prixProduit = "0";
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
        coutPaiment = "0";
        prixProduit = "0";
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

  List<String> listeDeYoutube(List<ChallengeModel> _challengeList) {
    List<String> youtubeList = [];
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == widget.id) {
        for (var n = _challengeList[i].listeDeTache.length - 1; n >= 0; n--) {
          if (_challengeList[i]
                  .listeDeTache[n]
                  .description
                  .toString()
                  .replaceAll(unityPattern, "") ==
              "youtube") {
            youtubeList
                .add(getIdFromUrl(_challengeList[i].listeDeTache[n].name));
          }
        }
      }
    }
    return youtubeList;
  }

  bool idAllPlayYoutubeBool(List<ChallengeModel> _challengeList) {
    bool playYoutube = false;

    for (var n = _challengeList[widget.indexChallenge].listeDeTache.length - 1;
        n >= 0;
        n--) {
      if (_challengeList[widget.indexChallenge]
              .listeDeTache[n]
              .description
              .toString()
              .replaceAll(unityPattern, "") ==
          "youtube") {
        playYoutube = true;
        return playYoutube;
      }
    }
    // print(idCallenge);
    return playYoutube;
  }

  bool idChallengeBool(List<ChallengeModel> _challengeList) {
    bool idCallenge = false;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == widget.id) {
        idCallenge = _challengeList[i].prixTotalBool;
      }
    }
    // print(idCallenge);
    return idCallenge;
  }

  bool idChallengePaimentBool(List<ChallengeModel> _challengeList) {
    bool idCallenge = false;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == widget.id) {
        idCallenge = _challengeList[i].coutTotalBool;
      }
    }
    print(idCallenge);
    return idCallenge;
  }

  void initState() {
    // Challengecontroller variable = Provider.of<Challengecontroller>(context);
    // idChallenge1 = variable.getChallenges()[widget.indexChallenge].id;
    super.initState();
    coutPaiment = "0";
    prixProduit = "0";
    // courBool = false;
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

  void interditecheance2(List<ChallengeModel> _challengeList, dynamic context) {
    if (_challengeList[widget.indexChallenge].listeDeTache.length > 0 &&
        _challengeList[widget.indexChallenge]
                .listeDeTache[0]
                .description
                .toString()
                .replaceAll(unityPattern, "") !=
            "echeancier") {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Colors.blue,
          icon: Icon(
            Icons.delete,
            size: 30,
            color: Colors.white,
          ),
          message:
              "vous ne pouvez pas mélanger un challenge ordinaire avec un challenge échéancier.",
        ),
      );
      retour();
    }
  }

  void interditecheance(List<ChallengeModel> _challengeList, dynamic context) {
    if (_challengeList[widget.indexChallenge].listeDeTache.length > 0 &&
        _challengeList[widget.indexChallenge]
                .listeDeTache[0]
                .description
                .toString()
                .replaceAll(unityPattern, "") ==
            "echeancier") {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Colors.blue,
          icon: Icon(
            Icons.delete,
            size: 30,
            color: Colors.white,
          ),
          message:
              "vous ne pouvez pas mélanger un challenge échéancier avec un challenge ordinaire.",
        ),
      );
      retour();
    }
  }

  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  retour() async {
    await delay(500);
    Navigator.pop(context);
    unityChallenge = "evenement";
  }

  Widget selectdropdown(
      String resultat, List<ChallengeModel> _challengeList, dynamic context) {
    Widget documentJoint = SizedBox(
      width: 1.0,
    );
    if (resultat == "video") {
      interditecheance(_challengeList, context);
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
      interditecheance(_challengeList, context);
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
      interditecheance(_challengeList, context);
      documentJoint = TextFormField(
        onSaved: (value) {
          coutPaiment = "0";
          prixProduit = "0";
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
            labelText: "Url",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      );
    } else if (resultat == "adresse") {
      // interditecheance(_challengeList, context);
      documentJoint = Column(
        children: [
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              coutPaiment = "0";
              prixProduit = "0";
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
              telephone = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Merci d'entrer un numéro de téléphone";
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
                labelText: "Téléphone",
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
                labelText: "Ville",
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
                  "/ " +
                  telephone +
                  "/ " +
                  adresse +
                  "/ " +
                  villeAdresse +
                  "/ " +
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
                labelText: "Pays",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          )
        ],
      );
    } else if (resultat == "youtube") {
      interditecheance(_challengeList, context);
      documentJoint = TextFormField(
        onSaved: (value) {
          coutPaiment = "0";
          prixProduit = "0";
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
            labelText: "Youtube",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      );
    } else if (resultat == "commentaire") {
      interditecheance(_challengeList, context);
      documentJoint = SizedBox(
        width: 200.0,
        height: 300.0,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          maxLines: 30,
          onSaved: (value) {
            coutPaiment = "0";
            prixProduit = "0";
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
              labelText: "Commentaire",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
        ),
      );
    } else if (resultat == "achat") {
      interditecheance(_challengeList, context);
      documentJoint = Row(
        children: [
          Container(
            width: 100,
            child: TextFormField(
              onSaved: (value) {
                coutPaiment = "0";

                prixProduit = value;
              },
              validator: (value) {
                if (!isNumericUsingRegularExpression(value)) {
                  return "Rentrer un prix";
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
                  labelText: "Prix",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ),
          Text("€")
        ],
      );
    } else if (resultat == "paiement") {
      interditecheance(_challengeList, context);
      documentJoint = Row(
        children: [
          Container(
            width: 110,
            child: TextFormField(
              onSaved: (value) {
                prixProduit = "0";
                coutPaiment = value;
              },
              validator: (value) {
                if (!isNumericUsingRegularExpression(value)) {
                  return "Rentrer un montant";
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
                  labelText: "Montant",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ),
          Text("€")
        ],
      );
    } else if (resultat == "echeancier") {
      interditecheance2(_challengeList, context);
      documentJoint = Row(
        children: [
          Column(
            children: [
              Container(
                width: 120,
                child: TextFormField(
                  onSaved: (value) {
                    prixProduit = "0";
                    coutPaiment = value;
                  },
                  validator: (value) {
                    if (!isNumericUsingRegularExpression(value)) {
                      return "Montant d'une échéance";
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
                      labelText: "Échéance",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              Container(
                width: 200,
                child: TextFormField(
                  onSaved: (value) {
                    nombreEchenace = value;
                  },
                  validator: (value) {
                    if (!isNumericUsingRegularExpression(value)) {
                      return "Nombre d'échéance";
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengesListget = variable.getChallenges();

    // if (_challengesListget[widget.indexChallenge].coutTotal > 0) {
    //   courBool = true;
    // }
    return Scaffold(
      key: scaffoldkeyTache,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SafeArea(
          child: AppBar(
            title: Text(something),
            actions: [
              idChallengePaimentBool(_challengesListget)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              variable.activeEcheance(value);
                            });
                          },
                          activeTrackColor: Colors.yellow,
                          activeColor: Colors.orangeAccent,
                        ),
                        Text(
                          "Prélèvement auto",
                          style: TextStyle(fontSize: 6, color: Colors.white),
                        ),
                      ],
                    )
                  : SizedBox(width: 10),
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
                              "partage",
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
              idAllPlayYoutubeBool(_challengesListget)
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: 15, left: 15, top: 10),
                      child: SizedBox.fromSize(
                        size: Size(50, 50), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.purple, // button color
                            child: InkWell(
                              // splash color
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlayAllYoutubeScreen(
                                          variable.listeDeYoutube(
                                              widget.indexChallenge),
                                          widget.indexChallenge,
                                        )));
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.playlist_play,
                                    size: 20,
                                    color: Colors.white,
                                  ), // icon
                                  Text(
                                    "Play",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(width: 10),
            ],
            backgroundColor: Colors.blue,
            centerTitle: true,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 40.0, right: 30.0),
              alignment: Alignment.center,
              height: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  idChallengePaimentBool(_challengesListget)
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
                                          "Total paiement",
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
                                          "Reste à payer",
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
                  idChallengePaimentBool(_challengesListget)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 5, left: 5, top: 10),
                              child: SizedBox.fromSize(
                                size: Size(30, 30), // button width and height
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.blue, // button color
                                    child: InkWell(
                                      // splash color
                                      splashColor: Colors.white,
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayAllYoutubeScreen(
                                                      variable.listeDeYoutube(
                                                          widget
                                                              .indexChallenge),
                                                      widget.indexChallenge,
                                                    )));
                                      }, // button pressed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            size: 10,
                                            color: Colors.white,
                                          ), // icon
                                          Text(
                                            "Ajout",
                                            style: TextStyle(
                                                fontSize: 7,
                                                color: Colors.white),
                                          ), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 5, left: 5, top: 10),
                              child: SizedBox.fromSize(
                                size: Size(30, 30), // button width and height
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.blue, // button color
                                    child: InkWell(
                                      // splash color
                                      splashColor: Colors.white,
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayAllYoutubeScreen(
                                                      variable.listeDeYoutube(
                                                          widget
                                                              .indexChallenge),
                                                      widget.indexChallenge,
                                                    )));
                                      }, // button pressed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.remove,
                                            size: 10,
                                            color: Colors.white,
                                          ), // icon
                                          Text(
                                            "retrait",
                                            style: TextStyle(
                                                fontSize: 7,
                                                color: Colors.white),
                                          ), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(width: 10),
                  idChallengeBool(_challengesListget)
                      // _challengesListget[widget.indexChallenge].prixTotalBool
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
                                          "Prévisions",
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
                                          "Prix total",
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
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengesListget = variable.getChallenges();
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
                                    // borderSide: BorderSide(
                                    //     width: 2.0, color: Colors.blueAccent),
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
                                    Text("Évènement"),
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
                                    Text("Achat"),
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
                                    Text("Tâche"),
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
                                    Text("Mission"),
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
                                    Text("Projet"),
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
                                    Text("Adresse"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "information",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.perm_device_information,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Information"),
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
                                    Text("Paiement"),
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
                                    Text("Échéancier"),
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
                                    Text("Formation"),
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
                                    Text("Youtube"),
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
                                    Text("Commentaire"),
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
                                    Text("Vidéo"),
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
                                    Text("Image"),
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
                                    Text("Url"),
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
                                return "Pas plus de 50 caractères";
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
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          selectdropdown(
                              unityChallenge, _challengesListget, context),
                          InkWell(
                              onTap: () {
                                if (unityChallenge == "echeancier") {
                                  if (formKeyTache.currentState.validate()) {
                                    formKeyTache.currentState.save();
                                    Provider.of<Challengecontroller>(context,
                                            listen: false)
                                        .generateList(
                                      widget.animatedpadding,
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
