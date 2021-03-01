import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../VariablesValues.dart';
import '../DataTypesCustum.dart';
import 'dart:convert';

class Settings extends StatefulWidget {
  DataBase database;
  Settings(this.database);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Key key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "Profile details",
          style: TextStyle(color: Colors.white, fontFamily: 'dacts'),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Card(
                child: (this.loaded)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Your details",
                                  style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontFamily: 'dacts',
                                      fontSize: 18.0),
                                ),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showBox();
                                    })
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              "Name ${this.userAddressData["name"]}",
                              style: TextStyle(
                                  color: Color.fromRGBO(127, 127, 127, 1.0),
                                  fontFamily: 'dacts'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                    "Mobile Number ${this.userAddressData["phoneNumber"]}",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(127, 127, 127, 1.0),
                                        fontFamily: 'dacts')),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                                "Address ${this.userAddressData["address"]}",
                                style: TextStyle(
                                    color: Color.fromRGBO(127, 127, 127, 1.0),
                                    fontFamily: 'dacts')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                                "City ${this.userAddressData["city"]}",
                                style: TextStyle(
                                    color: Color.fromRGBO(127, 127, 127, 1.0),
                                    fontFamily: 'dacts')),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  var userAddressData;
  bool loaded = false;
  void getData() async {
    this.loaded = false;
    this.key = UniqueKey();
    setState(() {});
    String body = '{"userId":"${this.widget.database.userData["userId"]}"}';
    print(body);
    http
        .post("$baseUrl/user/details/index.php", headers: {}, body: body)
        .then((response) {
      if (!response.body.contains("error_msg")) {
        this.userAddressData = json.decode(response.body);
        this.loaded = true;
        setState(() {});
      } else {}
    });
  }

  void showBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Info"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: new TextField(
                      style: TextStyle(height: 0.8),
                      decoration: InputDecoration(
                          labelText: "Mobile Number",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(127, 127, 127, 1.0),
                                width: 1.0),
                          )),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        this.phoneNumber = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: new TextField(
                      style: TextStyle(height: 0.8),
                      decoration: InputDecoration(
                          labelText: "Address",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(127, 127, 127, 1.0),
                                width: 1.0),
                          )),
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        this.address = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: new TextField(
                      style: TextStyle(height: 0.8),
                      decoration: InputDecoration(
                          labelText: "City",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(127, 127, 127, 1.0),
                                width: 1.0),
                          )),
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        this.city = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new RaisedButton(
                      onPressed: () {
                        saveData();
                      },
                      child: Text("Save"),
                      color: Colors.lightGreen,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void saveData() async {
    http
        .post("$baseUrl/user/update.php",
            headers: {},
            body:
                '{"phoneNumber":"$phoneNumber","address":"$address","pinCode":"xxx","city":"$city","userId":"${this.widget.database.userData["userId"]}"}')
        .then((response) {
      print(response.body);
      if (!response.body.contains("Error_msg")) {
        Navigator.pop(context);
        getData();
      }
    });
  }

  String phoneNumber = '';
  String address = '';
  String pinCode = '';
  String city = '';
}
