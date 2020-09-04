import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:diary/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  TextEditingController nameController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  //selected color index will be saved and in root page will be retrieve and
  //selectedColor will be initialize with the help of this index from list of colors
  int colorIndex = -1;

  @override
  void initState() {
    nameController.text = Constant.name;
    super.initState();
  }

  @override
  dispose() {
    nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.selectedColor,
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80.0,
                  ),
                  // Center(
                  //   child: Container(
                  //     height: 70.0,
                  //     child: Center(
                  //       child: Image(
                  //         image: AssetImage('images/logo.png'),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 40.0,
                  // ),
                  Center(
                    child: Container(
                      // width: MediaQuery.of(context).size.width - 70,
                      child: Text(
                        'SETTING',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                      controller: nameController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                        ),
                      )),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 110.0,
                    child: ListView.builder(
                      itemBuilder: buildContainer,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: RaisedButton(
                      onPressed: () {
                        saveUserNameAndColor();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainer(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Constant.selectedColor = Constant.listOfColors[index];
          colorIndex = index;
        });
      },
      child: Container(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 80,
          // height: 20,
          decoration: BoxDecoration(
            color: Constant.listOfColors[index], //this is the important line
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            border: Border.all(color: Colors.white, width: 4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
      )),
    );
  }

  //save logic
  saveUserNameAndColor() async {
    if (_formKey.currentState.validate()) {
      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();
      if (Constant.name != nameController.text) {
        prefs.setString('name', nameController.text);
        Constant.name = nameController.text;
      }
      //if colorindex not equal to -1 that means user select new color
      if (colorIndex != -1) {
        prefs.setInt('colorIndex', colorIndex);
        Constant.selectedColor = Constant.listOfColors[colorIndex];
      }

      //now navigate to homepage
      navigateToHomePage();
    }
  }

  navigateToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
