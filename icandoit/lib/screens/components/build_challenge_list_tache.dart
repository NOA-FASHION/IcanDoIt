import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import '../../controllers/challenge_controller.dart';
import 'package:colour/colour.dart';

class ChallengesListBuilderTaches extends StatefulWidget {
  final Future<List<ChallengeModel>> challenData;
  final Challengecontroller controller;
  ChallengesListBuilderTaches(
      {@required this.challenData, @required this.controller});
  @override
  _ChallengesListBuilderTachesState createState() =>
      _ChallengesListBuilderTachesState();
}

class _ChallengesListBuilderTachesState
    extends State<ChallengesListBuilderTaches> {
  String unityPattern = "unity_challenge.";
  @override
  Widget build(BuildContext context) {
    Future<List<ChallengeModel>> _challengesList = widget.challenData;

    return FutureBuilder(
        future: _challengesList,
        builder: (context, AsyncSnapshot<List<ChallengeModel>> data) {
          List<ChallengeModel> _challengesList = data.data;
          if (!data.hasData) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          } else if (_challengesList.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                "Pas de mission en cours.",
                style: TextStyle(color: Colors.orange[600], fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: _challengesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 3.0, left: 8.0, right: 8.0),
                child: Dismissible(
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      Scaffold.of(context).showSnackBar(_buildSnackBar(
                          content:
                              "Le challenge ${_challengesList[index].name} a bien ete valide"));
                      widget.controller.remove(index: index);
                    }

                    if (direction == DismissDirection.startToEnd) {
                      Scaffold.of(context).showSnackBar(_buildSnackBar(
                          content:
                              "La mission ${_challengesList[index].name} a bien ete supprime"));
                      widget.controller.remove(index: index);
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
                      size: 55.0,
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
                      color: Colors.white,
                      border: Border.all(
                        color: Colour('#518faa'),
                        width: 4,
                      ),
                    ),
                    child: ListTile(
                      title: Container(
                        child: Row(
                          children: [
                            Text(
                              "Titre",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(_challengesList[index].name),
                            SizedBox(
                              width: 5.0,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: Colour('#C4AB4D'),
                              width: 2,
                            ),
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
                                        "Description",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(_challengesList[index]
                                          .description
                                          .toString()),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30.0,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Priorite",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(_challengesList[index]
                                          .unity
                                          .toString()
                                          .replaceAll(unityPattern, "")
                                          .toUpperCase()),
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
                      isThreeLine: true,
                    ),
                  ),
                ),
              );
            },
          );
        });
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
