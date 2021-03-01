import 'package:flutter/material.dart';
import 'SupportFiles/DiscountCategories.dart';
import '../DataTypesCustum.dart';
import '../DrawerWidgets/Draw.dart';
import '../YourCart/YourCartControler.dart';
import '../router.dart';

class AllDiscount extends StatefulWidget{
  DataBase dataBase;
  Function callBack;
  AllDiscount(this.dataBase,this.callBack);
  @override
  _AllDiscountState createState() => _AllDiscountState();
}

class _AllDiscountState extends State<AllDiscount> {
  DataBase dataBase;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dataBase = this.widget.dataBase;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //drawer: Draw(this.dataBase),
      key: this._scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white.withOpacity(0.9)),
        backgroundColor: Colors.lightGreen,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "DISCOUNT BY ",
                style: TextStyle(fontFamily: 'dacts',fontSize: 17.0,color: Colors.black.withOpacity(0.6)),
              ),
              Text(
                "CATEGORIES",
                style: TextStyle(fontFamily: 'dacts', color: Colors.white,fontSize: 17.0),
              )
            ],
          ),
        ),
//        leading: IconButton(icon: Icon(Icons.menu,color: Colors.white.withOpacity(0.8),), onPressed: (){this._scaffoldKey.currentState.openDrawer();}),
//        actions: <Widget>[
//          IconButton(icon:Icon(Icons.shopping_cart,color: Colors.white.withOpacity(0.8),), onPressed: (){
//            Navigator.push(
//              context,
//              SlideRightRoute(widget: YourCart(this.dataBase)),
//            ).then((val){print("one");});
//          }),
//          //IconButton(icon:Icon(Icons.account_circle,color: Colors.white.withOpacity(0.8),), onPressed: null),
//        ],
      ),
      body: ShopByCategories(this.dataBase,this.widget.callBack),
//      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text(this.dataBase.total.toStringAsFixed(1)),icon: Icon(Icons.shopping_basket),),
    );
  }
}