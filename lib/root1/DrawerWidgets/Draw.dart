
import 'package:flutter/material.dart';
import '../DataTypesCustum.dart';
import '../router.dart';
import '../YourCart/YourCartControler.dart';
import '../WishList/WishList.dart';
import '../YourOrders/YourOrders.dart';
import '../Settings/SettingsControler.dart';
class Draw extends StatelessWidget{
  DataBase dataBase;
  Function callBack;
  Function logOut;
  Draw(this.dataBase,this.callBack,this.logOut);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("${this.dataBase.userData["name"]}",style: TextStyle(color: Colors.white),),
            accountEmail: Text("${this.dataBase.userData["phoneNumber"]}",style: TextStyle(color: Colors.white)),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person,color: Colors.white,),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.lightGreen,
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
          ),
//          InkWell(
//            onTap: (){
//              Navigator.push(
//                context,
//                SlideRightRoute(widget: Scaffold()),
//              ).then((val){print("one");});
//            },
//            child: ListTile(
//              title: Text('Products'),
//              leading: Icon(Icons.dashboard),
//            ),
//          ),

          InkWell(
            onTap: (){
              Navigator.push(
                context,
                SlideRightRoute(widget: YourCart(this.dataBase,this.callBack)),
              ).then((val){print("one");Navigator.pop(context);});
            },
            child: ListTile(
              title: Text('Your Cart'),
              leading: Icon(Icons.shopping_basket),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                SlideRightRoute(widget: WishList(this.dataBase,this.callBack)),
              ).then((val){print("one");Navigator.pop(context);});
            },
            child: ListTile(
              title: Text('Favorite'),
              leading: Icon(Icons.favorite,color: Colors.redAccent,),
            ),
          ),
          new Padding(padding:EdgeInsets.only(left: 4.0,right: 4.0),child: Divider(),),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                SlideRightRoute(widget: Settings(this.dataBase)),
              ).then((val){print("one");});
            },
            child: ListTile(
              title: Text('Profile details'),
              leading: Icon(Icons.settings),
            ),
          ),
          new Padding(padding:EdgeInsets.only(left: 4.0,right: 4.0),child: Divider(),),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                SlideRightRoute(widget: YourOrders(this.dataBase)),
              ).then((val){print("one");});
            },
            child: ListTile(
              title: Text('Your Orders'),
              leading: Icon(Icons.help),
            ),
          ),
          new Padding(padding:EdgeInsets.only(left: 4.0,right: 4.0),child: Divider(),),
          InkWell(
            onTap: (){
              this.logOut();
            },
            child: ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.group),
            ),
          ),
        ],
      ),
    );
  }

}