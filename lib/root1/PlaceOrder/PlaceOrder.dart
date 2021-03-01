import 'package:flutter/material.dart';
import '../DataTypesCustum.dart';
import 'package:http/http.dart' as http;
import '../../VariablesValues.dart';
import 'dart:convert';

class PlaceOrder extends StatefulWidget {
  DataBase database;
  List<String> userItem;
  double delivery;
  Function callBack;
  PlaceOrder(this.database,this.userItem,this.callBack,this.delivery);
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  String name = '';
  String phoneNumber = '';
  String address = '';
  String pinCode = ' - ';
  String city = '';
  String errorMsg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(this.widget.userItem);
    getAddress();
  }
  bool sending = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Place ",
              style: TextStyle(color: Colors.white, fontFamily: 'dacts'),
            ),
            Text(
              "Order",
              style: TextStyle(color: Colors.white, fontFamily: 'dacts'),
            ),
          ],
        ),
      ),
      body: (this.sending)?SingleChildScrollView(
        child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 10.0,left: 10.0),
                        child: new Text(
                          "Deliver address :",
                          style: TextStyle(
                              color: Color.fromRGBO(127, 127, 127, 1.0),
                              fontFamily: 'dacts',
                              fontSize: 18.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0,bottom: 10.0,top: 10.0),
                        child: new Text("${this.errorMsg}",style: TextStyle(color: Colors.redAccent,fontFamily: 'dacts',fontSize: 12.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: new FieldTextForm("Name", setAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: new FieldTextForm("Mobile Number", setAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: new FieldTextForm("Address",setAddress),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: new FieldTextForm("City", setAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: Material(

                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {checkValues();},
                              child: new Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'dacts2',fontSize: 18.0),
                              ),
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50.0,
                              color: Colors.lightGreen,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Color.fromRGBO(127, 127, 127, 1.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        child: new Text(
                          "or",
                          style: TextStyle(fontFamily: 'dacts', fontSize: 16.0),
                        ),
                      ),
                    ),
                    new Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Color.fromRGBO(127, 127, 127, 1.0),
                    ),
                  ],
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Delliver To :",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontFamily: 'dacts',
                          fontSize: 22.0),
                    ),
                  ),
                  new Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: (this.loaded) ? [] : [this.addressData],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ):Center(child: Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(16.0),child: Text("Please Wait.",style: TextStyle(color: Colors.lightGreen,fontSize: 22.0,fontFamily: 'dacts'),),),
          CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen),),
        ],
      ),),
    );
  }

  var userAddressData;
  bool loaded = true;
  Widget addressData;
  void getAddress() async {
    String body = '{"userId":"${this.widget.database.userData["userId"]}"}';
    print("///////////////////////");
    print(body);
    http
        .post("$baseUrl/user/details/index.php", headers: {}, body: body)
        .then((response) {
      if (!response.body.contains("error_msg")) {
        print(response.body);
        this.userAddressData = json.decode(response.body);
        print(this.userAddressData);
        this.addressData = Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    "Name : ${this.userAddressData["name"]}",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 127, 127, 1.0),
                        fontFamily: 'dacts',fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    "Mobile Number : ${this.userAddressData["phoneNumber"]}",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 127, 127, 1.0),
                        fontFamily: 'dacts',fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    "Address :${this.userAddressData["address"]}",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 127, 127, 1.0),
                        fontFamily: 'dacts',fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    "City :${this.userAddressData["city"]}",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 127, 127, 1.0),
                        fontFamily: 'dacts',fontSize: 18.0),
                  ),
                ),
                (this.userAddressData["address"].length == 0 || this.userAddressData["phoneNumber"].length == 0 )
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, top: 8.0, right: 5.0),
                        child: Material(
                            child: MaterialButton(
                          onPressed: (){
                            sendOrder(this.userAddressData["name"],this.userAddressData["phoneNumber"],this.userAddressData["address"],this.userAddressData["pinCode"],this.userAddressData["city"]);
                          },
                          child: new Text(
                            "Place this address",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'dacts',fontSize: 18.0),
                          ),
                          minWidth: MediaQuery.of(context).size.width,
                          height: 40.0,
                          color: Colors.lightGreen,
                        )),
                      )
              ],
            ),
          ),
        );
        print(this.userAddressData);
        this.loaded = false;
        setState(() {});
      } else {
        this.userAddressData = {"address": ""};
      }
    });
  }

  void setAddress(String name, String val) {
    switch (name) {
      case "Name":
        this.name = val;
        break;
      case "Mobile Number":
        this.phoneNumber = val;
        break;
      case "Address":
        this.address = val;
        break;
      case "PinCode":
        this.pinCode = val;
        break;
      case "City":
        this.city = val;
        break;
    }
    print("${this.name} - $phoneNumber - $address - $pinCode - $city");
  }
  void checkValues(){
    print(this.phoneNumber.length != 0);
    if(this.phoneNumber.length != 0 && this.address.length != 0){
      sendOrder(this.name,this.phoneNumber,this.address,this.pinCode,this.city);
    }
    else{
      this.errorMsg = "Need every details";
      setState(() {});
    }
  }
  void sendOrder(String name,String phoneNumber,String address,String pinCode,String city) async{

    setState(() {this.sending = false;});
    String addressBody = '{"name":"$name","phoneNumber":"$phoneNumber","address":"$address,$city","pinCode":"$pinCode","city":"$city","total":"${this.widget.database.total + this.widget.delivery}"}';
    String body = '{"userId":"${this.widget.database.userData["userId"]}","cart":${this.widget.userItem},"time":${DateTime.now().millisecondsSinceEpoch},"address": $addressBody,"total":"${this.widget.database.total + this.widget.delivery}"}';
    print(body);
    http.post("$baseUrl/place-order/index.php",headers: {},body: body).then((response){
      print(response.body);
      if(!response.body.contains("Error_msg")){
        //showDialog(context: context,builder:(BuildContext context)=> AlertDialog(title: Text("Your order was placed."),content: SingleChildScrollView(child: Text("You will recieve a call from admin.")),));
        Navigator.pop(context);
        this.widget.database.addToCart = {"product":0.0};
        this.widget.database.total = 0.0;
        this.widget.callBack();
      }
      else{
        this.errorMsg = "Check the internet connection";
        setState(() {this.sending = true;});

      }
    });
  }
}

class FieldTextForm extends StatefulWidget {
  String name;
  Function callBack;
  FieldTextForm(this.name, this.callBack);
  @override
  _FieldTextFormState createState() => _FieldTextFormState();
}

class _FieldTextFormState extends State<FieldTextForm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      style: TextStyle(
          color: Color.fromRGBO(127, 127, 127, 1.0), fontFamily: 'dacts'),
      keyboardType: (this.widget.name == "Phone Number")
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: "${this.widget.name}",
        labelStyle: TextStyle(
            color: Color.fromRGBO(127, 127, 127, 1.0), fontFamily: 'dacts'),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.lightGreen, width: 3.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color.fromRGBO(127, 127, 127, 1.0))),
      ),
      onChanged: (val) {
        this.widget.callBack(this.widget.name,val);
      },
    );
  }
}
