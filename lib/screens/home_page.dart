import 'package:date_format/date_format.dart';
import 'package:diary/model/Story.dart';
import 'package:diary/screens/add_story.dart';
import 'package:diary/screens/settingpage.dart';
import 'package:diary/screens/storydetail.dart';
import 'package:diary/utils/constant.dart';
import 'package:diary/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final PageController pageController = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Story> storyList;

  double height;
  double width;
  bool buttonDown = false;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int next = pageController.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (storyList == null) {
      storyList = new List<Story>();
      updateStoryList();
    }

    return Scaffold(
        body: Stack(children: [
      //PageView
      PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: pageController,
          itemCount: count + 2,
          itemBuilder: (BuildContext context, int currentIndex) {
            if (currentIndex == 0) {
              return introductryPage();
            } else if (currentIndex == 1) {
              // debugPrint(currentPage.toString());
              bool active = currentIndex == currentPage;
              return addNotePage(active);
            } else if (storyList.length + 1 >= currentIndex) {
              // debugPrint('StoryList Length' + storyList.length.toString());
              // debugPrint('currentIndex 1:' + currentIndex.toString());
              bool active = currentIndex == currentPage;
              // debugPrint('currentIndex 2:' + currentIndex.toString());
              return storyPages(
                  storyList[currentIndex - 2], active, currentIndex);
            }
          }),
      //setting button
      Positioned(
          top: 35.0,
          right: 12.0,
          child: GestureDetector(
              onTap: () {
                navigateToSettingPage();
              },
              child: Icon(
                Icons.settings,
                color: Constant.selectedColor,
                size: 30,
              ))),
    ]));
  }

  Widget storyPages(Story storyList, bool active, currentIndex) {
    height = active ? 380 : 350;
    width = active ? 300 : 250;
    return Center(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          StoryDetail(storyList, currentIndex)));
            },
            child: Hero(
              tag: 'hero$currentIndex',
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuint,
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Constant.getImageAsset(storyList),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: 80,
                                child: Text(
                                  formatDate(
                                      Constant.getActiveStoryDate(
                                          storyList.date),
                                      [dd, ' ', MM, ' ', yyyy]),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              )),
                          FlatButton(
                            onPressed: () {
                              showDeleteAlert(storyList);
                            },
                            child: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        ]),
                    Padding(
                      padding: EdgeInsets.only(bottom: 40, left: 20),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            getActiveStoryTitle(storyList),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget introductryPage() {
    return InkWell(
        onTap: () {
          pageController.animateToPage(currentPage + 1,
              curve: Curves.easeOutQuint,
              duration: Duration(microseconds: 1000));
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
              Text(
                'Stories',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 40,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ));
  }

  Widget addNotePage(bool active) {
    // final double h = active ? 390 : 370;
    // final double w = active ? 300 : 240;
    if (!buttonDown) {
      height = active ? 380 : 350;
      width = active ? 300 : 250;
    }

    return Center(
        child: GestureDetector(
            onTapDown: (TapDownDetails details) => addNewStoryBtnClick(),
            onTap: () {
              setState(() {
                height = 370;
                width = 282;
                buttonDown = true;
              });
              navigateToAddStory();
            },
            onTapUp: (TapUpDetails details) => addNoteButtonUp(),
            onTapCancel: () {
              setState(() {
                buttonDown = false;
              });
            },
            child: Hero(
              tag: 'addstory',
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutQuint,
                height: height,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Constant.selectedColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white, size: 80),
                    Container(
                      height: 15,
                    ),
                    Text(
                      "ADD TODAY'S STORY",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Raleway'),
                    ),
                  ],
                ),
              ),
            )));
  }

  void addNewStoryBtnClick() {
    setState(() {
      height = 350;
      width = 282;
      buttonDown = true;
    });
  }

  addNoteButtonUp() {
    setState(() {
      buttonDown = false;
    });
  }

  void navigateToAddStory() async {
    // await new Future.delayed(const Duration(milliseconds: 30));
    // Route route = ScaleRoute(page: AddStory());
    // Navigator.push(context, route);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddStory()));
  }

  navigateToSettingPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingPage()));
  }

  String getActiveStoryTitle(Story storyList) {
    return storyList.title;
  }

  void deleteActiveStory(Story storyList) async {
    int result = await databaseHelper.deleteStory(storyList.id);
    if (result != 0) {
      updateStoryList();
    }
  }

  void showSnackBar(context, msg) {
    SnackBar snackbar = SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void updateStoryList() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Story>> storyListFuture = databaseHelper.getStoryList();
      storyListFuture.then((storyList) {
        setState(() {
          this.storyList = storyList;
          this.count = storyList.length;
        });
      });
    });
  }

  void showDeleteAlert(Story story) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Delete'),
            content: Text("Are You sure you want to delete this story"),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  deleteActiveStory(story);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
