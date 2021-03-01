import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../VariablesValues.dart';

class Delivery extends StatefulWidget{
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {

  String condition = "Loading ..";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(left: 4.0,bottom: 10.0,top: 10.0),
        child: Text("${this.condition}",
          style: TextStyle(fontFamily: 'dacts'),),
      ),
    );
  }
  void request() async{
    http.get("$baseUrl/other-details/delivery.php").then((response){
      print("............  Conditions :");
      this.condition = response.body;
      setState(() {});
    });
  }
}