import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'filp_main.dart';

class FaireGateauxAuChaocolat extends StatelessWidget {
  const FaireGateauxAuChaocolat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 95),
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
                  "Faire un gâteau au chocolat".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 14, fontWeight: FontWeight.bold),
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
            titreChallenge2: 'Faire un gâteau au chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Pour lister efficacement les étapes importantes de votre recette, Vous devez d'abord créer un challenge de type normal."),
                // Text("  ")
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
            typeChallenge: '  étape de votre recette',
            lottiesChallenge: "assets/recetteEtape.json",
            assetPictureChallengeeCreer: 'assets/listeRecette.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau au chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "Rentrer les différentes tâches et documents associés à la recette de votre gâteau."),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Par exemple cela peut être : ",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('Un élément de type tâche')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('Un élément de type commentaire')),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                    "Il est possible aussi de créer des éléments visuels ou audios comme : "),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('Une photo')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('Un lien youtube')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('Un lien internet')),
                  ],
                ),
                Row(
                  children: [
                    Text('\u2022'),
                    SizedBox(width: 5),
                    Expanded(child: Text('Une vidéo')),
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
            typeChallenge: "importantes de votre recette",
            lottiesChallenge: "assets/validateRecette.json",
            assetPictureChallengeeCreer: 'assets/fairegateauxauchocolat3.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau au chocolat',
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
            titreChallenge2: 'Faire un gâteau au chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Pour accéder à la documentions que vous avez associé à votre recette, il suffit de sélectionner l'élément et vous y aurez accès. "),
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
            titreChallenge2: 'Faire un gâteau au chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Avant de valider chaque étape, il est conseillé de faire une sauvegarde de la mission en faisant un appui long sur celle ci."),
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
            titreChallenge2: 'Faire un gâteau au chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    " Vous pourrez à tout moment effectuer une restauration manuelle des tâches enregistrées."),
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
  }
}
