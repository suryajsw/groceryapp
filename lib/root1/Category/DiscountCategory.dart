import 'package:flutter/material.dart';
import '../DataTypesCustum.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../VariablesValues.dart';
import '../Items.dart';

class Category extends StatefulWidget{
  String category;
  DataBase dataBase;
  Category(this.category,this.dataBase);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isLoaded = false;
  List<String> productList = [];
  List<Map<String,dynamic>> totalCategoryData= [];
  Map<String,String> subCategory = Map();
  List<String> subStr = [];
  int refresh = 0;
  DataBase dataBase;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.dataBase = this.widget.dataBase;
    getCategoryData();
  }
  Key key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (this._isLoaded)? DefaultTabController(
      length: this.subStr.length,
      child: Scaffold(
        //drawer: Draw(this.dataBase),
          key: this._scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text("${this.widget.category}",style: TextStyle(color: Colors.white,fontFamily: 'dacts'),),
//          actions: <Widget>[
//            IconButton(icon: Icon(Icons.add), onPressed: (){
//              setOrderData("DESC");
//            })
//          ],
            bottom: TabBar(
                isScrollable: true,
                tabs: List.generate(this.subStr.length,(index){
                  return Tab(child: new Text("${this.subStr[index]}",style: TextStyle(color: Colors.white70,fontFamily: 'dacts',fontSize: 16.0)),);
                })),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              key: key,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: TabBarView(children: List.generate(this.subStr.length,(index){
                return generateUser(this.subStr[index]);
              })),
            ),
          )
      ),
    ):Scaffold(appBar: AppBar(
      brightness: Brightness.dark,
      title: Text("${this.widget.category}",style: TextStyle(color: Colors.white,fontFamily: 'dacts'),),

    ),
      body: Container(child: Center(child: CircularProgressIndicator(),),),);
  }
  void setProductIdList(){
    //this.productList = [];
    //this.refresh = (this.totalCategoryData.length > this.refresh)?this.refresh:this.totalCategoryData.length;
    for(int i = 0 ; i < this.totalCategoryData.length ; i++){
      this.subCategory["${this.totalCategoryData[i]["subCat"]}"] = "one";
      print(this.totalCategoryData[i]["subCat"]);
    }
    this.subCategory.forEach((key,val){
      this.subStr.add(key);
    });
    this._isLoaded = true;
    this.key = UniqueKey();
    setState(() {});
  }
//  void getCategoryData() async{
//    http.post("$baseUrl/product-details/product/by-categories/listall/index.php",headers: {},body: '{"category":"${this.widget.category}"}').then((response){
//      print(response.body);
//      var dataReq = json.decode(response.body);
//      print(dataReq);
//      for(int i = 0 ; i < dataReq["data"].length;i++){
//        this.totalCategoryData.add(dataReq["data"][i]);
//      }
//      setProductIdList();
//    });
//  }
  void setOrderData(String order) async{
    this.totalCategoryData = [];

    http.post("$baseUrl/product-details/product/by-sort/listall/index.php",headers: {},body: '{"category":"${this.widget.category}","order":"$order"}').then((response){
      print(response.body);
      var dataReq = json.decode(response.body);

      for(int i = 0 ; i < dataReq["data"].length;i++){
        this.totalCategoryData.add(dataReq["data"][i]);
      }
      //print(this.totalCategoryData);
      setProductIdList();
    });
  }
  ListView generateUser(String sub){
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(this.totalCategoryData.length,(index){
        print(this.totalCategoryData[index]["productId"]);
        if(this.totalCategoryData[index]["subCat"] == sub) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new DisplayProduct(this.totalCategoryData[index]["productId"],
                  this.dataBase, () {}),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: new Divider(),
              ),
            ],
          );
        }
        else{
          return Container();
        }
      }),
    );
  }
  void getCategoryData() async{
    http.post("$baseUrl/discount-zone/by-categories/listall/index.php",headers: {},body: '{"category":"${this.widget.category}"}').then((response){
      print(response.body);
      var dataReq = json.decode(response.body);
      print(dataReq);
      for(int i = 0 ; i < dataReq["data"].length;i++){
        this.totalCategoryData.add(dataReq["data"][i]);
      }
      setProductIdList();
    });
  }
}


