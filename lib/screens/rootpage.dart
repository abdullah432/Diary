import 'package:diary/screens/home_page.dart';
import 'package:diary/screens/newUserPage.dart';
import 'package:diary/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RootPageState();
  }
}

class RootPageState extends State<RootPage> {
  bool loadingInProgress = true;
  bool userfound;
  @override
  void initState() {
    //if user name found that mean user already set his/her name and redirect to home_page
    checkUserAccount();
    super.initState();
  }

  checkUserAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('name') ?? '';
    final colorIndex = prefs.getInt('colorIndex') ?? 0;
    //Now initialize selectedColor
    Constant.selectedColor = Constant.listOfColors[colorIndex];
    Constant.name = username;

    if (username.isNotEmpty)
      userfound = true;
    else
      userfound = false;

    setState(() {
      loadingInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loadingInProgress
            ? Center(child: CircularProgressIndicator())
            : (userfound ? HomePage() : NewUserPage()));
  }
}
