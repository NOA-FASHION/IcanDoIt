import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import '../../controllers/challenge_controller.dart';
import 'package:colour/colour.dart';

class ChallengesListBuilderTaches extends StatefulWidget {
  final String nameChallenge;
  final Future<List<Challengemodel2>> challenData;
  final Challengecontroller controller;
  ChallengesListBuilderTaches(
      {@required this.challenData,
      @required this.controller,
      @required this.nameChallenge});
  @override
  _ChallengesListBuilderTachesState createState() =>
      _ChallengesListBuilderTachesState();
}

class _ChallengesListBuilderTachesState
    extends State<ChallengesListBuilderTaches> {
  String unityPattern = "unity_challenge1.";
  @override
  Widget build(BuildContext context) {
    Future<List<Challengemodel2>> _challengesList = widget.challenData;

    return FutureBuilder(
        future: _challengesList,
        builder: (context, AsyncSnapshot<List<Challengemodel2>> data) {
          List<Challengemodel2> _challengesList = data.data;
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
                      widget.controller.remove2(
                          index: index, nameChallenge: widget.nameChallenge);
                    }

                    if (direction == DismissDirection.startToEnd) {
                      Scaffold.of(context).showSnackBar(_buildSnackBar(
                          content:
                              "La mission ${_challengesList[index].name} a bien ete supprime"));
                      widget.controller.remove2(
                          index: index, nameChallenge: widget.nameChallenge);
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
                                  _challengesList[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text((index + 1).toString()),
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
                                            _challengesList[index]
                                                .description
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
                                          Text(_challengesList[index]
                                              .tache
                                              .toString()),
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
