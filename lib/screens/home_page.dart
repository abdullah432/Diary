import 'package:diary/model/Story.dart';
import 'package:diary/screens/add_story.dart';
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
      body: PageView.builder(
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
            } else if (storyList.length >= currentIndex) {
              bool active = currentIndex == currentPage;
              return storyPages(storyList[currentIndex - 2], active);
            }
          }),
    );
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

  Widget storyPages(Story storyList, bool active) {
    return AnimatedContainer(
      duration: Duration(microseconds: 500),
      curve: Curves.easeOutQuint,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: getImageAsset(),
        ),
      ),
    );
  }

  AssetImage getImageAsset() {
    AssetImage assetImage = AssetImage('images/forest.jpg');
    return assetImage;
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
      height = active ? 380 : 370;
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
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutQuint,
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent),
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
            )));
  }

  void addNewStoryBtnClick() {
    setState(() {
      height = 370;
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
    await new Future.delayed(const Duration(milliseconds: 200));
    Route route = ScaleRoute(page: AddStory());
    Navigator.push(context, route);
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.5,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
