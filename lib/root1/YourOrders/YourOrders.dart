import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../DataTypesCustum.dart';
import 'dart:convert';
import '../../VariablesValues.dart';
import '../items2.dart';

class YourOrders extends StatefulWidget {
  DataBase dataBase;
  YourOrders(this.dataBase);
  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  bool _isLoading = false;
  var data;
  List<Widget> list = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.white, fontFamily: 'dacts'),
        ),
      ),
      body: (this._isLoading)
          ? Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: (this.data["data"].length == 0)
                            ? []
                            : List.generate(this.data["data"].length, (index) {
                                if (this.data["data"][index]["status"] == 0 &&
                                    this.data["data"][index]["total"] !=
                                        "0.0") {
                                  return Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                this
                                                    .data["data"][index]
                                                        ["orderItems"]
                                                    .length, (i) {
                                              return DisplayProduct(
                                                  this.data["data"][index]
                                                          ["orderItems"][i]
                                                      ["productId"],
                                                  this.widget.dataBase,
                                                  () {});
                                            }),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  "Address registered :",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          127, 127, 127, 1.0),
                                                      fontFamily: 'dacts'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  "Name : ${this.data["data"][index]["address"]["name"]}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          127, 127, 127, 1.0),
                                                      fontFamily: 'dacts'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  "Phone Number : ${this.data["data"][index]["address"]["phoneNumber"]}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          127, 127, 127, 1.0),
                                                      fontFamily: 'dacts'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  "Address : ${this.data["data"][index]["address"]["address"]}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          127, 127, 127, 1.0),
                                                      fontFamily: 'dacts'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  "City : ${this.data["data"][index]["address"]["city"]}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          127, 127, 127, 1.0),
                                                      fontFamily: 'dacts'),
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: new Text(
                                                    "Total amount :${this.data["data"][index]["total"]}",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: (this.data["data"].length == 1)
                            ? []
                            : List.generate(this.data["data"].length, (index) {
                                if (this.data["data"][index]["status"] == 1) {
                                  return Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                this
                                                    .data["data"][index]
                                                        ["orderItems"]
                                                    .length, (i) {
                                              return DisplayProduct(
                                                  this.data["data"][index]
                                                          ["orderItems"][i]
                                                      ["productId"],
                                                  this.widget.dataBase,
                                                  () {});
                                            }),
                                          ),
                                        ),
                                        new Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                "Deliverd to :",
                                                style: TextStyle(
                                                    color: Colors.lightGreen),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                "Name : ${this.data["data"][index]["address"]["name"]}",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        127, 127, 127, 1.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                "Phone Number : ${this.data["data"][index]["address"]["phoneNumber"]}",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        127, 127, 127, 1.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                "Address : ${this.data["data"][index]["address"]["address"]}",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        127, 127, 127, 1.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                "City : ${this.data["data"][index]["address"]["city"]}",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        127, 127, 127, 1.0)),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  "Total amount :${this.data["data"][index]["total"]}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  void getData() async {
    try {
      String uId = this.widget.dataBase.userData["userId"];
      String body = '{"userId":"$uId"}';
      http
          .post("$baseUrl/order-items/index.php", headers: {}, body: body)
          .then((response) {
        print(response.body);
        if (!response.body.contains("Error_msg")) {
          this.data = json.decode(response.body);
          this._isLoading = true;
          setState(() {});
        } else {
          this.data = {"data": []};
          this._isLoading = true;
          setState(() {});
        }
      });
    } catch (e) {
      this.data = {"data": []};
      this._isLoading = true;
      setState(() {});
    }
  }
}
