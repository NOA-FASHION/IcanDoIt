import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FutureBuilder(
            future: loadProductsForSale(),
            builder: (context, AsyncSnapshot<List<ProductDetails>> data) {
              if (!data.hasData) {
                return CircularProgressIndicator();
              }
              return Flexible(
                child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            buyProduct(data.data[index]);
                          },
                          child: Text("text " + data.data[index].id.toString()),
                        ),
                      );
                    }),
              );
            })
      ]),
    );
  }
}
