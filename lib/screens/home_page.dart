import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final PageController pageController = PageController(viewportFraction: 0.8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: <Widget>[
          Container(color: Colors.yellowAccent,),
          Container(color: Colors.blueAccent,),
          Container(color: Colors.greenAccent,),
        ],
      ),);
  }
}