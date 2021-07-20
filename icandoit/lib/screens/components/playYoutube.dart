import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: SafeArea(
            child: AppBar(
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 19),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.youtube,
                        size: 20,
                        color: Colors.red,
                      ), // icon
                      Text(
                        "Youtube",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ), // text
                    ],
                  ),
                )
              ],
              title: Text("Youtube"),
              centerTitle: true,
              flexibleSpace: Container(
                height: 130,
                padding: EdgeInsets.only(top: 40.0, right: 30.0),
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
                showFullScreen: true,
              ),
            )),
            Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.repeat,
                      color: Colors.white,
                      size: 60,
                    ),
                    onPressed: () {
                      _loadOrCueVideo();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 90),
                  child: Text(
                    _playerState,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),

                // RaisedButton(
                //   onPressed: _loadOrCueVideo,
                //   child: Text('Click reload video'),
                // ),
              ],
            ))
          ],
        ));
  }
}
