import 'package:flutter/material.dart';
import 'package:icandoit/filp_main.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class TravauxDeRenovation extends StatelessWidget {
  const TravauxDeRenovation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(top: 35),
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
                  "Projet de rénovation",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // gradient: LinearGradient(
                  //     begin: Alignment.centerLeft,
                  //     end: Alignment.centerRight,
                  //     colors: [Colors.orange, Colors.blue]),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Lottie.asset("assets/renovation12.json", width: 40),
                ),
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
            assetPictureChallengeeCreer: 'assets/normalRenovation.png',
            titreChallenge: 'Challenges Normal',
            titreChallenge2: 'Projet de rénovation',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Pour lister les éléments importants de votre projet de rénovation. Vous devez d'abord créer un challenge de type normal. "),
            actionChallenge2: 'Créer un challenge Normal',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer la liste des',
            typeChallenge: ' étapes de votre projet',
            lottiesChallenge: "assets/recetteEtape.json",
            assetPictureChallengeeCreer: 'assets/listerenovation.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Projet de rénovation',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Créer un élément de type 'projet' pour chaque pièce de la maison."),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            actionChallenge2: 'documentations  possibles',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 3',
            typeChallenge1: 'Exemple de structure pour',
            typeChallenge: "un projet de rénovation",
            lottiesChallenge: "assets/structure.json",
            assetPictureChallengeeCreer: 'assets/travaux1.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Projet de rénovation',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Créer pour chaque pièce de votre maison, plusieurs types de missions visuels ou auditives incluant des tutos ou des meubles ou des matériaux intérréssant que vous aurez trouvé: "),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text(
                            'une mission de type tutoriel , pour vous aider')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text(
                            'une mission de type photos avec leur ref et leur prix.')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('une mission de type videos ')),
                  ],
                ),
              ],
            ),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Fonction',
            typeChallenge1: ' Accéder facilement',
            typeChallenge: '  à la documentation ',
            lottiesChallenge: "assets/accederDoc.json",
            assetPictureChallengeeCreer: 'assets/travaux.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Projet de rénovation',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Pour accéder a la documentions que vous avez associer a votre projet , il suffit de sélectionner l'élément et vous y aurez accès. "),
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
    //       child: Text("Travaux de rénovation",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Créer une mission Normal.", style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour la procédure",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
    //     Text(
    //         "Sélectionner votre mission pour rentrer les différentes informations et documents associé aux travaux que vous devez effectuer. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Créer un élément de type 'projet' pour chaque pièce de la maison, par exemple:",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Projet chambre ,Projet salle à manger,Projet salle de bain,Projet cuisine,Projet salon,Projet terrasse",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         'Sélectionner un des projet  par exemple "Chambres" et créer un ensemble de documentations et de taches concernant ce projet.',
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Par exemples:", style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Une liste de tutoriel concernant des travaux en relation avec le projet chambre.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Une autre liste de photos et videos de meuble ou matériaux avec leur ref et leur prix.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "une autre liste  du prix des matériaux et objets  a acheter pour le  projet chambre.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "une liste  des choses a réaliser des choses a réaliser pour le projet chambre.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Les taches validées seront restaurées le jour suivant. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Une notification quotidienne sera active pour vous rappeler et vous encourager dans vos taches quotidiennes.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/travaux1.png'),
    //     ),
    //     SizedBox(
    //       height: 15,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/travaux.gif'),
    //     ),
    //     SizedBox(
    //       height: 18,
    //     ),
    //   ],
    // );
  }
}
