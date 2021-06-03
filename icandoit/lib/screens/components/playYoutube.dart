// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:async';

// class PlayYoutubeScreen extends StatefulWidget {
//   final String nameChallenge;
//   const PlayYoutubeScreen({Key key, this.nameChallenge}) : super(key: key);

//   @override
//   _PlayYoutubeScreenState createState() => _PlayYoutubeScreenState();
// }

// class _PlayYoutubeScreenState extends State<PlayYoutubeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final Completer<WebViewController> _controller =
//         Completer<WebViewController>();

import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:youtube_parser/youtube_parser.dart';

class PlayYoutubeScreen extends StatefulWidget {
  final String nameChallenge;
  const PlayYoutubeScreen({Key key, this.nameChallenge}) : super(key: key);

  @override
  _PlayYoutubeScreenState createState() => _PlayYoutubeScreenState();
}

class _PlayYoutubeScreenState extends State<PlayYoutubeScreen>
    implements YouTubePlayerListener {
  double _currentVideoSecond = 0.0;
  String _playerState = "";
  FlutterYoutubeViewController _controller;

  @override
  void onCurrentSecond(double second) {
    print("onCurrentSecond second = $second");
    _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  void _loadOrCueVideo() {
    _controller.loadOrCueVideo(
        getIdFromUrl(widget.nameChallenge), _currentVideoSecond);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Default UI')),
        body: Stack(
          children: <Widget>[
            Container(
                child: FlutterYoutubeView(
              onViewCreated: _onYoutubeCreated,
              listener: this,
              params: YoutubeParam(
                videoId: getIdFromUrl(widget.nameChallenge),
                showUI: true,
                startSeconds: 5 * 60.0,
                showYoutube: false,
                showFullScreen: false,
              ),
            )),
            Center(
                child: Column(
              children: <Widget>[
                Text(
                  'Current state: $_playerState',
                  style: TextStyle(color: Colors.blue),
                ),
                RaisedButton(
                  onPressed: _loadOrCueVideo,
                  child: Text('Click reload video'),
                ),
              ],
            ))
          ],
        ));
  }
}
