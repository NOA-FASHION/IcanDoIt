import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/screens/components/challenge_list_save.dart';
import 'package:slide_drawer/slide_drawer.dart';
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
        // When navigating to the "/" route, build the Main widget.

        '/list_save': (context) => ExampleApp(),
        '/settings': (context) => ExampleApp()
      },
      home:
          // home: Builder(
          //   builder: (context) => SlideDrawer(
          //     items: [
          //       MenuItem('Project', icon: Icons.rss_feed, onTap: () {
          //         Navigator.of(context).pop();
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) =>
          //                   ChangeNotifierProvider<Challengecontroller>(
          //                       create: (context) => Challengecontroller(),
          //                       child: Home())),
          //         );
          //       }),
          //       MenuItem('Project', icon: Icons.rss_feed, onTap: () {
          //         Navigator.of(context).pop();
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) =>
          //                   ChangeNotifierProvider<Challengecontroller>(
          //                       create: (context) => Challengecontroller(),
          //                       child: ExampleApp())),
          //         );
          //       }),
          //       MenuItem('Favourite', icon: Icons.favorite_border, onTap: () {}),
          //       MenuItem('Profile', icon: Icons.person_outline, onTap: () {}),
          //       MenuItem('Setting', icon: Icons.settings, onTap: () {}),
          //     ],
          // child:
          ChangeNotifierProvider<Challengecontroller>(
              create: (context) => Challengecontroller(), child: Home()),
    );
  }
}
