import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../VariablesValues.dart';

class SignUp extends StatefulWidget{
  Function callBack;
  SignUp(this.callBack);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  bool _isLoading = false;
  String error = '';
  String name = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.transparent,
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text("$error",style: TextStyle(fontFamily: 'dacts',fontSize: 14.0,color: Colors.redAccent),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Theme(
                data: new ThemeData(
                    primaryColor: Color.fromRGBO(66, 69, 74, 1.0),
                    //accentColor: Colors.orange,
                    hintColor: Color.fromRGBO(66, 69, 74, 1.0)),
                child: TextField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromRGBO(66, 69, 74, 1.0))),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Color.fromRGBO(66, 69, 74, 1.0),
                    ),
                    hintText: "Name",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(66, 69, 74, 1.0),
                        fontFamily: 'dacts'),
                  ),
                  onChanged: (val) {
                    this.name = val;
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Theme(
                data: new ThemeData(
                    primaryColor: Color.fromRGBO(66, 69, 74, 1.0),
                    //accentColor: Colors.orange,
                    hintColor: Color.fromRGBO(66, 69, 74, 1.0)),
                child: TextField(
                  //obscureText: true,
                  onChanged: (val) {
                    this.email = val;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromRGBO(66, 69, 74, 1.0))),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color.fromRGBO(66, 69, 74, 1.0),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(66, 69, 74, 1.0),
                        fontFamily: 'dacts'),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Theme(
                data: new ThemeData(
                    primaryColor: Color.fromRGBO(66, 69, 74, 1.0),
                    //accentColor: Colors.orange,
                    hintColor: Color.fromRGBO(66, 69, 74, 1.0)),
                child: TextField(
                  obscureText: true,
                  onChanged: (val) {
                      this.password = val;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromRGBO(66, 69, 74, 1.0))),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color.fromRGBO(66, 69, 74, 1.0),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(66, 69, 74, 1.0),
                        fontFamily: 'dacts'),
                  ),
                ),
              ),
            ),

            (this._isLoading)?new Padding(padding: EdgeInsets.all(8.0),
              child: CustumButton("Loading ..",(){

              },Colors.lightGreen.withOpacity(0.7),Colors.lightGreen,45.0,MediaQuery.of(context).size.width,Colors.white),
            ):
            new Padding(padding: EdgeInsets.all(8.0),
              child: CustumButton("Register",(){
                validate();
                this._isLoading = true;
                setState(() {});
              },Colors.lightGreen.withOpacity(0.7),Colors.lightGreen,45.0,MediaQuery.of(context).size.width,Colors.white),
            )
          ],
        ),
      ),
    );
  }
  void validate(){
    if((this.email.length ==0)){
      this.error = "Need email";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = false;setState(() {});});});

    }
    else if(this.password.length ==0){
      this.error = "Need password";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = false;setState(() {});});});
    }
    else if(this.name.length ==0){
      this.error = "Need Name";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = false;setState(() {});});});
    }
    else{
      signUpApi();
    }
  }
  void signUpApi() async{
    print(this.email);
    print(this.password);

    String body = '{"email":"${this.email}","password":"${this.password}","name":"${this.name}","method":"signup"}';
    print(body);
    http.post("$baseUrl/user/sign-in/index.php",headers: {},body: body).then((response){
      print(response.body);
      if(!response.body.contains("Error_msg")){
        Navigator.pop(context);
        this.widget.callBack(response.body);
      }
      else{
        this.error = "Email is already used.";
        setState(() {});
        Timer(Duration(seconds: 1),(){setState(() {
          this._isLoading = false;setState(() {});});});
      }
    });
  }
}
class CustumButton extends StatelessWidget {
  Function onTap;
  String name;
  double height;
  double width;
  Color backGroundColors;
  Color borderColor;
  Color nameColor;
  CustumButton(this.name, this.onTap, this.backGroundColors,
      this.borderColor, this.height, this.width,this.nameColor,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ButtonTheme(
      minWidth: this.width,
      height: this.height,
      child: RaisedButton(
        color: this.backGroundColors,
        onPressed: onTap,
        child: Text(
          "${this.name}",
          style: TextStyle(color: this.nameColor, fontSize: 18.0),
        ),
      ),
    );
  }
}