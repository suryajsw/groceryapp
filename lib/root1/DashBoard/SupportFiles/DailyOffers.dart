import 'package:flutter/material.dart';
import '../../router.dart';
import '../../DataTypesCustum.dart';
import 'package:http/http.dart' as http;
import '../../../VariablesValues.dart';
import 'dart:convert';
import '../../items2.dart';
import '../../DiscountZone/AllDiscount.dart';
class DailyOffers extends StatefulWidget {
  DataBase passingData;
  Function callBack;
  Function floatingCallBack;
  DailyOffers(this.passingData,this.callBack,this.floatingCallBack);
  @override
  _DailyOffersState createState() => _DailyOffersState();
}

class _DailyOffersState extends State<DailyOffers> {
  DataBase passingData;
  bool _isLoaded = false;
  List<String> dailyOffersProductId = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.passingData = this.widget.passingData;
    getDailyOffers();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: (this._isLoaded)?Container(
            color: Colors.white,
            child: Column(children: <Widget>[
              new Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("images/offer.png"),
                    ),
                    Text(
                      "DAILY",
                      style: TextStyle(fontFamily: 'dacts', fontSize: 18.0),
                    ),
                    Text(
                      " OFFERS",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'dacts',
                          color: Colors.lightGreen),
                    )
                  ],
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(this.dailyOffersProductId.length,(index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new DisplayProduct(this.dailyOffersProductId[index], this.passingData,this.widget.floatingCallBack),
                      new Padding(padding: const EdgeInsets.only(left: 8.0,right: 8.0),child: Divider(),),
                    ],
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Container(
                  height: 30.0,
                  child: new GestureDetector(
                    onTap: (){print("Tapped");
                    Navigator.push(
                      context,
                      SlideRightRoute(widget: AllDiscount(this.passingData,this.widget.callBack)),
                    ).then((val){print(val);});
                    },
                    child: new Text("See all",style: TextStyle(color: Colors.lightGreen,fontFamily: 'dacts',fontSize: 18.0),),
                  ),
                ),
              )
            ])):Container(child: CircularProgressIndicator(),));
  }
  void getDailyOffers() async{
    http.post("$baseUrl/product-details/daily-discount-product/index.php",headers: {},body: '{"auth":"meezanmart"}').then((response){
      if(!response.body.contains("Error_msg")) {
        print(response.body);
        var x = json.decode(response.body);
        for(int i = 0 ; i < x["data"].length ; i++){
          this.dailyOffersProductId.add(x["data"][i]["productId"]);
        }
        this._isLoaded = true;
        setState(() {});
      }
      else{
        this._isLoaded = true;
        this.dailyOffersProductId = [];
        setState(() {});
      }
    });
  }



}

