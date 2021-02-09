import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';

class ChallengesListBuilder extends StatefulWidget {
  ChallengesListBuilder({Key key}) : super(key: key);

  @override
  _ChallengesListBuilderState createState() => _ChallengesListBuilderState();
}

class _ChallengesListBuilderState extends State<ChallengesListBuilder> {
  List<ChallengeModel> _challengesList = [
    ChallengeModel(name: "Challenge1", target: 23, unity: unity_cahllenge.kg),
    ChallengeModel(name: "Challenge2", target: 23, unity: unity_cahllenge.kg)
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _challengesList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          child: ListTile(
            title: Text(_challengesList[index].name),
            subtitle: Text(_challengesList[index].target.toString()),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
