import 'package:flutter/material.dart';
import '../DataTypesCustum.dart';
import '../item3.dart';
import 'package:http/http.dart' as http;
import '../../VariablesValues.dart';
import 'dart:convert';
import '../PlaceOrder/PlaceOrder.dart';
import '../router.dart';
import '../DeliveryConditions.dart';

class YourCart extends StatefulWidget {
  DataBase database;
  Function callBack;
  YourCart(this.database,this.callBack);
  @override
  _YourCartState createState() => _YourCartState();
}

class _YourCartState extends State<YourCart> {
  List<Widget> productCart = [];
  List<String> productId = [];
  DataBase database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.database = this.widget.database;
    getDeliveryChargesData();

  }

  @override
  Widget build(BuildContext context) {
    if(this.totalAmountToBePaid == 0.0){
      this.deliveryAmount = 0.0;
    }
    // TODO: implement build
    Widget noItems = Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "No items in cart.",
          style: TextStyle(
              color: Color.fromRGBO(127, 127, 127, 1.0), fontFamily: 'dacts'),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white.withOpacity(0.9)),
        backgroundColor: Colors.lightGreen,
        title: Text(
          "Your cart",
          style: TextStyle(
              color: Colors.white.withOpacity(0.8), fontFamily: 'dacts'),
        ),
        //leading: IconButton(icon: Icon(Icons.menu,color: Colors.white.withOpacity(0.8),), onPressed:(){this._scaffoldKey.currentState.openDrawer();}),
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(
//                Icons.shopping_cart,
//                color: Colors.white.withOpacity(0.8),
//              ),
//              onPressed: null),
//          IconButton(
//              icon: Icon(
//                Icons.account_circle,
//                color: Colors.white.withOpacity(0.8),
//              ),
//              onPressed: null),
//        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.withOpacity(0.2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: (this.productCart.length == 0)
                        ? [noItems]
                        : this.productCart,
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Text(
                        "Pricing details:",
                        style: TextStyle(
                            color: Colors.black87, fontFamily: 'dacts'),
                      ),
                      (this.loaded)
                          ? Card(
                              color: Colors.white,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Total Amount",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Rs : ${this.total}",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Divider(),
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Discount Amount",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            "- Rs : ${this.totalDiscountAmount.toStringAsFixed(1)}",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Divider(),
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Delivery Charges",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            "Rs : ${this.deliveryAmount.toStringAsFixed(1)}",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      )
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Divider(),
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Total billable amount",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            "Rs : ${this.totalAmountToBePaid.toStringAsFixed(1)}",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    62, 78, 89, 0.9),
                                                fontSize: 16.0,
                                                fontFamily: 'dacts')),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Text("Delivery charges :",style: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontFamily: 'dacts'),),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Delivery(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Card(
          elevation: 10.0,
          margin: const EdgeInsets.all(0.0),
          child: (this.loaded)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: new Padding(
                        padding: new EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: null,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Total Bill = Rs : ${this.totalAmountToBePaid.toStringAsFixed(1)}",
                                style: TextStyle(
                                    color: Color.fromRGBO(62, 78, 89, 0.9),
                                    fontSize: 18.0,
                                    fontFamily: 'dacts'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "You saved Rs : ${this.totalDiscountAmount.toStringAsFixed(1)}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12.0,
                                      fontFamily: 'dacts'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.green.withOpacity(0.8),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 10.0, left: 10.0),
                          child: FlatButton(
                              onPressed: () {
                                if(this.cartData.length != 0) {
                                  Navigator.push(
                                    context,
                                    SlideRightRoute(
                                        widget: PlaceOrder(
                                            this.database, this.cartData, () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        "Your order was placed."),
                                                    content: SingleChildScrollView(
                                                        child: Text(
                                                            "You will recieve a call from Store.")),
                                                  ));
                                          this.widget.callBack();
                                        },this.deliveryAmount)),
                                  ).then((val) {
                                    print("one");
                                  });
                                }
                                else{
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text(
                                                "OOPS !"),
                                            content: SingleChildScrollView(
                                                child: Text(
                                                    "Please add items to your cart.")),
                                          ));
                                }
                              },
                              child: Text(
                                "Place Order",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'dacts'),
                              )),
                        ),
                      ),
                    )
                  ],
                )
              : Row(),
        ),
      ),
    );
  }

  double total = 0.0;
  double totalDiscountAmount = 0.0;
  double totalAmountToBePaid = 0.0;
  List<String> cartData = [];
  bool loaded = false;
  void productTotalAmount() async {
    this.productId = [];
    this.total = 0.0;
    this.totalDiscountAmount = 0.0;
    this.totalAmountToBePaid = 0.0;
    double localTotal = 0.0;
    double localTotalDiscount = 0.0;
    double localTotalAmount = 0.0;
    double localDelivery = 0.0;
    this.loaded = false;
    setState(() {});
    this.database.addToCart.forEach((key, values) {
      if (key != "product") {
        this.productId.add(key);
      }
    });
    http
        .post("$baseUrl/cart-options/cart-amount/index.php",
            headers: {}, body: '{"ids":{"data":${this.productId}}}')
        .then((response) {
      if (!response.body.contains("Error_msg")) {
        print("...............///");
        print(response.body);
        var x = json.decode(response.body);
        this.cartData = [];
        print(x);
        print(this.database.addToCart);
        for (int i = 0; i < x["data"].length; i++) {
          double quantity =
              this.database.addToCart["${x["data"][i]["productId"]}"];
          localTotal = localTotal + (quantity * x["data"][i]["price"]);
          localTotalDiscount = localTotalDiscount +
              (quantity *
                  (x["data"][i]["price"] * (x["data"][i]["discount"].toDouble() / 100.toDouble())));
//          localTotalAmount = localTotalAmount +
//              ((quantity * x["data"][i]["price"]) -
//                  (quantity *
//                      (x["data"][i]["price"] *
//                          (x["data"][i]["discount"] / 100))));
          localTotalAmount = localTotal - localTotalDiscount;
          if(localTotalAmount <= 300.0){
            localDelivery = this.charges["1.0 to 300.0"];
          }
          else if((localTotalAmount > 300.0) && (localTotalAmount <= 500.0)){
            localDelivery = this.charges["301.0 to 500.0"];
          }
          else if((localTotalAmount > 500.0) && (localTotalAmount <= 1000.0)){
            localDelivery = this.charges["501.0 to 1000.0:"];
          }
          else if((localTotalAmount >= 1000.0)){
            localDelivery = this.charges["above 1000.0"];
          }
          else{
            localDelivery = 50.0;
          }
          if(localTotalAmount== 0.0){
            localDelivery = 0.0;
          }
          localTotalAmount = localTotalAmount + localDelivery;
          print(this.total);
          print(localTotalDiscount);
          String dataOfItem =
              '{"productId":"${x["data"][i]["productId"]}","discount":${x["data"][i]["discount"]},"price":${x["data"][i]["price"]},"quantity":$quantity}';
          print(dataOfItem);
          this.cartData.add(dataOfItem);
        }
        this.total = localTotal;
        this.totalAmountToBePaid = localTotalAmount;
        this.totalDiscountAmount = localTotalDiscount;
        this.deliveryAmount = localDelivery;
        print(this.cartData);
        this.loaded = true;
        setState(() {});
      }
    });

  }
  var charges;
  double deliveryAmount = 0.0;
  void getDeliveryChargesData() async{
    http.get("$baseUrl/other-details/deliverycharge.php").then((response){
      print(response.body);
      this.charges = json.decode(response.body);
      print("..........");
      print(this.charges);
      this.database.addToCart.forEach((key, values) {
        if (key != "product") {
          this.productCart.add(DisplayProduct(key, this.database, () {
            this.widget.callBack();
            productTotalAmount();
          }));
          this.productCart.add(Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Divider(),
          ));
          this.productId.add(key);
        }
      });
      productTotalAmount();
    });
  }


  ///
///
///

  void productTotalAmount2() async {
    this.productId = [];
    this.total = 0.0;
    this.totalDiscountAmount = 0.0;
    this.totalAmountToBePaid = 0.0;
    double localTotal = 0.0;
    double localTotalDiscount = 0.0;
    double localTotalAmount = 0.0;
    double localDelivery = 0.0;
    this.loaded = false;
    setState(() {});
    this.database.addToCart.forEach((key, values) {
      if (key != "product") {
        this.productId.add(key);
      }
    });
    print(this.productId);
    http
        .post("$baseUrl/cart-options/cart-amount/index.php",
        headers: {}, body: '{"ids":{"data":${this.productId}}}')
        .then((response) {
      if (!response.body.contains("Error_msg")) {
        print("...............///");
        print(response.body);
        var x = json.decode(response.body);
        this.cartData = [];
        print(x);
        print(this.database.addToCart);
        for (int i = 0; i < x["data"].length; i++) {
          double quantity = 0.0;
          quantity =
          this.database.addToCart["${x["data"][i]["productId"]}"];
          print("Qiantity :$quantity");

          localTotal = localTotal + (quantity * x["data"][i]["price"]);
          print(localTotal);
          localTotalDiscount = localTotalDiscount +
              (quantity *
                  (x["data"][i]["price"] * (x["data"][i]["discount"].toDouble() / 100.toDouble())));
//          localTotalAmount = localTotalAmount +
//              ((quantity * x["data"][i]["price"]) -
//                  (quantity *
//                      (x["data"][i]["price"] *
//                          (x["data"][i]["discount"] / 100))));
          print("Local DIscount: $localTotalDiscount");
          localTotalAmount = localTotal - localTotalDiscount;
          print("Local total : $localTotalAmount");
          if(localTotalAmount <= 300.0){
            localDelivery = this.charges["1.0 to 300.0"];
          }
          else if((localTotalAmount > 300.0) && (localTotalAmount <= 500.0)){
            localDelivery = this.charges["301.0 to 500.0"];
          }
          else if((localTotalAmount > 500.0) && (localTotalAmount <= 1000.0)){
            localDelivery = this.charges["501.0 to 1000.0:"];
          }
          else if((localTotalAmount >= 1000.0)){
            localDelivery = this.charges["above 1000.0"];
          }
          else{
            localDelivery = 50.0;
          }
          if(localTotalAmount== 0.0){
            localDelivery = 0.0;
          }
          localTotalAmount = localTotalAmount + localDelivery;
          print(this.total);
          print(localTotalDiscount);
          String dataOfItem =
              '{"productId":"${x["data"][i]["productId"]}","discount":${x["data"][i]["discount"]},"price":${x["data"][i]["price"]},"quantity":$quantity}';
          print(dataOfItem);
          this.cartData.add(dataOfItem);
        }
        this.total = localTotal;
        this.totalAmountToBePaid = localTotalAmount;
        this.totalDiscountAmount = localTotalDiscount;
        this.deliveryAmount = localDelivery;
        print(this.cartData);
        this.loaded = true;
        setState(() {});
      }
    });

  }
}
