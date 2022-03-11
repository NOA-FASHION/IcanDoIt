import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/Switch.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/filp_main.dart';
import 'package:icandoit/listTacheQuotidienne.dart';
import 'package:icandoit/listeDeCourse.dart';
import 'package:icandoit/screens/components/challenge_list_save.dart';
import 'package:icandoit/screens/components/formations.dart';
import 'package:icandoit/screens/components/listeDeMusics.dart';
import 'package:icandoit/screens/components/restaurantList.dart';
import 'package:icandoit/screens/components/shareChallenge.dart';
import 'package:icandoit/screens/components/travauxDeRenovation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'faireGateauxAuChocolat.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(IcanDoIt());

class IcanDoIt extends StatefulWidget {
  IcanDoIt({Key key}) : super(key: key);

  @override
  _IcanDoItState createState() => _IcanDoItState();
}

class _IcanDoItState extends State<IcanDoIt> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'ICanDoIt',
      routes: {
        '/list_save': (context) => ExampleApp(),
        '/settings': (context) => ExampleApp()
      },
      home: ChangeNotifierProvider<Challengecontroller>(
          create: (context) => Challengecontroller(), child: HomeScreen()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context, ChangeNotifier variable) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ChangeNotifierProvider.value(
                value: variable,
                child: Home(
                  id: "",
                  idChallenge1: '',
                  namechallenge: '',
                  returnRaccourci: false,
                ))));
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/logo.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 17.0);
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Material(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: ChangeNotifierProvider.value(
                value: variable, child: SwitchEdit()),
          ),
        ),
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            child: const Text(
              'Let\'s go right away!',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // _onIntroEnd(context, variable);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: ChangeNotifierProvider.value(
                          value: variable,
                          child: Home(
                            id: "",
                            idChallenge1: '',
                            namechallenge: '',
                            returnRaccourci: false,
                          ))));
            },
          ),
        ),
        pages: [
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: ListeTacheQuotidienne(),
            decoration: pageDecoration.copyWith(
              pageColor: Colors.transparent,
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: FaireGateauxAuChaocolat(),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: Formations(),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: ListeDeCourses(),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: TravauxDeRenovation(),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: ListeDeMusics(),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: RestaurantList(),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Les meilleurs pratiques",
            bodyWidget: ShareChallenge(),
            decoration: pageDecoration.copyWith(
              bodyFlex: 2,
              imageFlex: 4,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('logo.png', 100),
            reverse: true,
          ),
        ],
        onDone: () {
          // _onIntroEnd(context, variable);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: ChangeNotifierProvider.value(
                      value: variable,
                      child: Home(
                        id: "",
                        idChallenge1: '',
                        namechallenge: '',
                        returnRaccourci: false,
                      ))));
        },
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: true,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
