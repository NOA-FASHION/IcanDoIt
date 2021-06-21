import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/play_pause_button_bar.dart';
import 'package:icandoit/screens/components/volume_slider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'meta_data_section.dart';

class PlayAllYoutubeScreen extends StatefulWidget {
  final List<String> listeDeYoutube;
  final int idChallenge;

  const PlayAllYoutubeScreen(this.listeDeYoutube, this.idChallenge);

  @override
  _PlayAllYoutubeScreenState createState() => _PlayAllYoutubeScreenState();
}

class _PlayAllYoutubeScreenState extends State<PlayAllYoutubeScreen> {
  YoutubePlayerController _controller;

  // String unityPattern = "unity_challenge1.";

  // void listeDeYoutube() {
  //   Challengecontroller variable = Provider.of<Challengecontroller>(context);
  //   List<ChallengeModel> _challengesListget = variable.getChallenges();
  //   List<String> youtubeList;
  //   if (_challengesListget[widget.idChallenge].id == widget.idChallenge) {
  //     for (var n =
  //             _challengesListget[widget.idChallenge].listeDeTache.length - 1;
  //         n >= 0;
  //         n--) {
  //       print(_challengesListget[widget.idChallenge]
  //           .listeDeTache[n]
  //           .description
  //           .toString());
  //       if (_challengesListget[widget.idChallenge]
  //               .listeDeTache[n]
  //               .description
  //               .toString()
  //               .replaceAll(unityPattern, "") ==
  //           "youtube") {
  //         youtubeList.add(getIdFromUrl(
  //             _challengesListget[widget.idChallenge].listeDeTache[n].name));
  //       }
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
   

    _controller = YoutubePlayerController(
      initialVideoId: widget.listeDeYoutube[0],
      params: YoutubePlayerParams(
        playlist: widget.listeDeYoutube,
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: SafeArea(
            child: AppBar(
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
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: player),
                  const SizedBox(
                    width: 500,
                    child: SingleChildScrollView(
                      child: Controls(),
                    ),
                  ),
                ],
              );
            }
            return ListView(
              children: [
                player,
                const Controls(),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

///
class Controls extends StatelessWidget {
  ///
  const Controls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _space,
          MetaDataSection(),
          _space,
          // SourceInputSection(),
          _space,
          PlayPauseButtonBar(),
          _space,
          VolumeSlider(),
          _space,
          // PlayerStateSection(),
        ],
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
}
