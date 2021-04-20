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
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeTaches extends StatefulWidget {
  final String something;
  final bool animatedpadding;

  HomeTaches(this.something, this.animatedpadding);
  @override
  _HomeTachesState createState() =>
      _HomeTachesState(something, animatedpadding);
}

class _HomeTachesState extends State<HomeTaches> {
  Formation formations = Formation(
    chapitre: 'Chapitre',
    duree: 'Duree',
    theoriePratique: 'Theorie-pratique',
  );
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

  final bool animatedpadding;
  final String something;
  String dataJoin;
  _HomeTachesState(this.something, this.animatedpadding);
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
    }
    return documentJoint;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkeyTache,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SafeArea(
          child: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
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
                              .writeContent(nameChallenge: something);
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
              padding: EdgeInsets.only(right: 30.0),
              alignment: Alignment.center,
              height: 100,
              child: Image.asset(
                'assets/logo.png',
                width: 60,
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
                                if (formKeyTache.currentState.validate()) {
                                  formKeyTache.currentState.save();
                                  setState(() {
                                    Provider.of<Challengecontroller>(context,
                                            listen: false)
                                        .addChallenge2(
                                            animatedpadding: animatedpadding,
                                            totalChallenge: '1',
                                            nameListChallenge: something,
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
