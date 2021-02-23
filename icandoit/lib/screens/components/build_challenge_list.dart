import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import '../../controllers/challenge_controller.dart';

class ChallengesListBuilder extends StatefulWidget {
  final Future<List<ChallengeModel>> challenData;
  final Challengecontroller controller;
  ChallengesListBuilder(
      {@required this.challenData, @required this.controller});
  @override
  _ChallengesListBuilderState createState() => _ChallengesListBuilderState();
}

class _ChallengesListBuilderState extends State<ChallengesListBuilder> {
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
                "Pas de challenge crees.",
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
                              content:
                                  Text("Voulez vous suprimmez le challenge"),
                              actions: [
                                RaisedButton(
                                  onPressed: () {
                                    widget.controller.remove(index: index);
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
                      size: 50.0,
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
                    color: Colors.white,
                    child: ListTile(
                      title: Text(_challengesList[index].name),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Objectif",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(_challengesList[index].target.toString()),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(_challengesList[index]
                                .unity
                                .toString()
                                .replaceAll(unityPattern, "")
                                .toUpperCase()),
                          ],
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
}
