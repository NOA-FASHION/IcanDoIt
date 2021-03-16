import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';

import 'package:icandoit/models/challenge_model.dart';
import 'package:provider/provider.dart';
import '../../controllers/challenge_controller.dart';

class ChallengesListBuilderTaches extends StatefulWidget {
  final String nameChallenge;

  ChallengesListBuilderTaches({@required this.nameChallenge});
  @override
  _ChallengesListBuilderTachesState createState() =>
      _ChallengesListBuilderTachesState();
}

class _ChallengesListBuilderTachesState
    extends State<ChallengesListBuilderTaches> {
  List<ChallengeModel> challengeListCharge;

  String unityPattern = "unity_challenge1.";
  @override
  Widget build(BuildContext context) {
    Challengecontroller providerType =
        Provider.of<Challengecontroller>(context);
    List<Challengemodel2> _challengesList =
        providerType.challengelist2(widget.nameChallenge);
    // List<Challengemodel2> _challengesList =
    //     challengelist2(challengeListCharge, widget.nameChallenge);
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
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "Le challenge ${item.name} a bien ete valide"));
                provider.remove2(
                    index: int.parse(item.index),
                    nameChallenge: widget.nameChallenge);
              }

              if (direction == DismissDirection.startToEnd) {
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "La mission ${item.name} a bien ete supprime"));
                provider.remove2(
                    index: int.parse(item.index),
                    nameChallenge: widget.nameChallenge);
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
                borderRadius: BorderRadius.circular(10),
                // color: Colors.white,
                // border: Border.all(
                //   color: Colour('#518faa'),
                //   width: 4,
                // ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 20.0,
                child: ListTile(
                  title: Container(
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            item.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(item.index),
                        SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
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
                                  children: [
                                    Text(
                                      item.description
                                          .toString()
                                          .replaceAll(unityPattern, "")
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(item.tache.toString()),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
      },
      canBeDraggedTo: (one, two) => true,
      dragElevation: 8.0,
    );
  }

  SnackBar _buildSnackBar({@required String content}) {
    return SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }
}
