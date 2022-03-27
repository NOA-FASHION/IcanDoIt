import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../home_screen.dart';

GlobalKey<_PurchaseAppState> myAppKey = GlobalKey();

class PurchaseApp extends StatefulWidget {
  PurchaseApp({Key myAppKey}) : super(key: myAppKey);

  @override
  State<PurchaseApp> createState() => _PurchaseAppState();
}

class _PurchaseAppState extends State<PurchaseApp> {
  InAppPurchase iap = InAppPurchase.instance;
  List<ProductDetails> products = [];
  List<PurchaseDetails> purchases = [];

  Future<bool> isAppPurchaseAvailable() async {
    final bool available = await iap.isAvailable();
    return available;
  }

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
      myAppKey.currentState?.refreshApp();
      return products;
    } else {
      print('purchasService is not available');
      return null;
    }
  }

  void buyProduct(ProductDetails prod, Challengecontroller variable) {
    print("prod :" + prod.toString());
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);

    iap.buyNonConsumable(purchaseParam: purchaseParam);
    for (var purch in purchases) {
      iap.completePurchase(purch);
    }
    // bool a = boolPurchase as bool;
    // print("boolPurchase:" + a.toString());

    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        print('purchase: ' + purchase.status.name);
        if (purchase.status == PurchaseStatus.restored) {
          variable.switchTrueIntro();
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

  void restaurProduct(ProductDetails prod, Challengecontroller variable) {
    iap.restorePurchases();
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        // print('purchase: ' + purchase.productID);
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.restore,
              size: 30,
              color: Colors.white,
            ),
            message: 'purchase: ' + purchase.productID,
          ),
        );
        if (purchase.productID == 'in_app_purchase') {
          variable.switchTrueIntro();
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

  void errorTest() {
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.restore,
              size: 30,
              color: Colors.white,
            ),
            message: 'purchase: ' + purchase.error.message,
          ),
        );
      }
    });
  }

  void errorTest1() {
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.restore,
              size: 30,
              color: Colors.white,
            ),
            message: 'purchase: ' + purchase.error.code,
          ),
        );
      }
    });
  }

  void errorTest2() {
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.restore,
              size: 30,
              color: Colors.white,
            ),
            message: 'purchase: ' + purchase.status.name,
          ),
        );
      }
    });
  }

  void errorTest3() {
    purchases.forEach((purchase) {
      if (purchase.purchaseID != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.restore,
              size: 30,
              color: Colors.white,
            ),
            message: 'purchase: ' + purchase.purchaseID,
          ),
        );
      }
    });
  }

  void initialize() async {
    iap.purchaseStream.listen((newPurchaes) {
      newPurchaes.forEach((purchase) {
        print('new purchases : ' + purchase.productID.toString());
      });
      purchases.addAll(newPurchaes);
    });
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
  ];

  final List<Widget> items = [
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
        'assets/1.png',
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
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
                              print("page : $page");
                              setState(() {});
                            },
                            onSelectedItem: (page) {
                              print("page : $page");
                              if (page == 0) {
                                restaurProduct(data.data[0], variable);
                              } else if (page == 1) {
                                buyProduct(data.data[0], variable);
                              }
                            },
                            images: items,
                            titles: titles,
                          ));
                    }),
              ),

              Column(
                children: [
                  Text("Erreur"),
                  IconButton(
                      onPressed: () {
                        errorTest();
                      },
                      icon: Icon(
                        Icons.error,
                        size: 50,
                        semanticLabel: "test",
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Text("Erreur code"),
                  IconButton(
                      onPressed: () {
                        errorTest1();
                      },
                      icon: Icon(
                        Icons.bedroom_child,
                        size: 50,
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Text("status"),
                  IconButton(
                      onPressed: () {
                        errorTest2();
                      },
                      icon: Icon(
                        Icons.start,
                        size: 50,
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Text("purchaseId"),
                  IconButton(
                      onPressed: () {
                        errorTest3();
                      },
                      icon: Icon(
                        Icons.airlines,
                        size: 50,
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
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
          "Si vous avez déja eu la chance de l'er, et que vous souhaitez l'installer sur un nouveau smartphone, procédez à une restauration d'achat.",
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
        // Text(
        //   'SATISFAIT OU REMBOURSÉ',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 11,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.grey[200],
        //   ),
        // ),
        SizedBox(height: 1),
      ],
    );
  }
}
