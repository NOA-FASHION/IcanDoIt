import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(ICanDoIt());

class ICanDoIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'ICanDoIt',
      home: SlideDrawer(
        items: [
          MenuItem('Home', icon: Icons.home, onTap: () {}),
          MenuItem('Project', icon: Icons.rss_feed, onTap: () {}),
          MenuItem('Favourite', icon: Icons.favorite_border, onTap: () {}),
          MenuItem('Profile', icon: Icons.person_outline, onTap: () {}),
          MenuItem('Setting', icon: Icons.settings, onTap: () {}),
        ],
        child: ChangeNotifierProvider<Challengecontroller>(
            create: (context) => Challengecontroller(), child: Home()),
      ),
    );
  }
}
