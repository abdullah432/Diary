import 'package:diary/model/PhotoHero.dart';
import 'package:flutter/material.dart';

class ReasonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReasonPageState();
  }
}

class ReasonPageState extends State<ReasonPage> {
  final minimumPadding = 5.0;
  final reasonsArrayTxt = ["Realationship","Work","Family","Traveling",
  "Food","Education","Exercise","Friends","Others"];
    final reasonsArrayIcon = [Icons.add,Icons.work,Icons.home,Icons.local_airport,
  Icons.fastfood,Icons.edit,Icons.explore,Icons.child_friendly,Icons.more_horiz];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Container(
      color: Colors.blueAccent,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding * 8, right: minimumPadding * 4),
                child: IconButton(
                    icon: Image.asset('images/cancelwhite.png'),
                    iconSize: 10,
                    onPressed: () {
                      moveToLastScreen();
                    }),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: minimumPadding * 4, left: minimumPadding * 4, bottom: minimumPadding * 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Nice - what made today super awesome?',
                  style: TextStyle(color: Colors.white, fontSize: 21.0),
                ),
              )),
              Expanded(child: GridView.count(
                childAspectRatio: (80 / 60), //(itemWidth/itemHeight)
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                primary: false,
                children: List.generate(reasonsArrayTxt.length, (index){
                  return FlatButton(child: Column(children: <Widget>[
                    Icon(reasonsArrayIcon[index], size: 30, color: Colors.white,),
                    Padding(
                      padding: EdgeInsets.only(top: minimumPadding * 2),
                      child: Text(reasonsArrayTxt[index], style: TextStyle(color: Colors.white),),
                    ),
                  ],), onPressed: () {},);
                }),
              ),)
        ],
      ),
    )));
  }

  Widget getLogoImage(String path, double size) {
    AssetImage assetImage = AssetImage(path);
    Image logo = Image(
      image: assetImage,
      width: size,
      height: size,
      color: Colors.white,
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
