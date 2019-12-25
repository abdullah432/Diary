import 'package:diary/model/GlobalData.dart';
import 'package:diary/model/PhotoHero.dart';
import 'package:diary/model/Story.dart';
import 'package:diary/utils/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveStory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SaveStoryState();
  }
}

class SaveStoryState extends State {
  double minimumPadding = 5.0;
  Story story;
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (BuildContext context) {
            return SizedBox.expand(
                child: Container(
              color: Colors.blueAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                      tag: 'cancel',
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: minimumPadding * 8,
                              right: minimumPadding * 4),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: Image.asset('images/cancelwhite.png'),
                                iconSize: 10,
                                onPressed: () {
                                  moveToLastScreen();
                                }),
                          ))),
                  // Hero(tag: "logo", child: getLogoImage()),
                  Padding(
                    padding: EdgeInsets.only(bottom: minimumPadding * 4),
                    child: PhotoHero(
                      photo: 'images/logo.png',
                      width: 80,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: minimumPadding),
                    child: Text('Give your story a title',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: minimumPadding * 15,
                      left: minimumPadding * 8,
                      right: minimumPadding * 8,
                      bottom: minimumPadding * 8,
                    ),
                    child: TextField(
                      controller: titleConroller,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: 'Add Title ...',
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      onChanged: (value) {
                        GlobalData.title = titleConroller.text;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: minimumPadding * 10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      onPressed: () {
                        saveStory(context);

                        // Route route = EnterExitRoute(
                        //     exitPage: AddStory(), enterPage: FeelingPage());
                        // Navigator.push(context, route);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: minimumPadding * 3,
                            left: minimumPadding * 5,
                            bottom: minimumPadding * 3,
                            right: minimumPadding * 5),
                        child: Text(
                          'SAVE STORY',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
          },
        ));
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
      margin: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding * 5),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

  void saveStory(BuildContext context) async {
    debugPrint('before assign');

    story = new Story(GlobalData.title, GlobalData.date, GlobalData.feeling,
        GlobalData.reason, GlobalData.note);

    debugPrint('second');

    debugPrint(story.title);
    debugPrint(story.feeling);
    debugPrint(story.reason);
    debugPrint(story.date);
    debugPrint(story.note);

    int result = await databaseHelper.insertStory(story);
    if (result != 0) {
      showSnackBar(context, 'Story is Successfully added');
    }
  }

  void showSnackBar(context, msg) {
    SnackBar snackbar = SnackBar(content: Text(msg));
    debugPrint('before snack');
    Scaffold.of(context).showSnackBar(snackbar);
    debugPrint('after snack');
  }
}
