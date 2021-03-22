import 'dart:io';

import 'package:flutter/material.dart';

class PlayPicture extends StatelessWidget {
  final String nameChallenge;
  const PlayPicture({Key key, this.nameChallenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("picture"),
      ),
      body: Container(
        child: Image.file(File(nameChallenge)),
      ),
    );
  }
}
