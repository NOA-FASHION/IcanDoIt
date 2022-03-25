import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:vertical_card_pager/vertical_card_pager.dart';

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

  void buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    iap.buyNonConsumable(purchaseParam: purchaseParam);
    for (var purch in purchases) {
      iap.completePurchase(purch);
    }
  }

  void restaurProduct(ProductDetails prod) async {
    // final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    // iap.buyNonConsumable(purchaseParam: purchaseParam);

    await InAppPurchase.instance.restorePurchases();
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
        'assets/1.png',
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        'assets/2.png',
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                        Row(
                          children: [
                            Icon(Icons.lightbulb_rounded, color: Colors.blue),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Vos idées sont aussi les bienvenus.",
                              style: GoogleFonts.playfairDisplay(),
                            ),
                          ],
                        ),
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
                                buyProduct(data.data[0]);
                              }
                            },
                            images: items,
                            titles: titles,
                          ));
                    }),
              )
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
          "Si vous avez déja eu la chance de l'acheté, et que vous souhaitez l'installer sur un nouveau smartphone, procéder à une restauration d'achat.",
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