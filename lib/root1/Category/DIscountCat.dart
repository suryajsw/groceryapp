import 'package:flutter/material.dart';
import '../DataTypesCustum.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../VariablesValues.dart';
import '../Items.dart';

class Category extends StatefulWidget {
  String category;
  DataBase dataBase;
  Category(this.category, this.dataBase);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isLoaded = false;
  List<String> productList = [];
  List<Map<String, dynamic>> totalCategoryData = [];
  int refresh = 0;
  DataBase dataBase;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.dataBase = this.widget.dataBase;
    getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //drawer: Draw(this.dataBase),
      key: this._scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "${this.widget.category}",
          style: TextStyle(color: Colors.white, fontFamily: 'dacts'),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(this.productList.length, (index) {
                  if (this.productList[index] != "load more !") {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new DisplayProduct(
                            this.productList[index], this.dataBase, () {}),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: new Divider(),
                        ),
                      ],
                    );
                  } else {
                    if (this.productList.length == 1) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print("see Extra");
                                //setProductIdList();
                              },
                              child: Container(
                                height: 30.0,
                                child: new Text(
                                  "No discount in this category .!",
                                  style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontFamily: 'dacts',
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (this.totalCategoryData.length != this.refresh) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  print("see Extra");
                                  setProductIdList();
                                },
                                child: Container(
                                  height: 30.0,
                                  child: new Text(
                                    "Load More !",
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontFamily: 'dacts',
                                        fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  }
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setProductIdList() {
    this.productList = [];
    this.refresh = this.refresh + 10;
    this.refresh = (this.totalCategoryData.length > this.refresh)
        ? this.refresh
        : this.totalCategoryData.length;
    for (int i = 0; i < this.refresh; i++) {
      this.productList.add(this.totalCategoryData[i]["productId"]);
    }
    this.productList.add("load more !");
    setState(() {});
  }

  void getCategoryData() async {
    http
        .post("$baseUrl/discount-zone/by-categories/listall/index.php",
            headers: {}, body: '{"category":"${this.widget.category}"}')
        .then((response) {
      print(response.body);
      var dataReq = json.decode(response.body);
      print(dataReq);
      for (int i = 0; i < dataReq["data"].length; i++) {
        this.totalCategoryData.add(dataReq["data"][i]);
      }
      setProductIdList();
    });
  }
}
