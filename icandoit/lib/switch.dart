import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:provider/provider.dart';

class SwitchEdit extends StatefulWidget {
  SwitchEdit();

  @override
  State<SwitchEdit> createState() => _SwitchEditState();
}

class _SwitchEditState extends State<SwitchEdit> {
  bool isSwitched1;
  boolTransform(String switchBool) {
    bool isSwitched;
    if (switchBool == 'true' || switchBool == '') {
      isSwitched = true;
    } else {
      isSwitched = false;
    }
    isSwitched1 = isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    Challengeyesterday challengeYestaday = variable.getChallengeyesterday();
    String switchBool = challengeYestaday.commentaire;
    boolTransform(switchBool);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Switch(
            value: isSwitched1,
            onChanged: (value) {
              setState(() {
                isSwitched1 = value;
                variable.switchIntro(switchBool);
              });
            },
            activeTrackColor: Colors.yellow,
            activeColor: Colors.orangeAccent,
          ),
          Text("Actif au démarage")
        ],
      ),
    );
  }
}
