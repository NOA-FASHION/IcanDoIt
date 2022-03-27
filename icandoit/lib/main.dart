// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:icandoit/Switch.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/guestscreen1.dart';

// import 'package:icandoit/listTacheQuotidienne.dart';
// import 'package:icandoit/listeDeCourse.dart';
import 'package:icandoit/screens/components/challenge_list_save.dart';
// import 'package:icandoit/screens/components/formations.dart';

// import 'package:icandoit/screens/components/listeDeMusics.dart';
// import 'package:icandoit/screens/components/restaurantList.dart';
// import 'package:icandoit/screens/components/shareChallenge.dart';
// import 'package:icandoit/screens/components/travauxDeRenovation.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:page_transition/page_transition.dart';

// import 'faireGateauxAuChocolat.dart';
// import 'screens/home_screen.dart';
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
      debugShowCheckedModeBanner: false,
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
          create: (context) => Challengecontroller(),
          child: GuestScreenStart()),
    );
  }
}
