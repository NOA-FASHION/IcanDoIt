// import 'package:flutter/material.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class PlayYoutubeScreen extends StatefulWidget {
//   final String nameChallenge;
//   const PlayYoutubeScreen({Key key, this.nameChallenge}) : super(key: key);

//   @override
//   _PlayYoutubeScreenState createState() => _PlayYoutubeScreenState();
// }

// class _PlayYoutubeScreenState extends State<PlayYoutubeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     PlayerState _playerState;
//     YoutubeMetaData _videoMetaData;

//     bool _isPlayerReady = false;
//     String videoId = YoutubePlayer.convertUrlToId(widget.nameChallenge);
//     YoutubePlayerController _controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: true,
//       ),
//     );
//     void listener() {
//       if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//         setState(() {
//           _playerState = _controller.value.playerState;
//           _videoMetaData = _controller.metadata;
//         });
//       }
//     }

//     return Container(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(100.0),
//           child: SafeArea(
//             child: AppBar(
//               centerTitle: true,
//               flexibleSpace: Container(
//                 padding: EdgeInsets.only(right: 30.0),
//                 alignment: Alignment.centerRight,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Image.asset(
//                       'assets/logo.png',
//                       width: 60,
//                     ),
//                   ],
//                 ),
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         colors: <Color>[Colors.purple, Colors.blue])),
//               ),
//             ),
//           ),
//         ),
//         body: YoutubePlayer(
//           controller: _controller,
//           showVideoProgressIndicator: true,
//           progressColors: ProgressBarColors(
//             playedColor: Colors.amber,
//             handleColor: Colors.amberAccent,
//           ),
//           onReady: () {
//             _controller.addListener(listener);
//           },
//         ),
//       ),
//     );
//   }
// }
