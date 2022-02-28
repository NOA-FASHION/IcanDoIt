import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/Switch.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/screens/components/challenge_list_save.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

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
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Text("Lister vos taches quotidiennes",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "La meilleur pratique est la suivante: Créer une mission quotidienne:",
                    style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Text("Ci joint le lien pour la procédure", style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513695-cr%C3%A9er-challenge-quotidien",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Sélectionner ensuite la mission que vous venez de créer, puis confectionnez des éléments illustrant les taches que vous pensez réalisez quotidiennement. ",
                    style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Vous disposez de plusieurs options récurrentes, pour vous accompagnez.",
                    style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Text(" Comment cela fonctionne t'il?",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Chaque tache quotidienne que vous allez associer a votre mission sera sauvegardée et restaurée chaque jour automatiquement.",
                    style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Exemple: Imaginez que vous avez validé les  tache 1, 2 et 5  aujourd'hui",
                    style: TextStyle(fontSize: 16, color: Colors.green)),
                SizedBox(
                  height: 10,
                ),
                Image(
                  width: 200,
                  image: AssetImage('assets/quotidienne1.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Les taches validées seront restaurées le jour suivant. ",
                    style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Une notification quotidienne sera active pour vous rappeler et vous encourager dans vos taches quotidiennes.",
                    style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Image(
                  width: 200,
                  image: AssetImage('assets/quotidienne2.png'),
                ),
                SizedBox(
                  height: 15,
                ),
                Image(
                  width: 200,
                  image: AssetImage('assets/lister.gif'),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                    "Chaque élément qui compose la mission peut être commentaire, un lien youtube, un prix, une informations. ",
                    style: bodyStyle),
                SizedBox(
                  height: 10,
                ),
                Image(
                  width: 200,
                  image: AssetImage('assets/docs.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Image(
                  width: 200,
                  image: AssetImage('assets/liste3.gif'),
                ),
              ],
            ),
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
            title: "Learn as you go",
            body:
                "Download the Stockpile app and master the market with our mini-lesson.",
            image: _buildImage('FaireGateauxAuChocoalat2.gif'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Kids and teens",
            body:
                "Kids and teens can track their stocks 24/7 and place trades that you approve.",
            image: _buildImage('FaireGateauxAuChocoalat2.gif'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Full Screen Page",
            body:
                "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
            image: _buildFullscreenImage(),
            decoration: pageDecoration.copyWith(
              contentMargin: const EdgeInsets.symmetric(horizontal: 16),
              fullScreen: true,
              bodyFlex: 2,
              imageFlex: 3,
            ),
          ),
          PageViewModel(
            title: "Another title page",
            body: "Another beautiful body text for this example onboarding",
            image: _buildImage('FaireGateauxAuChocoalat2.gif'),
            footer: ElevatedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(0);
              },
              child: const Text(
                'FooButton',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            useScrollView: true,
            title: "Title of last page - reversed",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Click on ", style: bodyStyle),
                Icon(Icons.edit),
                Text(" to edit a post", style: bodyStyle),
                Image(
                  width: 200,
                  image: AssetImage('assets/FaireGateauxAuChocoalat2.gif'),
                ),
                Image(
                  width: 200,
                  image: AssetImage('assets/FaireGateauxAuChocoalat2.gif'),
                )
              ],
            ),
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
