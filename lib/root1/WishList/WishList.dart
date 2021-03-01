import 'package:flutter/material.dart';
import '../DataTypesCustum.dart';
import '../Items.dart';


class WishList extends StatefulWidget {
  DataBase database;
  Function callBack;
  WishList(this.database,this.callBack);
  @override
  _YourCartState createState() => _YourCartState();
}

class _YourCartState extends State<WishList> {
  List<Widget> productCart = [];
//  List<String> productId = [];
  DataBase database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.database = this.widget.database;

    for(int i = 0; i < this.database.wishList.length ; i++){
      this.productCart.add(DisplayProduct(this.database.wishList[i], this.database, () {
        this.widget.callBack();
        //productTotalAmount();
      }));
      this.productCart.add(Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Divider(),
      ));
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Wish ",
              style: TextStyle(color: Colors.white, fontFamily: 'dacts'),
            ),
            Text(
              "List",
              style: TextStyle(color: Colors.white, fontFamily: 'dacts'),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: this.productCart,
            ),
          ),
        ),
      ),
    );
  }
}