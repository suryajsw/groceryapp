import 'package:flutter/material.dart';
import '../DataTypesCustum.dart';
import 'dart:convert';
import '../../VariablesValues.dart';
import '../DrawerWidgets/Draw.dart';
import 'package:http/http.dart' as http;
import '../router.dart';
import '../YourCart/YourCartControler.dart';
import '../DeliveryConditions.dart';
class ProductDetails extends StatefulWidget{
  String productData;
  DataBase dataBase;
  Function callBack;
  ProductDetails(this.productData,this.dataBase,this.callBack);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var x;
  double incrementBy = 0.0;
  double priceOfProduct = 0.0;
  double quantity = 0.0;
  double itemTotalOrdered = 0.0;
  String units = '';
  String productName = '';
  String imageUrl1 = '';
  String imageUrl2 = '';
  String imageUrl3 = '';
  String productId = '';
  String category = '';
  String productDescription = '';
  int discount = 0;
  DataBase database;
  String short = '';
  bool _whishList = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int n = 1;
  @override
  void initState(){
    super.initState();
    this.x = json.decode(this.widget.productData);
    this.database = this.widget.dataBase;
    this.productName = x["name"];
    this.imageUrl1 = x["image"];
    this.imageUrl2 = x["image2"];
    this.imageUrl3 = x["image3"];
    this.incrementBy = x["incrementBy"];
    this.quantity = x["inStock"];
    this.units = x["quantityUnits"];
    this.priceOfProduct = x["price"];
    this.productId = x["productId"];
    this.category = x["category"];
    this.productDescription = x["productDescription"];
    this.discount = x["discount"];
    this.short = x["shortUts"];
    if(this.database.wishList.contains(this.productId)){
      this._whishList = true;
    }
    if(this.database.addToCart.containsKey(this.productId)){
      double x = this.database.addToCart[this.productId];
      this.itemTotalOrdered = x;
    }
  }
  void changeCart(){
    if(this.database.addToCart.containsKey(this.productId)){
      double x = this.database.addToCart[this.productId];
      this.itemTotalOrdered = x;
    }
    setState(() {});
  }

  void sendCartData() async{
    //print('{"userId":"${this.database.userData["userId"]}","cart": ${this.database.addToCart}}');
    String body = '{';
    String newBody = '{"userId":"${this.database.userData["userId"]}"';
    int n = 0;
    this.database.addToCart.forEach((key,values){
      String valuesS = '"$key":"$values"';
      if(n == 0){
        body = '$body$valuesS';
        n = n+1;
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
  void sendWishData() async{
    //print('{"userId":"${this.database.userData["userId"]}","cart": ${this.database.addToCart}}');

    String body = '{"userId":"${this.database.userData["userId"]}","wish":${this.database.wishList}}';
    print(body);
    http.post("$baseUrl/wish-list/index.php",headers: {},body:body).then((response){
      print(response.body);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //drawer: Draw(this.database),
      key: this._scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white.withOpacity(0.9)),
        backgroundColor: Colors.lightGreen,
        title: Text("${this.productName}",style: TextStyle(color: Colors.white.withOpacity(0.8),fontFamily: 'dacts'),),
//        leading: IconButton(icon: Icon(Icons.menu,color: Colors.white.withOpacity(0.8),), onPressed:(){this._scaffoldKey.currentState.openDrawer();}),
//        actions: <Widget>[
//          IconButton(icon:Icon(Icons.shopping_cart,color: Colors.white.withOpacity(0.8),), onPressed:(){
//            Navigator.push(
//              context,
//              SlideRightRoute(widget: YourCart(this.database)),
//            ).then((val){print("one");});
//          }),
//          IconButton(icon:Icon(Icons.account_circle,color: Colors.white.withOpacity(0.8),), onPressed: null),
//        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          icon: Icon(
                            Icons.star,
                            color: (this._whishList) ? Colors.red : Colors.grey,
                            size: 30.0,
                          ),
                          onPressed: () {
                            wishListAdd();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        child: Center(
                          child: new Image.network(
                            (this.n == 1)
                                ? "$baseUrl/carosoel/product/${this.imageUrl1}"
                                : (this.n == 2)?"$baseUrl/carosoel/product/${this.imageUrl2}":"$baseUrl/carosoel/product/${this.imageUrl3}",
                            height: 250.0,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              this.n = 1;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Image.network(
                                  (this.n == 1)
                                      ? "$baseUrl/carosoel/product/${this.imageUrl1}"
                                      : "$baseUrl/carosoel/product/${this.imageUrl1}",
                                ),
                              ),
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              this.n = 2;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Image.network(
                                  (this.n == 1)
                                      ? "$baseUrl/carosoel/product/${this.imageUrl2}"
                                      : "$baseUrl/carosoel/product/${this.imageUrl2}",
                                ),
                              ),
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              this.n = 3;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Image.network(
                                  (this.n == 1)
                                      ? "$baseUrl/carosoel/product/${this.imageUrl3}"
                                      : "$baseUrl/carosoel/product/${this.imageUrl3}",
                                ),
                              ),
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${this.productName}",
                        style: TextStyle(
                          fontSize: 25.0,fontFamily: 'dacts',
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rs : ${this.priceOfProduct}",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,fontFamily: 'dacts',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "Rs :${this.priceOfProduct - (this.priceOfProduct * (this.discount/100))} per $units",
                            style: TextStyle(
                                fontFamily: 'dacts',
                                //fontSize: 12.0,
                                //decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.grey,
                                color: Colors.lightGreen,fontSize: 16.0,),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54,width: 1.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Discount :${this.discount}%",
                                style: TextStyle(
                                  color: Colors.black54, fontSize: 18.0, fontFamily: 'dacts',),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            key: key,
                            child: (this.itemTotalOrdered.toStringAsFixed(1) == "0.0")
                                ? Container(
                                color: Colors.green.withOpacity(0.7),
                                child: GestureDetector(
                                  onTap: () {
                                    this.itemTotalOrdered =
                                        this.itemTotalOrdered + this.incrementBy;
                                    this.database.addToCart["${this.productId}"] = this.itemTotalOrdered;
                                    //this.widget.callBack();
                                    increment();
                                    sendCartData();
                                    this.widget.callBack();
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.shopping_cart,
                                          size: 16.0,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Add to cart",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,fontFamily: 'dacts'),
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
                                        this.database.addToCart["${this.productId}"] = this.itemTotalOrdered;
                                        if(this.itemTotalOrdered.toStringAsFixed(1) == "0.0"){
                                          this.database.addToCart.remove(this.productId);
                                        }
                                        decrement();
                                        sendCartData();
                                        this.widget.callBack();
                                        //this.widget.funct(-120);
                                        setState(() {});
                                      }),
                                  new Text(
                                    "${this.itemTotalOrdered.toStringAsFixed(1)} ${this.short}",
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            62, 78, 89, 0.9),
                                        fontFamily: 'dacts',
                                        fontSize: 18.0),
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
                                        this.database.addToCart["${this.productId}"] = this.itemTotalOrdered;
                                        //this.widget.funct(120);
                                        increment();
                                        sendCartData();
                                        this.widget.callBack();
                                        setState(() {});
                                      }),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0,left: 5.0),
                child: Divider(),
              ),
              new Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 10.0),
                  child: new Text("Delivery conditions:",style: TextStyle(color: Colors.deepOrangeAccent,fontFamily: 'dacts'),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Delivery(),
              ),
//              new Container(
//                alignment: Alignment.centerLeft,
//                padding: EdgeInsets.all(10.0),
//                child: Container(
//                    decoration: BoxDecoration(
//                      border: Border.all(color:Colors.grey,width: 1.0),
//                    ),
//                    padding: EdgeInsets.all(5.0),
//                    child: Text("Limited Stocks",style: TextStyle(fontFamily: 'dacts',color: Colors.orange),)),
//              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0,left: 5.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text("PRODUCT",style: TextStyle(fontSize: 20.0,fontFamily: "dacts"),),
                      Text(" DESCRIPTION",style: TextStyle(fontSize: 20.0,color: Colors.green.withOpacity(0.8),fontFamily: 'dacts'),)
                    ],
                  ),
                ),
              ),

              new Container(
                padding: EdgeInsets.all(15.0),
                child: Text('${this.productDescription}.',
                  style: TextStyle(fontFamily: 'dacts',fontSize: 16.0),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0,left: 5.0),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(key: key,onPressed: (){
        Navigator.push(
          context,
          SlideRightRoute(widget: YourCart(this.database,(){this.key = UniqueKey();setState(() {});})),
        ).then((val){print("one");changeCart();});
      }, label: Text("Rs: ${this.database.total.toStringAsFixed(1)}",style: TextStyle(color: Colors.white.withOpacity(0.9))),icon: Icon(Icons.shopping_basket,color: Colors.white.withOpacity(0.9),),backgroundColor: Colors.lightGreen,),
    );
  }
  Key key = UniqueKey();
  void wishListAdd(){
    if(this.database.wishList.contains(this.productId)){
      this.database.wishList.remove(this.productId);
      this._whishList = false;
      setState(() {});
    }
    else{
      this.database.wishList.add(this.productId);
      this._whishList = true;
      setState(() {});
    }
    sendWishData();
    print(this.database.wishList);
  }
  void increment(){
    double amount2 = (this.priceOfProduct * this.incrementBy) - ((this.priceOfProduct * this.incrementBy) * (this.discount / 100));
    this.database.total = this.database.total + amount2;
    print(this.database.total);
    setState(() {

    });
  }
  void decrement(){
    double amount2 = (this.priceOfProduct * this.incrementBy) - ((this.priceOfProduct * this.incrementBy) * (this.discount / 100));
    this.database.total = this.database.total - amount2;
    print(this.database.total);
    setState(() {

    });
  }
}