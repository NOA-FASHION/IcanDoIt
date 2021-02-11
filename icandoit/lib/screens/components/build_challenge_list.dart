import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';

class ChallengesListBuilder extends StatefulWidget {
  ChallengesListBuilder({Key key}) : super(key: key);

  @override
  _ChallengesListBuilderState createState() => _ChallengesListBuilderState();
}

class _ChallengesListBuilderState extends State<ChallengesListBuilder> {
  List<ChallengeModel> _challengesList = [
    ChallengeModel(name: "Challenge1", target: 23, unity: unity_challenge.kg),
    ChallengeModel(name: "Challenge2", target: 23, unity: unity_challenge.kg)
  ];
  String unityPattern = "unity_challenge.";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _challengesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3.0, left: 8.0, right: 8.0),
          child: Dismissible(
            confirmDismiss: (direction) {
              if (direction == DismissDirection.startToEnd) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Confirmation"),
                        content: Text("Voulez vous suprimmez le challenge"),
                        actions: [
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Oui"),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Nom"),
                          )
                        ],
                      );
                    });
              }
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
                            fontWeight: FontWeight.bold, color: Colors.black),
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
  }
}
