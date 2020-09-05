import 'package:date_format/date_format.dart';
import 'package:diary/model/Story.dart';
import 'package:diary/utils/constant.dart';
import 'package:flutter/material.dart';

class StoryDetail extends StatefulWidget {
  final Story story;
  final int currentIndex;
  StoryDetail(this.story, this.currentIndex);

  @override
  State<StatefulWidget> createState() {
    return StoryDetailState(story, currentIndex);
  }
}

class StoryDetailState extends State<StoryDetail> {
  Story story;
  int currentIndex;
  StoryDetailState(this.story, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        //Full screen image
        Hero(
          tag: 'd',
          // tag: 'hero$currentIndex',
          child: Container(
              color: Colors.black,
              child: SizedBox.expand(
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image(
                      image: Constant.getImageAsset(story),
                    )),
              )),
        ),
        //Draggable Scrollable sheet
        DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.45,
            builder: (context, controller) {
              return SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0, bottom: 15.0),
                      child: Text(
                        formatDate(Constant.getActiveStoryDate(story.date),
                            [dd, ' ', MM, ' ', yyyy]),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0),
                      child: Text(
                        story.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 26),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      // height: double.maxFinite,
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 30.0, bottom: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //heading 1
                            Text(
                              'FEELING',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway',
                                  fontSize: 19.0),
                            ),
                            //space
                            SizedBox(height: 10.0),
                            Text(
                              story.feeling,
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontSize: 19),
                            ),
                            //space
                            SizedBox(height: 20.0),
                            //heading 2
                            Text(
                              'REASON',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway',
                                  fontSize: 19.0),
                            ),
                            //space
                            SizedBox(height: 10.0),
                            Text(
                              story.reason,
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontSize: 19),
                            ),
                            //space
                            SizedBox(height: 20.0),
                            //heading 3
                            Text(
                              'WHAT HAPPENED TODAY',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway',
                                  fontSize: 19.0),
                            ),
                            //space
                            SizedBox(height: 10.0),
                            Text(
                              story.whatHappened != '' ? story.whatHappened : 'You choose to not record it',
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontSize: 19),
                            ),
                            //space
                            SizedBox(height: 20.0),
                            //heading 4
                            Text(
                              'YOUR DAILY NOTES',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway',
                                  fontSize: 19.0),
                            ),
                            //space
                            SizedBox(height: 10.0),
                            Text(
                              story.note != '' ? story.note : 'You choose to not record it',
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontSize: 19),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ],
    ));
  }

}
