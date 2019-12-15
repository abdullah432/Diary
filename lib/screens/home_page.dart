import 'package:diary/model/Story.dart';
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

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int next = pageController.page.round();
      if (currentPage == next) {
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
    return Container(
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
    );
  }
}
