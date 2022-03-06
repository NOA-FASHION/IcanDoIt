import 'package:card_flip/card_flip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import 'colorss.dart';

List<Widget> itemWidgets = [
  component2(),
  component3(),
  component4(),
  component5(),
  component6(),
];

Widget itemWidget(int index) {
  return itemWidgets[index];
}

class FoldCard extends StatelessWidget {
  final String etape;
  final String typeChallenge;
  final String lottiesChallenge;

  FoldCard({
    this.etape,
    this.typeChallenge,
    this.lottiesChallenge,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: component1(etape, typeChallenge, lottiesChallenge),
      onTap: () {
        FlipLayout.of(context).toggle();
      },
    );
  }
}

/// component form https://github.com/FlutterDance/folding_cell/blob/master/lib/cell_content.dart
/// 组件 1
Widget component1(String etape, String typeChallenge, String lottiesChallenge) {
  double height = 165.0;
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    child: SizedBox(
      height: height,
      child: Row(
        children: [
          Container(
            width: 88,
            color: HexColor.fromHex('5D4A99'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  etape,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                // Text.rich(
                //   TextSpan(
                //     style: TextStyle(),
                //     children: [
                //       TextSpan(
                //         text: '   Créer    ',
                //         style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 10,
                //         ),
                //       ),
                //       TextSpan(
                //         text: 'Un challenge',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 13,
                //         ),
                //       ),
                //       TextSpan(
                //         text: '  quotidien',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 13,
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/logo.png',
                        width: 16,
                        height: 42,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Créer un challenge',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 8, 10, 8),
                              width: double.infinity,
                              height: 0.5,
                              color: Colors.grey[200],
                            ),
                            Text(
                              typeChallenge,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Lottie.asset(lottiesChallenge, width: 60),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     explainText('REQUEST', '6'),
                  //     explainText('PLEDGE', '\$150'),
                  //     explainText('WEIGHT', 'light'),
                  //   ],
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

/// 组件 2
Widget component2() {
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
            children: const [
              Icon(
                Icons.menu,
                color: Colors.white,
              ),
              Text(
                'Lister vos taches quotidiennes',
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
        Stack(
          children: [
            Image.asset(
              'assets/challengeQuotidien.png',
              width: double.infinity,
              height: 121,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              bottom: 12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  explainText('Titre', 'Challenges quotidien',
                      subtitleColor: Colors.white),
                  explainText('Description', 'Liste des challenges',
                      subtitleColor: Colors.white),
                  explainText('Priorité', 'Quotidien',
                      subtitleColor: Colors.white),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

/// 组件 3
Widget component3() {
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
                    children: const [
                      // RatingBar.builder(
                      //   initialRating: 3,
                      //   minRating: 1,
                      //   itemSize: 14,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      //   itemBuilder: (ctx, _) => Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   onRatingUpdate: (double value) {
                      //     print(value);
                      //   },
                      // ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Créer un challenge quotidien',
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
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              )
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

Widget component4() {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        Image.asset(
          'assets/challengeQuotidien.png',
          width: 180,
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
Widget component5() {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Row(
      children: [
        Expanded(
            child: Text(
          "Sélectionner la mission que vous venez de créer.",
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
      width: double.infinity,
      color: Colors.white,
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
          const Text('5 people have sent a request',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ))
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
