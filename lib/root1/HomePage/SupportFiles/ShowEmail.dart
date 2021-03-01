import 'package:flutter/material.dart';
import 'SignIn.dart';
import 'signup.dart';
class Customer extends ModalRoute<void> {
  Function login;
  Function register;
  Customer(this.login,this.register);
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;
  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }
  Widget _buildOverlayContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: TabBar(tabs: [
                    Tab(
                      child: new Text("LOGIN",style: TextStyle(color: Colors.blueGrey),),
                    ),
                    Tab(
                      child: new Text("REGISTER",style: TextStyle(color: Colors.blueGrey),),
                    ),
                  ],indicatorColor: Colors.lightGreen,),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 300.0,
                    child: TabBarView(children: [
                      Container(
                      color: Colors.white,
                        child: SignIn(this.login),
                      ),
                      Container(
                        color: Colors.white,
                        child: SignUp(this.register),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}