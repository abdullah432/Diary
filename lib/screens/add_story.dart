import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddStory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddStoryState();
  }
}

class AddStoryState extends State<AddStory> {
  final minimumPadding = 5.0;
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Container(
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          getLogoImage(),
          Text('Good (afternoon) (username)',
              style: TextStyle(
                  fontSize: 22, color: Colors.white, fontFamily: 'Raleway')),
          Padding(
            padding: EdgeInsets.only(top: minimumPadding),
            child: Text('ready to create a new story?',
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.only(top: minimumPadding * 20),
            child: FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 1, 1),
                      maxTime: DateTime(2199, 12, 31), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    setState(() {
                      this.date = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        formatDate(date, [MM, ' ', dd]),
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                        color: Colors.white,
                      )
                    ])),
          ),
          RaisedButton(
            color: Colors.white,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'LETS DO IT!',
                style: TextStyle(
                  color: Colors.blueAccent
                  ),
              ),
            ),
          ),
        ],
      ),
    )));
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
      margin:
          EdgeInsets.only(top: minimumPadding * 10, bottom: minimumPadding * 6),
    );
  }
}
