import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class Carouse extends StatelessWidget{
  List<String> urlImage;
  double ht;
  var passingData;
  Carouse(this.urlImage,this.passingData,{this.ht:200.0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: new SizedBox(
            height: this.ht,
            child: new Carousel(
              dotSize: 6.0,
              dotBgColor: Colors.transparent,
              animationDuration: Duration(milliseconds: 10),
              autoplayDuration: Duration(seconds: 5),
              dotColor: Colors.white.withOpacity(0.8),
              boxFit: BoxFit.fill,
              images: [
                new NetworkImage("${this.urlImage[0]}"),
                new NetworkImage("${this.urlImage[1]}"),
                new NetworkImage("${this.urlImage[2]}"),
              ],
            )
        ),
      ),
    );
  }
}