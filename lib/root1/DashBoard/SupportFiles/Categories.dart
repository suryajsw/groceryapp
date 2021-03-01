import 'package:flutter/material.dart';
import '../../router.dart';
import '../../Category/CategoryView.dart';
import '../../DataTypesCustum.dart';
class ShopByCategories extends StatelessWidget {
  DataBase passingData;
  Function callBack;
  ShopByCategories(this.passingData,this.callBack);
  void product(BuildContext context, Widget page) {
    Navigator.push(
      context,
      SlideRightRoute(widget: page),
    );
  }
  String fontname = 'dacts22';
  FontWeight weight = FontWeight.w800;
  double widthOfBox = 110.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.white,
          /*borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0))*/),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SHOP BY ",
                      style: TextStyle(fontFamily: 'dacts',fontSize: 20.0,color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      "CATEGORIES",
                      style: TextStyle(fontFamily: 'dacts', color: Colors.white,fontSize: 20.0),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                /*borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0))*/),
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width:this.widthOfBox,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(

                        decoration: BoxDecoration(
                          //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                            border: Border(
                                right: BorderSide(color: Colors.grey, width: 1.0),
                                bottom:
                                BorderSide(color: Colors.grey, width: 1.0))),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              SlideRightRoute(widget: Category("Fruits and Vegetables",this.passingData)),
                            ).then((value){
                              print(value);
                              this.callBack();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/fruits.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Fruits & Veggies",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Fresh Meat",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  right:
                                  BorderSide(color: Colors.grey, width: 1.0),
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/fm.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Fresh Meat",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Bakery & Dairy",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/bakery.jpg",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Bakery & Dairy",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // second row column in categories
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  right:
                                  BorderSide(color: Colors.grey, width: 1.0),
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/house.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Household Needs",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget:Category("Household needs",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget:Category("Baby care",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  right:
                                  BorderSide(color: Colors.grey, width: 1.0),
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/baby.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Baby Care",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Personal care",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/pc.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Personal Care",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // third ...............................................

            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  right:
                                  BorderSide(color: Colors.grey, width: 1.0),
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/grocery.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Grocery & Staples",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Grocery & staples",this.passingData)),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Beverages",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  right:
                                  BorderSide(color: Colors.grey, width: 1.0),
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/b.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Beverages",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Sweets and Food",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/saf.png",

                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Biscuit & Snakes",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ........ Fourth
            Container(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/kit.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Home & Kitchen",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Home & Kitchen",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Instant Foods",this.passingData)),
                      );
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/inst.png",

                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Instant Foods",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: Category("Herbal products",this.passingData)),
                      ).then((val){this.callBack();});
                    },
                    child: Container(
                      width:this.widthOfBox,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(

                          decoration: BoxDecoration(
                            //border: Border(right: BorderSide(color: Colors.grey,width:1.0),bottom: BorderSide(color: Colors.grey,width:1.0)),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                //Image.network("http://akc.org/wp-content/uploads/2015/12/fruits_and_vegetables.jpg",height: 80.0,width: 80.0,)
                                Image.asset(
                                  "images/herb.png",

                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Center(
                                    child: new Text(
                                      "Herbal Products",
                                      style: TextStyle(
                                          fontFamily: this.fontname,fontWeight: this.weight, fontSize: 12.0),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
