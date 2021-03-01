import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'ShowEmail.dart';
import '../../../VariablesValues.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
class UserSignIn extends StatefulWidget {
  Function googleSignIn;
  Function emailSignIn;
  Function emailSignUp;
  UserSignIn(this.googleSignIn, this.emailSignIn, this.emailSignUp);
  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  bool signUp = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (this.signUp)?SignUp(signUpCallback,(String body){
      this.widget.emailSignIn(body);
    }):Scaffold(
      backgroundColor: Colors.white,
      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(image: AssetImage("images/background.jpg"),fit: BoxFit.cover),
//          backgroundBlendMode: BlendMode.luminosity,
//          color: Colors.white.withOpacity(0.4)
//        ),
        child: new SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Image Logo
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Image.asset("images/logo55.jpg",width: MediaQuery.of(context).size.width),
                    ),
                  ),
                ),

                // Email Login
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new TextBox("Mobile Number", (String name, String value) {
                    //print("$name -- $value");
                    this.email = value;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new TextBox("Password", (String name, String value) {
                    //print("$name -- $value");
                    this.password = value;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text(this.error,style: TextStyle(color: Colors.red,fontFamily: 'dacts',fontSize: 10.0),),
                ),
                (this._isLoading)?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    child: new MaterialButton(
                      onPressed: () {
                        validate();
                      },
                      child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 22.0),),
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55.0,
                      color: Color.fromRGBO(221,76,57,1.0),//Color.fromRGBO(184,3,3,1.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black,width: 0.10),
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                    ),
                  ),
                ):Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    child: new MaterialButton(
                      onPressed: () {

                      },
                      child: Text("Loading",style: TextStyle(color: Colors.lightGreen),),
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ),
                ),

                // Or ---

                Padding(
                  padding: EdgeInsets.only(left:( MediaQuery.of(context).size.width * 0.15),right: MediaQuery.of(context).size.width * 0.15,top: 25.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    child: new MaterialButton(
                      onPressed: () {
                        this.signUp = true;
                        setState(() { });
                      },
                      child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 18.0,fontFamily: 'dacts2'),),
                      minWidth: MediaQuery.of(context).size.width,
                      height: 35.0,
                      color: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black,width: 0.10),
                        borderRadius: BorderRadius.circular(0.0),

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height: 0.5,
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new Container(
                          child: Text(
                            "or",style: TextStyle(color: Colors.grey,fontFamily:'dacts2',fontSize: 16.0),
                          ),
                        ),
                      ),
                      new Container(
                        height: 0.5,
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                ),
                // Google Signin
                SignInButton(
                  Buttons.Google,

                  text: "Sign up with Google",
                  onPressed: () {
                    _handleSignIn();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn();
      if(googleSignIn.currentUser.email != null){
        String body = '{"email":"${googleSignIn.currentUser.email}","password":"${googleSignIn.currentUser.id}","name":"${googleSignIn.currentUser.displayName}","method":"google","phoneNumber":"000"}';
      //  print(body);
        http.post("$baseUrl/user/sign-in/google.php",headers: {},body: body).then((response){
       //   print(response.body);
          if(!response.body.contains("Error_msg")){
            this.widget.googleSignIn(response.body);
          }
        });
      }
    } catch (error) {
    //  print(error);
    }
  }
  String email = '';
  String password = '';
  String error = '';
  bool _isLoading = true;
  void validate(){
    this._isLoading=false;
    setState(() {});
    if((this.email.length ==0)){
      this.error = "Need Mobile number";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = true;setState(() {});});});

    }
    else if(this.password.length ==0){
      this.error = "Need password";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = true;setState(() {});});});
    }
    else{
      signInApi();
    }
  }
  void signInApi() async{
    String body = '{"phoneNumber":"${this.email}","password":"${this.password}","method":"signin"}';
    http.post("$baseUrl/user/sign-in/index.php",headers: {},body: body).then((response){
      //print(response.body);
      if(!response.body.contains("Error_msg")){
        //Navigator.pop(context);
        this.widget.googleSignIn(response.body);
      }
      else{
        if(response.body.contains("Password")){
          this.error = "Password is incorrect.";
        }
        if(response.body.contains("Email")){
          this.error = "Mobile number is not registered.";
        }
        this._isLoading=true;
        setState(() {});
      }
    });
  }
  void signUpCallback(){
      this.signUp = false;
      setState(() {});
  }
}

class TextBox extends StatefulWidget {
  String text;
  Function callBack;
  TextBox(this.text, this.callBack);
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      obscureText: (this.widget.text.contains("Password")) ? true : false,
      keyboardType: (this.widget.text.contains("Mobile"))?TextInputType.number:TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey, fontFamily: 'dacts'),
      maxLines: (this.widget.text.contains("Address"))?2:1,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black87, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreen, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: this.widget.text,
          labelStyle: TextStyle(color: Colors.grey, fontFamily: 'dacts2')),
      onChanged: (val) {
        this.widget.callBack(this.widget.text, val);
      },
    );
  }
}

class SignUp extends StatefulWidget{
  Function signIn;
  Function callBack;
  SignUp(this.signIn,this.callBack);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '';
  String password = '';
  String name = '';
  String phoneNumber = '';
  String address = '';
  String error = '';
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                color: Colors.lightGreen,
                child: Padding(

                  padding: const EdgeInsets.only(top: 10.0),
                  child: new Image.asset("images/logo55.jpg",width: MediaQuery.of(context).size.width,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextBox("Name", (String name, String value) {
                  //print("$name -- $value");
                  this.name = value;
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextBox("Mobile Number", (String name, String value) {
                  //print("$name -- $value");
                  this.phoneNumber = value;
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextBox("Address", (String name, String value) {
                  //print("$name -- $value");
                  this.address = value;
                }),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextBox("Password", (String name, String value) {
              //    print("$name -- $value");
                  this.password = value;
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(this.error,style: TextStyle(color: Colors.red,fontFamily: 'dacts2',fontSize: 10.0),)
                  ],
                ),
              ),
              (this._isLoading)?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  child: new MaterialButton(
                    onPressed: () {
                      validate();
                    },
                    child: Text("Register",style: TextStyle(color: Colors.white,fontFamily: 'dacts2',fontSize: 18.0),),
                    minWidth: MediaQuery.of(context).size.width,
                    height: 55.0,
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black,width: 0.1),
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  child: new MaterialButton(
                    onPressed: () {

                    },
                    child: Text("Loading",style: TextStyle(color: Colors.lightGreen),),
                    minWidth: MediaQuery.of(context).size.width,
                    height: 55.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new FlatButton(onPressed: (){this.widget.signIn();}, child: new Text("Go Back",style: TextStyle(fontSize: 18.0),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void validate(){
    this._isLoading = false;
    setState(() {});
    if((this.phoneNumber.length ==0)){
      this.error = "Need Mobile number.";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = true;setState(() {});});});

    }
    else if(this.password.length ==0){
      this.error = "Need password";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = true;setState(() {});});});
    }
    else if(this.address.length ==0){
      this.error = "Need address";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = true;setState(() {});});});
    }
    else if(this.name.length ==0){
      this.error = "Need Name";
      setState(() {});
      Timer(Duration(seconds: 1),(){setState(() {
        this._isLoading = true;setState(() {});});});
    }
    else{
      signUpApi();
    }
  }
  void signUpApi() async{
    //print(this.email);
    //print(this.password);

    String body = '{"phoneNumber":"${this.phoneNumber}","password":"${this.password}","name":"${this.name}","method":"signup","address":"${this.address}"}';
   // print(body);
    http.post("$baseUrl/user/sign-in/index.php",headers: {},body: body).then((response){
      //print(response.body);
      if(!response.body.contains("Error_msg")){
        //Navigator.pop(context);
        this.widget.callBack(response.body);
      }
      else{
        this.error = "Mobile number is already used.";
        setState(() {});
        Timer(Duration(seconds: 1),(){setState(() {
          this._isLoading = true;setState(() {});});});
      }
    });
  }
}
