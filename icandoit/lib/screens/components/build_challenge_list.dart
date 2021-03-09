import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../controllers/challenge_controller.dart';
import 'package:colour/colour.dart';

import 'build_challenge_list_tache.dart';
import 'home_screen_tache.dart';

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
                      boxShadow: [
                        //background color of box
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  HomeTaches(_challengesList[index].name)));
                        },
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
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              // border: Border.all(
                              //   color: Colour('#C4AB4D'),
                              //   width: 2,
                              // ),
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 15.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 25.0,
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
                                    Container(
                                      child: new CircularPercentIndicator(
                                        radius: 60.0,
                                        lineWidth: 5.0,
                                        percent: 1.0,
                                        center: new Text("100%"),
                                        progressColor: Colors.green,
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
