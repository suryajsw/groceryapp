import 'package:flutter/material.dart';
import 'SupportFiles/Carosel.dart';
import '../../VariablesValues.dart';
import 'SupportFiles/Categories.dart';
import 'SupportFiles/DailyOffers.dart';
import '../DataTypesCustum.dart';
import '../DrawerWidgets/Draw.dart';
import '../router.dart';
import '../YourCart/YourCartControler.dart';
import 'package:http/http.dart' as http;
import '../../VariablesValues.dart';
import 'dart:convert';
class DashBoard extends StatefulWidget{
  var userData;
  Function logOut;
  DashBoard(this.userData,this.logOut);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DataBase dataBase;
  bool _isLoading = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int nosOfItem = 0;
  @override
  void initState(){
    super.initState();
    getData();
    print(this.dataBase.userData);
    this.dataBase = DataBase(this.widget.userData,[],{"product":0.0},0.0,0.0);
    //productTotalAmount();
  }
  void callBack(){
    this._scaffoldKey = new GlobalKey<ScaffoldState>();
    this.nosOfItem = 0;
    this.dataBase.addToCart.forEach((key,val){
      this.nosOfItem = this.nosOfItem + 1;
    });
    this.nosOfItem = this.nosOfItem - 1;
    this.key = UniqueKey();
    setState(() {});
  }
  void dailyCallback(){
    this.nosOfItem = 0;
    this.dataBase.addToCart.forEach((key,val){
      this.nosOfItem = this.nosOfItem + 1;
    });
    this.nosOfItem = this.nosOfItem - 1;
    this.key = UniqueKey();
    setState(() {});
  }
  Key key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (this._isLoading)?Scaffold(body: Container(child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightGreen,),),),):Scaffold(
      key: this._scaffoldKey,
      drawer: Draw(this.dataBase,this.callBack,this.widget.logOut),
      appBar: AppBar(
        brightness: Brightness.dark,
        title: new Text("MEEZAN ",style: TextStyle(color: Colors.white,fontFamily: 'dacts2',fontSize: 30.0),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed:(){
          this._scaffoldKey.currentState.openDrawer();
        }),
        actions: <Widget>[
          Stack(
            key: key,
            children: <Widget>[
              IconButton(icon:Icon(Icons.shopping_cart,color: Colors.white.withOpacity(0.8),size: 30.0,), onPressed: (){
                Navigator.push(
                  context,
                  SlideRightRoute(widget: YourCart(this.dataBase,this.callBack)),
                ).then((val){print("one");});
              }),
              new Positioned(
                left: 0,
                top: 5.0,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '${this.nosOfItem}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          )
          //IconButton(icon:Icon(Icons.account_circle,color: Colors.white.withOpacity(0.8),), onPressed: null),
        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Carouse(["$baseUrl/carosoel/carosoelDetails/images/image2.png","$baseUrl/carosoel/carosoelDetails/images/image3.png","$baseUrl/carosoel/carosoelDetails/images/image1.png"],this.dataBase),
              new ShopByCategories(this.dataBase,this.callBack),
              new DailyOffers(this.dataBase,this.callBack,this.dailyCallback),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(key: key,onPressed: (){
        Navigator.push(
          context,
          SlideRightRoute(widget: YourCart(this.dataBase,this.callBack)),
        ).then((val){print("one");});
      }, label: Text("Rs: ${this.dataBase.total.toStringAsFixed(1)}",style: TextStyle(color: Colors.white.withOpacity(0.9))),icon: Icon(Icons.shopping_basket,color: Colors.white.withOpacity(0.9),),backgroundColor: Colors.lightGreen),

    );
  }
  void getData() async{
    print("................");
    dataBase = DataBase(this.widget.userData,[],{"product":0.0},0.0,0.0);
    try{
      http.post("$baseUrl/cart-data/index.php",headers: {},body: '{"userId":"${this.widget.userData["userId"]}"}').then((response){
        print(response.body);
        if(!response.body.contains("Error_msg")){
          var x = json.decode(response.body);
          x["data"].forEach((key,value){
            double vv = double.tryParse(value);
            this.dataBase.addToCart[key] = vv;
          });
          getWish();
          productTotalAmount();
        }
        else{
          getWish();
          productTotalAmount();
        }
      });
    }catch(e){
      getWish();
      productTotalAmount();
    }
  }
  void getWish() async{
    try{
      http.post("$baseUrl/wish-data/index.php",headers: {},body: '{"userId":"${this.widget.userData["userId"]}"}').then((response){
        print(response.body);
        if(!response.body.contains("Error_msg")){
          var x = json.decode(response.body);
          for(int i = 0 ; i < x["data"].length ; i++){
            this.dataBase.wishList.add("${x["data"][i]}");
          }
          this.key = UniqueKey();
          this._isLoading = false;
          setState(() {});
          //productTotalAmount();
        }
        else{this._isLoading = false;
        //productTotalAmount();
        setState(() {});}
      });
    }catch(e){
      this._isLoading = false;
      //productTotalAmount();
      setState(() {});
    }
  }
  double totalAmountToBePaid = 0.0;
  double totalDiscountAmount =0.0;
  double total = 0.0;
  void productTotalAmount() async {
    print("................../////");
    this.total = 0.0;
    this.totalDiscountAmount = 0.0;
    this.totalAmountToBePaid = 0.0;
    List<String> productId = [];
    setState(() {});
    this.dataBase.addToCart.forEach((key, values) {
      if (key != "product") {
        productId.add(key);
      }
    });

      http
          .post("$baseUrl/cart-options/cart-amount/index.php",
          headers: {}, body: '{"ids":{"data":$productId}}')
          .then((response) {
        print(response.body);
        if (!response.body.contains("Error_msg")) {
          print("...............///");
          print(response.body);
          var x = json.decode(response.body);

          print(x);
          for (int i = 0; i < x["data"].length; i++) {
            double quantity =
            this.dataBase.addToCart["${x["data"][i]["productId"]}"];
            this.total = this.total + quantity * x["data"][i]["price"];
            this.totalDiscountAmount = this.totalDiscountAmount +
                quantity *
                    (x["data"][i]["price"] * (x["data"][i]["discount"] / 100));
            this.totalAmountToBePaid = this.totalAmountToBePaid +
                ((quantity * x["data"][i]["price"]) -
                    (quantity *
                        (x["data"][i]["price"] *
                            (x["data"][i]["discount"] / 100))));
            print(this.total);
            print(this.totalDiscountAmount);
            this.dataBase.total = this.totalAmountToBePaid;
            String dataOfItem =
                '{"productId":"${x["data"][i]["productId"]}","discount":${x["data"][i]["discount"]},"price":${x["data"][i]["price"]},"quantity":$quantity}';
          }

          setState(() {
            key =UniqueKey();
          });
        }
      });
    this.nosOfItem = 0;
    this.dataBase.addToCart.forEach((key,val){
      this.nosOfItem = this.nosOfItem + 1;
    });
    this.nosOfItem = this.nosOfItem - 1;
    setState(() {key =UniqueKey();});
  }
}

