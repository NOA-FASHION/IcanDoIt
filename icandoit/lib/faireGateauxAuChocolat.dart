import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'filp_main.dart';

class FaireGateauxAuChaocolat extends StatelessWidget {
  const FaireGateauxAuChaocolat({Key key}) : super(key: key);

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
                  "Faire un gâteau aux chocolat",
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
                  child: Lottie.asset("assets/gateaux.json", width: 50),
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
            assetPictureChallengeeCreer: 'assets/gateauxAuChocolat.png',
            titreChallenge: 'Challenges Normal',
            titreChallenge2: 'Faire un gâteau aux chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Pour lister éfficacement les évenements importants de votre recette."),
                Text(" Vous devez d'abord créer un challenge de type normal. ")
              ],
            ),
            actionChallenge2: 'Créer un challenge Normal',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer la liste de chaque',
            typeChallenge: '  Etapes de votre recette',
            lottiesChallenge: "assets/recetteEtape.json",
            assetPictureChallengeeCreer: 'assets/listeRecette.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau aux chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "Rentrer les différentes tâches et documents associer à la recette de votre gâteaux."),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Par exemple cela pourra être: ",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text(' un élément de type tâche.')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('un élément de type commentaire.')),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                    "Il est possible aussi de créer des éléments visuels ou auditifs comme: "),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('une photo')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('un lien youtube')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('un lien internet')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('une vidéo')),
                  ],
                ),
              ],
            ),
            actionChallenge2: 'documentations  possibles',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 3',
            typeChallenge1: 'Validation des étapes',
            typeChallenge: "importante de votre recette",
            lottiesChallenge: "assets/validateRecette.json",
            assetPictureChallengeeCreer: 'assets/fairegateauxauchocolat3.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau aux chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Lors de la réalisation de votre recette valider chaque étape par un swipe vers la gauche."),
                SizedBox(
                  height: 20,
                )
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
            assetPictureChallengeeCreer: 'assets/FaireGateauxAuChocoalat2.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau aux chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Pour accéder a la documentions que vous avez associer a votre recette , il suffit de sélectionner l'élément et vous y aurez accès. "),
            actionChallenge2: 'Documentations  possibles',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000513743",
            etape: 'Option',
            typeChallenge1: 'Comment réaliser une',
            typeChallenge: "Sauvegarde manuelle ?",
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/appuielong.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau aux chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Avant de valider chaque étape, il est conseillé de faire une sauvegarde de la mission en faisant un appuie long sur la mission."),
            actionChallenge2: 'Sauvegarde manuelle',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804380",
            etape: 'Option',
            typeChallenge1: 'Comment réaliser une',
            typeChallenge: "Restauration manuelle",
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/FaireGateauxAuChocoalat1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau aux chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    " Vous pourrez a tout moment effectuer une restauration manuelle des procès enregistrés"),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            actionChallenge2: 'Restauration manuelle',
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
    //       child: Text("Faire un gâteau aux chocolat",
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
    //         "Sélectionner votre mission pour rentrer les différentes tâches et documents associer à la recette de votre gâteaux.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Créer un élément de type tâche ou de type commentaire par exemple pour chaque phase importante de votre recette.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour créer une tâche ou un commentaire",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //     Text(
    //         "Créer un élément de type photo ou vidéo par exemple pour associer a votre recette un élément visuel important durant la phase de préparation de votre gâteaux.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Créer un élément de type youtube pour associer un tuto visuel a votre recette .",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Enfin créer un élément de type lien internet pour associer la page marmiton par exemple de la recette que vous réaliser.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         " Ci joint le lien pour créer une un élément de type youtube, photo, lien internet et vidéo",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/docs.png'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Pour accéder a la documentions que vous avez associer a votre recette , il suffit de sélectionner l'élément et vous y aurez accès. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/FaireGateauxAuChocoalat2.gif'),
    //     ),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Text(
    //         "Il vous suffit après lors de la réalisation de votre recette valider chaque étape, ou consulter a tout moment la documentation visuel ou auditive associer a votre mission",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/fairegateauxauchocolat3.gif'),
    //     ),
    //     SizedBox(
    //       height: 15,
    //     ),
    //     Text(
    //         "Avant de valider chaque étape par un swipe vers la gauche , il est conseillé de faire une sauvegarde de la mission en faisant un appuie long sur la mission",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 18,
    //     ),
    //     Text(
    //         "Chaque élément que vous ajouterez ou supprimerez a cette mission sera sauvegardé  ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Text(
    //         "Vous pourrez a tout moment effectuer une sauvegarde de vos procès que vous avez enregistrez.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/FaireGateauxAuChocoalat1.gif'),
    //     ),
    //   ],
    // );
  }
}
