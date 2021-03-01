import 'package:flutter/material.dart';
import 'DataTypesCustum.dart';
import 'router.dart';
import '../VariablesValues.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ProductPage/productView.dart';
class DisplayProduct extends StatefulWidget {
  String productId;
  DataBase passingData;
  Function callBack;
  DisplayProduct(this.productId, this.passingData,this.callBack);

  @override
  _DisplayProductState createState() => _DisplayProductState();
}

class _DisplayProductState extends State<DisplayProduct> {
  bool _loaded = false;
  double incrementBy = 0.0;
  double priceOfProduct = 0.0;
  double quantity = 0.0;
  double itemTotalOrdered = 0.0;
  String units = '';
  String productName = '';
  String imageUrl = '';
  DataBase database;
  String response;
  int discountStatus = 0;
  int discount = 0;
  String short = '';
  void requestData() {
    http.post("$baseUrl/product-details/product/1/details/index.php",
        headers: {}, body: '{"productId":"${this.widget.productId}"}')
        .then((response) {
      if(!response.body.contains("Error_msg")){
        this.response = response.body;
        print("................");
        print(this.response);
        var x = json.decode(response.body);
        this.productName = x["name"];
        this.imageUrl = x["image"];
        this.incrementBy = x["incrementBy"];
        this.quantity = x["inStock"];
        this.units = x["quantityUnits"];
        this.priceOfProduct = x["price"];
        this.discountStatus = x["discountStatus"];
        this.discount = x["discount"];
        this.short = x["shortUts"];
        this._loaded = true;
        setState(() {});
      }
    });
  }
  @override
  void initState() {
    super.initState();
    setNewData();
  }
  void setNewData(){
    this.database = this.widget.passingData;
    print(this.database.total);
    if(this.database.addToCart.containsKey(this.widget.productId)){
      double x = this.database.addToCart[this.widget.productId];
      this.itemTotalOrdered = x;
    }
    else{
      this.itemTotalOrdered = 0.0;
    }
    requestData();
  }

  void sendCartData() async{
    //print('{"userId":"${this.database.userData["userId"]}","cart": ${this.database.addToCart}}');
    String body = '{';
    String newBody = '{"userId":"${this.database.userData["userId"]}"';
    int n = 0;
    print(this.database.addToCart);
    this.database.addToCart.forEach((key,values){
      String valuesS = '"$key":"$values"';
      print(valuesS);
      if(n == 0){
        body = '$body$valuesS';
        n= n+1;
      }
      else{
        body = '$body,$valuesS';
      }
    });
    body = '$body}';
    newBody = '$newBody,"cart":$body}';
    print(newBody);
    http.post("$baseUrl/add-cart/index.php",headers: {},body:newBody).then((response){
      print(response.body);
    });
  }
  @override
  Widget build(BuildContext context) {
    return(this._loaded)? new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.network(
              '$baseUrl/carosoel/product/$imageUrl',
              height: 80.0,
              width: 80.0,
            ),
          ),
          new Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
//                    Navigator.push(
//                      context,
//                      SlideRightRoute(widget: ProductDetails(this.response,this.database)),
//                    ).then((value){
//                      print(value);
//                      setNewData();
//                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("$productName",
                          style: TextStyle(fontFamily: 'dacts', fontSize: 18.0)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Rs :$priceOfProduct per $units",
                                style: TextStyle(
                                    fontFamily: 'dacts',
                                    fontSize: 12.0,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.grey,
                                    color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Rs :${this.priceOfProduct - (this.priceOfProduct * (this.discount/100))} per $units",
                                style: TextStyle(
                                    fontFamily: 'dacts',
                                    fontSize: 14.0,
                                    //decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.grey,
                                    color: Colors.lightGreen),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                (this.discountStatus == 1)?Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: new Image.asset("images/offer.png",height: 15.0,width: 15.0,),
                ):Container(),
                Container(
                  child: (this.itemTotalOrdered.toStringAsFixed(1) == "0.0")
                      ? Container(
                      color: Colors.green.withOpacity(0.7),
                      child: GestureDetector(
                        onTap: () {
                          //this.widget.funct(120);
                          this.itemTotalOrdered =
                              this.itemTotalOrdered + this.incrementBy;
                          this.database.addToCart["${this.widget.productId}"] = this.itemTotalOrdered;
                          increment();
                          this.widget.callBack();

                          sendCartData();
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0,fontFamily: 'dacts'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                      : Container(
                    child: Row(
                      children: <Widget>[
                        new IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.green,
                              size: 20.0,
                            ),
                            onPressed: () {
                              this.itemTotalOrdered =
                                  this.itemTotalOrdered - this.incrementBy;
                              this.database.addToCart["${this.widget.productId}"] = this.itemTotalOrdered;
                              if(this.itemTotalOrdered.toStringAsFixed(1) == "0.0"){
                                this.database.addToCart.remove(this.widget.productId);
                              }
                              decrement();
                              this.widget.callBack();
                              sendCartData();
                              //this.widget.funct(-120);
                              setState(() {});
                            }),
                        new Text(
                          //kg[0].toString(),
                          "${this.itemTotalOrdered.toStringAsFixed(1)} ${this.short}",
                          style: TextStyle(
                              color: Color.fromRGBO(62, 78, 89, 0.9),
                              fontSize: 14.0,fontFamily: 'dacts'),
                        ),
                        new IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 20.0,
                            ),
                            onPressed: () {
                              this.itemTotalOrdered =
                                  this.itemTotalOrdered + this.incrementBy;
                              this.database.addToCart["${this.widget.productId}"] = this.itemTotalOrdered;
                              //this.widget.funct(120);
                              increment();
                              this.widget.callBack();

                              sendCartData();
                              setState(() {});
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ):Container(child: CircularProgressIndicator(),);
  }
  void increment(){
    double amount2 = (this.priceOfProduct * this.incrementBy) - ((this.priceOfProduct * this.incrementBy) * (this.discount / 100));
    this.database.total = this.database.total + amount2;
    setState(() {

    });
  }
  void decrement(){
    double amount2 = (this.priceOfProduct * this.incrementBy) - ((this.priceOfProduct * this.incrementBy) * (this.discount / 100));
    this.database.total = this.database.total - amount2;
    setState(() {

    });
  }
}
