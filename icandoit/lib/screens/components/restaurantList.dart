import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../filp_main.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(top: 45),
              height: 70,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.orange, Colors.blue]),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue,
                  width: 4,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lister vos restaurants préférées",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset("assets/restaurant4.json", width: 60),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000509155-cr%C3%A9er-un-challenge",
            etape: 'Etape 1',
            typeChallenge1: ' Créer une mission',
            typeChallenge: ' de type "Normal"',
            lottiesChallenge: "assets/missionNormal.json",
            assetPictureChallengeeCreer: 'assets/restaurant2.png',
            titreChallenge: 'Challenges Normal',
            titreChallenge2: 'Lister vos restaurants préférées',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Vous pouvez lister vos restaurants préférée et y associer une documentation ciblée. "),
                Text("Cela est très simple a réaliser.Créer une mission Normal")
              ],
            ),
            actionChallenge2: 'Créer un challenge Normal',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer une liste de catégorie',
            typeChallenge: ' pour chaque type de restaurant',
            lottiesChallenge: "assets/recetteEtape.json",
            assetPictureChallengeeCreer: 'assets/listerestau.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos restaurants préférées',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(children: [
              Text(
                  "Ensuite listez vos restaurants par Catégorie en créant des objets de type information, par exemple:"),
              new ListTile(
                leading: Icon(Icons.fiber_manual_record),
                title: new Text('Restaurant chinois'),
              ),
              new ListTile(
                leading: Icon(Icons.fiber_manual_record),
                title: new Text('fast food '),
              ),
              new ListTile(
                  leading: Icon(Icons.fiber_manual_record),
                  title: new Text('restaurant chic'))
            ]),
            actionChallenge2: 'documentations  possibles',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000509155-cr%C3%A9er-un-challenge",
            etape: 'Etape 3',
            typeChallenge1: 'Créer une mission',
            typeChallenge: 'de type "Normal"',
            lottiesChallenge: "assets/missionNormal.json",
            assetPictureChallengeeCreer: 'assets/listerestaurant4.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos restaurants préférées',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "pour chaque catégorie créer un mission normal avec le nom du restaurant  "),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 4',
            typeChallenge1: ' créer la liste de caractéristique',
            typeChallenge: '  importantes de vos restaurants ',
            lottiesChallenge: "assets/digital.json",
            assetPictureChallengeeCreer: 'assets/restaurant1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos restaurants préférées',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text("rentrer et associer y les documents importants tel que:"),
                new ListTile(
                  leading: Icon(Icons.fiber_manual_record),
                  title: new Text("l'adresse, les photos"),
                ),
                new ListTile(
                  leading: Icon(Icons.fiber_manual_record),
                  title: new Text('des videos'),
                ),
                new ListTile(
                  leading: Icon(Icons.fiber_manual_record),
                  title: new Text('des liens internet avec des avis'),
                ),
                new ListTile(
                  leading: Icon(Icons.fiber_manual_record),
                  title: new Text('des video youtube'),
                )
              ],
            ),
            actionChallenge2: 'Documentations  possibles',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 70),
      ],
    );
    // void _launchMapsUrl(String lien) async {
    //   final url = lien;
    //   if (await canLaunch(url)) {
    //     await launch(url);
    //   } else {
    //     throw 'Could not launch $url';
    //   }
    // }

    // const bodyStyle = TextStyle(fontSize: 17.0);
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.only(top: 70),
    //       child: Text("Lister vos restaurants préférées",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Vous pouvez lister vos restaurants préférée et y associer une documentation ciblée .",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Cela est très simple a réaliser", style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Créer une mission Normal.", style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour la procédure",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000509155-cr%C3%A9er-un-challenge");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ensuite listez vos restaurants par Catégorie, par exemple ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Restaurant chinois, fast food , restaurant chic.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "ensuite pour chaque catégorie créer un mission normal avec le nom du restaurant ensuite  rentrer et associer y les documents importants tel que l'adresse, les photos  et videos , des liens avec des avis , des video youtube,",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "associer la photos du menus , vous pouvez même lister le prix du menu pour estimer avant votre visite le prix total de vos commandes",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/restautant3.png'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/restaurant1.gif'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Désactiver la vue principal des éléments de cette mission ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/restaurant2.gif'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //   ],
    // );
  }
}
