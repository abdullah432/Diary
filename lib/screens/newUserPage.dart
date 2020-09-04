import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:diary/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class NewUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewUserPageState();
  }
}

class NewUserPageState extends State<NewUserPage> {
  double initialHeight = 0.0;
  double maxHeight = 75.0;
  double normalHeight = 70.0;
  double logoHeight;
  Duration duration = Duration(milliseconds: 590);
  //Typing text should show after logo animation complete
  bool startTyping = false;
  bool showWidgets = false;
  TextEditingController nameController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  //selected color index will be saved and in root page will be retrieve and
  //selectedColor will be initialize with the help of this index from list of colors
  int colorIndex = 0;

  @override
  void initState() {
    logoHeight = initialHeight;
    Future.delayed(Duration(milliseconds: 80), () {
      startLogoAnimation();
    });
    super.initState();
  }

  @override
  dispose() {
    nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  startLogoAnimation() {
    setState(() {
      logoHeight = maxHeight;
      Future.delayed(Duration(milliseconds: 600), () {
        logozoomOutAnimation();
      });
    });
  }

  logozoomOutAnimation() {
    setState(() {
      duration = Duration(milliseconds: 170);
      logoHeight = normalHeight;
      Future.delayed(Duration(milliseconds: 230), () {
        startTypingAnimation();
      });
    });
  }

  startTypingAnimation() {
    setState(() {
      startTyping = true;
      //start typing animation will take almost 1000 miliseconds
      Future.delayed(Duration(seconds: 4), () {
        showOtherWidgets();
      });
    });
  }

  showOtherWidgets() {
    setState(() {
      showWidgets = true;
    });
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
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: AnimatedContainer(
                      height: logoHeight,
                      duration: duration,
                      curve: Curves.easeIn,
                      child: Center(
                        child: Image(
                          image: AssetImage('images/logo.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  startTyping
                      ? Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 70,
                            child: TyperAnimatedTextKit(
                              speed: Duration(milliseconds: 90),
                              text: ["Keep a diary and someday it'll keep you"],
                              textStyle: TextStyle(
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              displayFullTextOnTap: true,
                              isRepeatingAnimation: false,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    child: AnimatedOpacity(
                      // If the widget is visible, animate to 0.0 (invisible).
                      // If the widget is hidden, animate to 1.0 (fully visible).
                      opacity: showWidgets ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1000),
                      // The green box must be a child of the AnimatedOpacity widget.
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white70),
                        controller: nameController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: "What do your friends call you",
                          labelText: "Your Name",
                          labelStyle:
                              TextStyle(fontSize: 25, color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 110.0,
                    child: AnimatedOpacity(
                      // If the widget is visible, animate to 0.0 (invisible).
                      // If the widget is hidden, animate to 1.0 (fully visible).
                      opacity: showWidgets ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1000),
                      // The green box must be a child of the AnimatedOpacity widget.
                      child: ListView.builder(
                        itemBuilder: buildContainer,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  AnimatedOpacity(
                    // If the widget is visible, animate to 0.0 (invisible).
                    // If the widget is hidden, animate to 1.0 (fully visible).
                    opacity: showWidgets ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 1000),
                    // The green box must be a child of the AnimatedOpacity widget.
                    child: Padding(
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
                  )
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
      prefs.setString('name', nameController.text);
      prefs.setInt('colorIndex', colorIndex);

      //now navigate to homepage
      navigateToHomePage();
    }
  }

  navigateToHomePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
