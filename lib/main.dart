import 'package:diary/screens/rootpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cursorColor: Colors.white54,
      ),
      home: RootPage(),
    );
  }
}
