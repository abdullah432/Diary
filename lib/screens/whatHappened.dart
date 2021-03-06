import 'package:diary/model/GlobalData.dart';
import 'package:diary/model/PhotoHero.dart';
import 'package:diary/screens/note.dart';
import 'package:diary/screens/saveStory.dart';
import 'package:diary/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhatHappened extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WhatHappenedState();
  }
}

class WhatHappenedState extends State<WhatHappened> {
  double minimumPadding = 5.0;
  bool buttonVisibility = true;
  bool textBoxVisibility = false;

  TextEditingController whatHappenedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SizedBox.expand(
            child: Container(
          color: Constant.selectedColor,
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
                      top: minimumPadding * 4,
                      left: minimumPadding * 4,
                      bottom: minimumPadding * 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Would you like to elaborate on what happened?',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  )),
              Visibility(
                  visible: buttonVisibility,
                  child: Padding(
                    padding: EdgeInsets.only(top: minimumPadding * 25),
                    child: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: minimumPadding * 8,
                          right: minimumPadding * 8,
                          top: minimumPadding * 3,
                          bottom: minimumPadding * 3,
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: Constant.color5,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          yesButtonLogic();
                        });
                      },
                    ),
                  )),
              Visibility(
                  visible: buttonVisibility,
                  child: Padding(
                    padding: EdgeInsets.only(top: minimumPadding * 4),
                    child: FlatButton(
                        child: Text(
                          'No Thanks',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          navigateToNoteScreen();
                        }),
                  )),
              Visibility(
                visible: textBoxVisibility,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: minimumPadding * 5, right: minimumPadding * 4),
                  child: TextField(
                    controller: whatHappenedController,
                    maxLines: 15,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintStyle: TextStyle(color: Colors.white70),
                      hintText: 'Today was ${GlobalData.feeling} because ...',
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    onChanged: (value){
                      GlobalData.whatHappened = whatHappenedController.text;
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: minimumPadding * 3),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                        onPressed: () {
                          navigateToNoteScreen();
                        },
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                              Icons.navigate_next,
                              size: 40.0,
                              color: Colors.white,
                            ),),
                  )))
            ],
          ),
        )));
  }

  navigateToNoteScreen() {
Navigator.push(context, MaterialPageRoute(builder: (context) => Note()));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

  void yesButtonLogic() {
    buttonVisibility = false;
    textBoxVisibility = true;
  }
}
