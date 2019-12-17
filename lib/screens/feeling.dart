import 'package:diary/model/PhotoHero.dart';
import 'package:flutter/material.dart';

class FeelingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FeelingPageState();
  }
}

class FeelingPageState extends State<FeelingPage> {
  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Container(
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: minimumPadding * 8, left: minimumPadding * 3),
            child: Align(
                alignment: Alignment.topLeft,
                child: PhotoHero(
                  photo: 'images/logo.png',
                  width: 55,
                )),
          ),
          // Hero(
          //     tag: 'cancel',
          //     child: Padding(
          //         padding: EdgeInsets.only(
          //             top: minimumPadding * 8, right: minimumPadding * 4),
          //         child: Align(
          //           alignment: Alignment.topRight,
          //           child: IconButton(
          //               icon: Image.asset('images/cancelwhite.png'),
          //               iconSize: 10,
          //               onPressed: () {
          //                 moveToLastScreen();
          //               }),
          //         ))),
        ],
      ),
    )));
  }

  Widget getLogoImage() {
    AssetImage assetImage = AssetImage('images/logo.png');
    Image logo = Image(
      image: assetImage,
      width: 80,
      height: 80,
    );
    return Container(
      child: logo,
      margin:
          EdgeInsets.only(top: minimumPadding * 5, left: minimumPadding * 5),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
