import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/screens/components/code_activation.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../home_screen.dart';

// GlobalKey<_PurchaseAppState> myAppKey = GlobalKey();
class PurchaseApp extends StatefulWidget {
  @override
  State<PurchaseApp> createState() => _PurchaseAppState();
}

class _PurchaseAppState extends State<PurchaseApp> {
  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorFirebase();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider.value(
              value: variable, child: PurchaseAppStart());
        }
        return const Loading();
      },
    );
  }
}

class PurchaseAppStart extends StatefulWidget {
  PurchaseAppStart({Key myAppKey}) : super(key: myAppKey);

  @override
  State<PurchaseAppStart> createState() => _PurchaseAppStartState();
}

class _PurchaseAppStartState extends State<PurchaseAppStart> {
  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  InAppPurchase iap = InAppPurchase.instance;
  List<ProductDetails> products = [];
  List<PurchaseDetails> purchases = [];

  Future<bool> isAppPurchaseAvailable() async {
    final bool available = await iap.isAvailable();
    return available;
  }

  String status = '';
  String erreur = '';
  String productId = '';
  String purchaseId = '';
  Future<List<ProductDetails>> loadProductsForSale() async {
    if (await isAppPurchaseAvailable()) {
      const Set<String> _kids = {"in_app_purchase"};
      final ProductDetailsResponse responses =
          await iap.queryProductDetails(_kids);

      if (responses.notFoundIDs.isNotEmpty) {
        return null;
      }
      if (responses.error != null) {
        print(responses.error);
        return null;
      }
      products = responses.productDetails;
      // myAppKey.currentState?.refreshApp();
      return products;
    } else {
      print('purchasService is not available');
      return null;
    }
  }

  void buyProduct(ProductDetails prod, Challengecontroller variable,
      FirebaseAuth _auth, String documentId) async {
    // print("prod :" + prod.toString());
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        if (purchase.status == PurchaseStatus.purchased) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.restore,
                size: 30,
                color: Colors.white,
              ),
              message:
                  "Vous avez déja acheté cet article, procéder à une restauration",
            ),
          );
          return;
        }
      }
    });
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);

    await iap
        .buyNonConsumable(purchaseParam: purchaseParam)
        .then((value) => activeTrue(prod, variable, _auth, documentId));
    // for (var purch in purchases) {
    //   iap.completePurchase(purch);
    // }
    // bool a = boolPurchase as bool;
    // print("boolPurchase:" + a.toString());
  }

  void activeTrue(ProductDetails prod, Challengecontroller variable,
      FirebaseAuth _auth, String documentId) async {
    await delay(500);
    purchases.forEach((purchase) {
      iap.completePurchase(purchase);
      if (purchase.purchaseID != null) {
        // print('purchase: ' + purchase.status.name);
        if (purchase.status == PurchaseStatus.purchased) {
          addDataToFirebse(variable, documentId, _auth);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: variable,
                  child: Home(
                    id: "",
                    idChallenge1: '',
                    namechallenge: '',
                    returnRaccourci: false,
                  ))));
        }
      }
    });
  }

  resutatRestaur(ProductDetails prod, Challengecontroller variable,
      FirebaseAuth _auth, String documentId) async {
    await delay(500);
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        // print('purchase: ' + purchase.productID);
        // String switchIntro =
        //     variable.getChallengeyesterday().nbChallengeEnCours;
        if (purchase.status == PurchaseStatus.restored ||
            purchase.status == PurchaseStatus.purchased) {
          addDataToFirebse(variable, documentId, _auth);
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.restore,
                size: 30,
                color: Colors.white,
              ),
              message: 'Achat restauré avec succes',
            ),
          );

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: variable,
                  child: Home(
                    id: "",
                    idChallenge1: '',
                    namechallenge: '',
                    returnRaccourci: false,
                  ))));
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.restore,
                size: 30,
                color: Colors.white,
              ),
              message: "Vous n'avez pas encore acheté cet article",
            ),
          );
        }
      }
    });
  }

  void restaurProduct(ProductDetails prod, Challengecontroller variable,
      FirebaseAuth _auth, String documentId) async {
    await iap
        .restorePurchases()
        .then((value) => resutatRestaur(prod, variable, _auth, documentId));
  }

  void initialize() async {
    iap.purchaseStream.listen((newPurchaes) {
      newPurchaes.forEach((purchase) {
        print('new purchases : ' + purchase.productID.toString());
      });
      purchases.addAll(newPurchaes);
    });
  }

  // final databaseReference = FirebaseFirestore.instance;
  void addDataToFirebse(
      Challengecontroller variable, String documentId, FirebaseAuth _auth) {
    bool boolAchat = false;
    bool boolrestor = false;
    bool activationBoll = false;
    String purchaseId1 = '';
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        print('purchase: ' + purchase.status.name);
        if (purchase.status == PurchaseStatus.purchased) {
          boolAchat = true;
          purchaseId1 = purchase.purchaseID;
        } else {
          boolAchat = false;
          purchaseId1 = "Pas d'id";
        }
        if (purchase.status == PurchaseStatus.restored) {
          boolrestor = true;
        } else {
          boolrestor = false;
        }
        if (boolAchat || boolrestor) {
          activationBoll = true;
          variable.switchTrueIntro(activationBoll);
        } else {
          activationBoll = false;
        }

        activationEasy(
                auth: _auth,
                documentId: documentId,
                variable: variable,
                boolAchat: boolAchat,
                activationBoll: activationBoll,
                purchaseId1: purchaseId1,
                boolrestor: boolrestor)
            .then((value) => _auth.signOut());
      }
    });
  }

  Future<void> activationEasy(
      {Challengecontroller variable,
      FirebaseAuth auth,
      String documentId,
      bool boolAchat,
      bool activationBoll,
      String purchaseId1,
      bool boolrestor}) async {
    DateTime today = new DateTime.now();

    final databaseReference = FirebaseFirestore.instance;
    if (documentId.isNotEmpty && documentId != null) {
      try {
        await databaseReference
            .collection("activation")
            .doc(documentId)
            .update({
          "Achat": boolAchat,
          "activation": activationBoll,
          "IdCommade": purchaseId1,
          "LastConnect": DateFormat('EEEE, d MMM, yyyy').format(today),
          "Restor": boolrestor
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      DateTime today = new DateTime.now();

      try {
        await databaseReference.collection("activation").add({
          "email": "Pas d'email",
          "Achat": boolAchat,
          "Code d'activation": "Pas de code",
          "activation": activationBoll,
          "activatipnManuelle": false,
          "IdCommade": purchaseId1,
          "Installation": true,
          "LastConnect": DateFormat('EEEE, d MMM, yyyy').format(today),
          "Restor": boolrestor
        }).then((value) => variable.documentIdFirebase(value.id));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void initState() {
    super.initState();
    loadProductsForSale();
    initialize();
  }

  refreshApp() {
    setState(() {});
  }

  bool index = true;

  final List<String> titles = [
    "",
    "",
    "",
  ];

  bool _isDialogShowing = false;

  editActivation(Challengecontroller variable, String documentId) {
    // var baseDialog = EditProduitGagnant();
    showDialog(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider.value(
              value: variable,
              child: CodeActivation(
                variable: variable,
                documentId: documentId,
              ));
        });
  }

  List<Widget> items = [
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        'assets/2.png',
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        'assets/3.png',
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        'assets/1.png',
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    _auth.signInAnonymously();
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    String documentId = variable.getChallengeyesterday().nbtacheVallide;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.purple, Colors.blue])),
        child: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                child: CustomPaint(
                  painter: CurvePainter(),
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        HeaderSection(),
                        // ButtonSection(),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 15,
                borderOnForeground: true,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.18,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.production_quantity_limits,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "C'est le moment de continuer l'aventure.  ",
                              style: GoogleFonts.playfairDisplay(),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "D'autres fonctionnalités arrivent.",
                              style: GoogleFonts.playfairDisplay(),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.lightbulb_rounded, color: Colors.blue),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Vos idées sont aussi les bienvenues.",
                              style: GoogleFonts.playfairDisplay(),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.contacts, color: Colors.blue),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Easytodo972@gmail.com.",
                              style: GoogleFonts.playfairDisplay(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Lottie.asset('assets/achat.json', width: 100),
              Container(
                height: 450,
                child: FutureBuilder(
                    future: loadProductsForSale(),
                    builder:
                        (context, AsyncSnapshot<List<ProductDetails>> data) {
                      if (!data.hasData) {
                        return CircularProgressIndicator();
                      }

                      return Container(
                          padding: EdgeInsets.all(10.0),
                          child: VerticalCardPager(
                            align: ALIGN.CENTER,
                            onPageChanged: (page) {
                              // print("page : $page");
                              setState(() {});
                            },
                            onSelectedItem: (page) {
                              // print("page : $page");
                              if (page == 0) {
                                // activationEasy(
                                //     activationBoll: true,
                                //     variable: variable,
                                //     auth: _auth,
                                //     documentId: documentId,
                                //     boolAchat: true,
                                //     boolrestor: false,
                                //     purchaseId1: "12334");
                                restaurProduct(
                                  data.data[0],
                                  variable,
                                  _auth,
                                  documentId,
                                );
                              } else if (page == 2) {
                                buyProduct(
                                    data.data[0], variable, _auth, documentId);
                              } else if (page == 1) {
                                editActivation(variable, documentId);
                              }
                            },
                            images: items,
                            titles: titles,
                          ));
                    }),
              ),
              IconButton(
                onPressed: () {
                  purchases.forEach((purchase) {
                    if (purchase.purchaseID != null) {
                      setState(() {
                        status = purchase.status.name;
                        erreur = purchase.error.toString();
                        productId = purchase.productID;
                        purchaseId = purchase.purchaseID;
                      });
                    }
                  });
                },
                icon: Icon(Icons.access_alarm),
              ),
              Text("Status:" + status),
              Text("erreur:" + erreur),
              Text("productId:" + productId),
              Text("purchaseId:" + purchaseId),
            ]),
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, 300);
    path.quadraticBezierTo(size.width / 2, 700 / 2, size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Image.asset(
          'assets/logo.png',
          width: 60,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 5),
        Text(
          'Easytodo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.grey[200],
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Activer Easytodo ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Si vous avez déja eu la chance de l'acheter, et que vous souhaitez l'installer sur un nouveau smartphone, procédez à une restauration d'achat.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: Colors.grey[200],
          ),
        ),
        SizedBox(height: 5),
        Image.asset('assets/divider.png'),
        SizedBox(height: 5),
        SizedBox(height: 1),
      ],
    );
  }
}

class ErrorFirebase extends StatelessWidget {
  const ErrorFirebase({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: const Center(
            child: Text('Erreur de chargement des données'),
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: const Center(
            child: Text('Chargement'),
          ),
        ),
      ),
    );
  }
}
