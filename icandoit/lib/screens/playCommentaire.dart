import 'package:flutter/material.dart';

class PlayCommentaire extends StatelessWidget {
  final String nameChallenge;

  const PlayCommentaire({Key key, this.nameChallenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("commentaire"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SizedBox(
            width: mediaQueryData.size.width, child: Text(nameChallenge)),
      ),
    );
  }
}
