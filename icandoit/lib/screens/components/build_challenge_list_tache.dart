import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:icandoit/screens/components/adresse.dart';
// import 'dart:io' as io;
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/achatEdit.dart';
import 'package:icandoit/screens/components/paiementEdit.dart';
import 'package:icandoit/screens/components/playYoutube.dart';
import 'package:icandoit/screens/formationEdit.dart';
import 'package:icandoit/screens/playPicture.dart';
import 'package:icandoit/screens/playUrl.dart';
import 'package:icandoit/screens/playVideo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import '../../controllers/challenge_controller.dart';
import '../home_screen.dart';
import '../playCommentaire.dart';
import 'package:marquee_text/marquee_text.dart';

class ChallengesListBuilderTaches extends StatefulWidget {
  final String id;
  final String nameChallenge;
  final int indexChallenge;

  ChallengesListBuilderTaches(
      {@required this.id,
      @required this.indexChallenge,
      @required this.nameChallenge});
  @override
  _ChallengesListBuilderTachesState createState() =>
      _ChallengesListBuilderTachesState();
}

class _ChallengesListBuilderTachesState
    extends State<ChallengesListBuilderTaches> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController textEditingControllerAnimated =
      new TextEditingController();
  final picker = ImagePicker();
  bool formation = false;
  String chapitre;

  String modifDescription(String description) {
    String modifDecription1 = "Évènement";

    if (description == "achat") {
      modifDecription1 = "Achat";
    } else if (description == "tache") {
      modifDecription1 = "Tâche";
    } else if (description == "mission") {
      modifDecription1 = "Mission";
    } else if (description == "youtube") {
      modifDecription1 = "Youtube";
    } else if (description == "video") {
      modifDecription1 = "Vidéo";
    } else if (description == "commentaire") {
      modifDecription1 = "Commentaire";
    } else if (description == "image") {
      modifDecription1 = "Image";
    } else if (description == "url") {
      modifDecription1 = "Url";
    } else if (description == "paiement") {
      modifDecription1 = "Paiement";
    } else if (description == "echeancier") {
      modifDecription1 = "Échéancier";
    } else if (description == "projet") {
      modifDecription1 = "Projet";
    } else if (description == "adresse") {
      modifDecription1 = "Adresse";
    } else if (description == "formation") {
      modifDecription1 = "Formation";
    }

    return modifDecription1;
  }

  Color colorsDescription(String description) {
    Color colors = Colors.black;
    if (description == "evenement") {
      colors = Colors.blue;
    } else if (description == "achat") {
      colors = Colors.cyan;
    } else if (description == "tache") {
      colors = Colors.orange;
    } else if (description == "mission") {
      colors = Colors.amber;
    } else if (description == "youtube") {
      colors = Colors.red;
    } else if (description == "video") {
      colors = Colors.lime;
    } else if (description == "commentaire") {
      colors = Colors.blueGrey;
    } else if (description == "image") {
      colors = Colors.pink;
    } else if (description == "url") {
      colors = Colors.teal;
    } else if (description == "paiement") {
      colors = Colors.yellow;
    } else if (description == "echeancier") {
      colors = Colors.grey;
    } else if (description == "projet") {
      colors = Colors.indigo;
    } else if (description == "adresse") {
      colors = Colors.lime;
    } else if (description == "formation") {
      colors = Colors.green;
    }
    return colors;
  }

  Widget maxLetter(String word, String comment) {
    Widget longLetter;
    String word2;

    if (word.length > 29 && comment.length <= 5) {
      longLetter = Container(
        width: MediaQuery.of(context).size.width / 2.55,
        color: Colors.transparent,
        child: MarqueeText(
          text: word,
          style: TextStyle(
            color: Colors.black,
          ),
          speed: 30,
        ),
      );
    } else if (word.length > 20 && comment.length > 5) {
      longLetter = Container(
        width: MediaQuery.of(context).size.width / 2.55,
        color: Colors.transparent,
        child: MarqueeText(
          text: word,
          style: TextStyle(
            color: Colors.black,
          ),
          speed: 30,
        ),
      );
    } else {
      word2 = word;
      longLetter = Text(word2);
    }
    return longLetter;
  }

  Widget formationEdit(
      Challengecontroller provider, Challengemodel2 item, String description) {
    Widget fomationEdit = SizedBox(
      width: 5.0,
    );
    if (description == "formation") {
      fomationEdit = IconButton(
        alignment: Alignment.topRight,
        icon: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: provider,
                  child: FormationEdit(
                      item: item, indexChallenge: widget.indexChallenge))));
        },
      );
    } else if (description == "paiement" || description == "echeancier") {
      fomationEdit = IconButton(
        alignment: Alignment.topRight,
        icon: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: provider,
                  child: PaiementEdit(
                      item: item, indexChallenge: widget.indexChallenge))));
        },
      );
    } else if (description == "achat") {
      fomationEdit = IconButton(
        alignment: Alignment.topRight,
        icon: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: provider,
                  child: AchatEdit(
                      item: item, indexChallenge: widget.indexChallenge))));
        },
      );
    }
    return fomationEdit;
  }

  Widget prixCout(double prix, double cout) {
    Widget prixCout1 = SizedBox(
      width: 5.0,
    );
    if (prix > 0) {
      prixCout1 = Text("Prix : " + prix.toString() + "€");
    } else if (cout > 0) {
      prixCout1 = Text("Montant : " + cout.toString() + "€");
    }
    return prixCout1;
  }

  Widget iconDataJoin(String resultat) {
    Widget documentJoint = Icon(
      Icons.block,
      size: 30.0,
    );
    if (resultat == "video") {
      documentJoint = Icon(
        Icons.video_call,
        size: 30.0,
      );
    } else if (resultat == "image") {
      documentJoint = Icon(
        Icons.photo_size_select_large,
        size: 30.0,
      );
    } else if (resultat == "url") {
      documentJoint = Icon(
        Icons.cloud,
        size: 30.0,
      );
    } else if (resultat == "commentaire") {
      documentJoint = Icon(
        Icons.comment,
        size: 30.0,
      );
    } else if (resultat == "information") {
      documentJoint = Icon(
        Icons.perm_device_information,
        size: 30.0,
      );
    } else if (resultat == "youtube") {
      documentJoint = Icon(
        Icons.youtube_searched_for_sharp,
        size: 30.0,
      );
    } else if (resultat == "evenement") {
      documentJoint = Icon(
        Icons.event,
        size: 30.0,
      );
    } else if (resultat == "achat") {
      documentJoint = Icon(
        Icons.shopping_cart,
        size: 30.0,
      );
    } else if (resultat == "tache") {
      documentJoint = Icon(
        Icons.event_available,
        size: 30.0,
      );
    } else if (resultat == "formation") {
      formation = true;
      documentJoint = Icon(
        Icons.model_training,
        size: 30.0,
      );
    } else if (resultat == "paiement" || resultat == "echeancier") {
      documentJoint = Icon(
        Icons.payment,
        size: 30.0,
      );
    } else if (resultat == "projet") {
      documentJoint = Icon(
        Icons.build,
        size: 30.0,
      );
    } else if (resultat == "adresse") {
      documentJoint = Icon(
        Icons.living,
        size: 30.0,
      );
    } else if (resultat == "mission") {
      documentJoint = Icon(
        Icons.assignment,
        size: 30.0,
      );
    }

    return documentJoint;
  }

  void dispose() {
    textEditingControllerAnimated.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  List<ChallengeModel> challengeListCharge;

  String unityPattern = "unity_challenge1.";

  @override
  Widget build(BuildContext context) {
    Challengecontroller providerType =
        Provider.of<Challengecontroller>(context);
    List<Challengemodel2> _challengesList =
        providerType.challengelist2(widget.id);

    final Challengecontroller provider =
        Provider.of<Challengecontroller>(context);
    if (_challengesList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "Pas de mission en cours.",
          style: TextStyle(color: Colors.orange[600], fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      );
    }
    return new DragAndDropList<Challengemodel2>(
      _challengesList,
      itemBuilder: (BuildContext context, item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3.0, left: 8.0, right: 8.0),
          child: Dismissible(
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                provider.addnbtacheVallide();
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "La tâche a bien été validé",
                    lotties: 'assets/challenge.json'));
                provider.remove2(
                    unitChallenge: item.description
                        .toString()
                        .replaceAll(unityPattern, ""),
                    cout: item.cout,
                    prix: item.prix,
                    id: item.id,
                    indexSave: widget.indexChallenge,
                    validate: true,
                    index: int.parse(item.index),
                    idChallenge: widget.id);
              }

              if (direction == DismissDirection.startToEnd) {
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "La mission a bien ete supprime",
                    lotties: 'assets/trash.json'));
                provider.remove2(
                    unitChallenge: item.description
                        .toString()
                        .replaceAll(unityPattern, ""),
                    cout: item.cout,
                    prix: item.prix,
                    id: item.id,
                    indexSave: widget.indexChallenge,
                    validate: false,
                    index: int.parse(item.index),
                    idChallenge: widget.id);
              }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                final bool resultat = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Confirmation",
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: Text("Voulez vous suprimmez la mission"),
                        actions: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text("Oui"),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text("Nom"),
                          )
                        ],
                      );
                    });
                return resultat;
              }
              return true;
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.delete,
                size: 35.0,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.centerRight,
              color: Colors.green,
              child: Icon(
                Icons.check,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            key: Key(UniqueKey().toString()),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 45.0, // soften the shadow
                    spreadRadius: 2.0, //extend the shadow
                    offset: Offset(
                      3.0, // Move to right 10  horizontally
                      3.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 20.0,
                child: ListTile(
                  onTap: () async {
                    if (item.description
                            .toString()
                            .replaceAll(unityPattern, "") ==
                        "video") {
                      print(item.name);
                      if (!await File(item.name).exists()) {
                        final pickedFile =
                            await picker.getVideo(source: ImageSource.gallery);
                        item.name = pickedFile.path;
                        setState(() {
                          if (pickedFile != null) {
                            item.name = pickedFile.path;
                          } else {
                            print('No image selected.');
                          }
                        });
                        return;
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child: VideoPlayerScreen(
                                  nameChallenge: item.name))));
                    } else if (item.description
                            .toString()
                            .replaceAll(unityPattern, "") ==
                        "image") {
                      if (!await File(item.name).exists()) {
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);
                        item.name = pickedFile.path;
                        setState(() {
                          if (pickedFile != null) {
                            item.name = pickedFile.path;
                          } else {
                            print('No image selected.');
                          }
                        });
                        return;
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child: PlayPicture(nameChallenge: item.name))));
                    } else if (item.description
                            .toString()
                            .replaceAll(unityPattern, "") ==
                        "url") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child: PlayUrl(nameChallenge: item.name))));
                    } else if (item.description
                            .toString()
                            .replaceAll(unityPattern, "") ==
                        "adresse") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child: AdressMap(adresse: item.name))));
                    } else if (item.description
                            .toString()
                            .replaceAll(unityPattern, "") ==
                        "commentaire") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child:
                                  PlayCommentaire(nameChallenge: item.name))));
                    } else if (item.description
                            .toString()
                            .replaceAll(unityPattern, "") ==
                        "youtube") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child: PlayYoutubeScreen(
                                  nameChallenge: item.name))));
                    } else if (item.description
                                .toString()
                                .replaceAll(unityPattern, "") ==
                            "evenement" ||
                        item.description
                                .toString()
                                .replaceAll(unityPattern, "") ==
                            "information" ||
                        item.description
                                .toString()
                                .replaceAll(unityPattern, "") ==
                            "tache" ||
                        item.description
                                .toString()
                                .replaceAll(unityPattern, "") ==
                            "projet" ||
                        item.description
                                .toString()
                                .replaceAll(unityPattern, "") ==
                            "mission") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: provider,
                              child: Home(
                                returnRaccourci: false,
                                id: widget.id,
                                idChallenge1: item.id,
                                namechallenge: item.tache,
                              ))));
                    }
                  },
                  title: Container(
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 15.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text(
                                  "Etape".toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(item.index),
                              ],
                            ),
                          ),
                        ),
                        formationEdit(
                            provider,
                            item,
                            item.description
                                .toString()
                                .replaceAll(unityPattern, "")),
                        SizedBox(
                          width: 5.0,
                        ),
                        prixCout(item.prix, item.cout)
                      ],
                    ),
                  ),
                  subtitle: FlipCard(
                    flipOnTouch: formation,
                    direction: FlipDirection.HORIZONTAL, // default
                    front: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 20.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 30.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        modifDescription(item.description
                                            .toString()
                                            .replaceAll(unityPattern, "")),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colorsDescription(item
                                                .description
                                                .toString()
                                                .replaceAll(unityPattern, ""))),
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      maxLetter(
                                          item.tache.toString(),
                                          item.description
                                              .toString()
                                              .replaceAll(unityPattern, "")),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      iconDataJoin(item.description
                                          .toString()
                                          .replaceAll(unityPattern, "")),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    back: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 20.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 30.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      maxLetter(
                                          item.formation.chapitre,
                                          item.description
                                              .toString()
                                              .replaceAll(unityPattern, "")),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      maxLetter(
                                          item.formation.duree,
                                          item.description
                                              .toString()
                                              .replaceAll(unityPattern, "")),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      maxLetter(
                                          item.formation.theoriePratique,
                                          item.description
                                              .toString()
                                              .replaceAll(unityPattern, "")),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  isThreeLine: true,
                ),
              ),
            ),
          ),
        );
      },
      onDragFinish: (before, after) {
        Challengemodel2 data = _challengesList[before];
        _challengesList.removeAt(before);
        _challengesList.insert(after, data);
        provider.save();
        provider.deplacelistSAve(widget.indexChallenge, widget.id);
      },
      canBeDraggedTo: (one, two) => true,
      dragElevation: 8.0,
    );
  }

  SnackBar _buildSnackBar({@required String content, String lotties}) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Container(
        height: 80,
        child: Row(
          children: [
            Lottie.asset(lotties, width: 60),
            Text(
              content,
              style: TextStyle(color: Colors.purple),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
