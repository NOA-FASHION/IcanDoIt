import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchMapsUrl(String lien) async {
      final url = lien;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    const bodyStyle = TextStyle(fontSize: 17.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 70),
          child: Text("Lister vos restaurants préférées",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Vous pouvez lister vos restaurants préférée et y associer une documentation ciblée .",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Cela est très simple a réaliser", style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Créer une mission Normal.", style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Ci joint le lien pour la procédure",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        IconButton(
            onPressed: () {
              _launchMapsUrl(
                  "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000509155-cr%C3%A9er-un-challenge");
            },
            icon: Icon(
              Icons.link,
              size: 40,
              color: Colors.blue,
            )),
        SizedBox(
          height: 10,
        ),
        Text("Ensuite listez vos restaurants par Catégorie, par exemple ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Restaurant chinois, fast food , restaurant chic.",
            style: bodyStyle),
        SizedBox(
          height: 19,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "ensuite pour chaque catégorie créer un mission normal avec le nom du restaurant ensuite  rentrer et associer y les documents importants tel que l'adresse, les photos  et videos , des liens avec des avis , des video youtube,",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "associer la photos du menus , vous pouvez même lister le prix du menu pour estimer avant votre visite le prix total de vos commandes",
            style: bodyStyle),
        SizedBox(
          height: 19,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/restautant3.png'),
        ),
        SizedBox(
          height: 10,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/restaurant1.gif'),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Désactiver la vue principal des éléments de cette mission ",
            style: bodyStyle),
        SizedBox(
          height: 19,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/restaurant2.gif'),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
