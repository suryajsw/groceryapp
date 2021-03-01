import 'package:flutter/material.dart';
import 'SupportFiles/HomePageUi.dart';
import 'dart:convert';
import '../DashBoard/DashBoardView.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userData;
  String email = "checking";
  SharedPreferences pref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async{
    this.pref = await SharedPreferences.getInstance();
    String data = (this.pref.getString('userData') != null)?(this.pref.getString('userData').length !=0)?this.pref.getString('userData'):"":"";
    print("......");
    //print(data);
    if(data.length != 0){
      signIn(data);
    }
    else{
      this.email = "unDefined";
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return routerBuild();
  }

  Widget routerBuild(){
    switch (this.email){
      case "unDefined":
        return UserSignIn(signIn,signIn,signIn);
        break;
      case "checking":
        return Scaffold(body: Container(child: Center(child: CircularProgressIndicator(),),),);
        break;
      default:
        return DashBoard(this.userData,logOut);
        break;
    }
  }
  void logOut() async{
    await this.pref.setString('userData',"");
    this.email = "unDefined";
    setState(() {});
  }
  void signIn(String userData){
    if(userData.contains("userId")) {
      var userInfo = json.decode(userData);
      this.userData = userInfo;
      this.email = this.userData["email"];
      setData(userData);
      setState(() {});
    }
    else{
      this.email = "unDefined";
      setState(() {});
    }
  }
  void setData(String data) async{
    await this.pref.setString('userData',"$data");
  }

}


