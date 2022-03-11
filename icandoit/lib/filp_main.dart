import 'package:card_flip/card_flip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icandoit/colorss.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget_factory.dart';

class FlipLayoutDemo extends StatelessWidget {
  final String lienInternet;
  final String etape;
  final String typeChallenge;
  final String typeChallenge1;
  final String lottiesChallenge;
  final String assetPictureChallengeeCreer;
  final String titreChallenge;
  final String descriptionChallenge;
  final String prioriteChallenge;
  final Widget actionChallenge;
  final String actionChallenge2;
  final String pictureChallenge;
  final String titreChallenge2;
  FlipLayoutDemo({
    this.lienInternet,
    this.etape,
    this.typeChallenge,
    this.lottiesChallenge,
    this.typeChallenge1,
    this.assetPictureChallengeeCreer,
    this.titreChallenge,
    this.descriptionChallenge,
    this.prioriteChallenge,
    this.actionChallenge,
    this.actionChallenge2,
    this.pictureChallenge,
    this.titreChallenge2,
  });
  @override
  Widget build(BuildContext context) {
    return FlipLayout(
        duration: 800,
        foldState: true,
        children: [
          component2(assetPictureChallengeeCreer, titreChallenge,
              descriptionChallenge, prioriteChallenge, titreChallenge2),
          component3(actionChallenge2),
          component4(assetPictureChallengeeCreer, context),
          // component5(actionChallenge),
          component6(),
        ],
        foldChild: FoldCard(
          etape: etape,
          typeChallenge: typeChallenge,
          typeChallenge1: typeChallenge1,
          lottiesChallenge: lottiesChallenge,
        ));
  }

  /// 组件 2
  Widget component2(
      String assetPictureChallengeeCreer,
      String titreChallenge,
      String descriptionChallenge,
      String prioriteChallenge,
      String titreChallenge2) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 44,
            color: HexColor.fromHex('5D4A99'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                Text(
                  titreChallenge2,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                // Text(
                //   '\$25',
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.orange, Colors.blue])),
            child: Padding(
                padding: const EdgeInsets.all(12.0), child: actionChallenge),
          )
        ],
      ),
    );
  }

  /// 组件 3
  Widget component3(String actionChallenge2) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(8.0),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(bottom: 6),
            //   child: Text(
            //     'SENDER',
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontSize: 12,
            //     ),
            //   ),
            // ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 48,
                    height: 48,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Aide',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          actionChallenge2,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        _launchMapsUrl(lienInternet);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ));
                }),
              ],
            ),
            Divider(
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }

  Widget component4(String assetPictureChallengeeCreer, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.orange, Colors.blue])),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            assetPictureChallengeeCreer,
            width: 180,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  /// 组件 4
// Widget component4() {
//   return Container(
//     color: Colors.white,
//     padding: const EdgeInsets.all(10),
//     child: Row(
//       children: [
//         Expanded(
//           child: multipleLineText(
//               'FROM',
//               'W 90th St',
//               'New York, NY '
//                   '10025'),
//         ),
//         Expanded(
//           child: multipleLineText('TO', '46th Ave', 'Woodside, NY 11101'),
//         ),
//         const Icon(
//           Icons.arrow_forward_ios,
//           size: 16,
//           color: Colors.grey,
//         )
//       ],
//     ),
//   );
// }

  /// 组件 5
  Widget component5(String actionChallenge) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.orange, Colors.blue])),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: Text(
            actionChallenge,
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }

  /// 组件 6
  Widget component6() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.orange, Colors.blue])),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Builder(builder: (context) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  primary: HexColor.fromHex('FEBE16'),
                ),
                onPressed: () {
                  FlipLayout.of(context).toggle();
                },
                child: const Text(
                  'Réduire',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 4,
            ),
            // const Text('5 people have sent a request',
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w500,
            //     ))
          ],
        ),
      ),
    );
  }

  /// 三行文字
  Widget multipleLineText(String line1, String line2, String line3) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          height: 1.4,
        ),
        children: [
          TextSpan(
            text: '$line1\n',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '$line2\n',
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: line3,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget explainText(String title, String subtitle,
      {Color titleColor, Color subtitleColor}) {
    return Text.rich(
      TextSpan(
          style: const TextStyle(
            height: 1.4,
          ),
          children: [
            TextSpan(
                text: '$title\n',
                style: TextStyle(
                  color: titleColor ?? Colors.grey,
                  fontSize: 13,
                )),
            TextSpan(
              text: subtitle,
              style: TextStyle(
                color: subtitleColor ?? Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ]),
    );
  }
}

void _launchMapsUrl(String lien) async {
  final url = lien;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
