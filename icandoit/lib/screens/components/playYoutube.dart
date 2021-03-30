import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayYoutube extends StatelessWidget {
  final String nameChallenge;
  const PlayYoutube({Key key, this.nameChallenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: SafeArea(
            child: AppBar(
              centerTitle: true,
              flexibleSpace: Container(
                padding: EdgeInsets.only(right: 30.0),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 60,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Colors.purple, Colors.blue])),
              ),
            ),
          ),
        ),
        body: Container(
            child: FlutterYoutubeView(
                onViewCreated: _onYoutubeCreated,
                listener: this,
                scaleMode:
                    YoutubeScaleMode.none, // <option> fitWidth, fitHeight
                params: YoutubeParam(
                    videoId: nameChallenge.replaceAll(
                        "https://www.youtube.com/watch?v=", ""),
                    showUI: false,
                    startSeconds: 0.0, // <option>
                    autoPlay: false) // <option>
                )),
      ),
    );
  }
}
