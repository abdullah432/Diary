import 'package:diary/model/Story.dart';
import 'package:flutter/material.dart';

class StoryDetail extends StatefulWidget {
  final Story story;
  StoryDetail(this.story);

  @override
  State<StatefulWidget> createState() {
    return StoryDetailState(story);
  }
}

class StoryDetailState extends State<StoryDetail> {
  Story story;
  StoryDetailState(this.story);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: SizedBox.expand(
            child: Image(
              image: getImageAsset(story),
            ),
          
          )),
    );
  }

  AssetImage getImageAsset(Story storyList) {
    switch (storyList.reason) {
      case 'Traveling':
        AssetImage assetImage = AssetImage('images/road.jpg');
        return assetImage;
        break;
      case 'Education':
        AssetImage assetImage = AssetImage('images/study.jpg');
        return assetImage;
        break;
      default:
        AssetImage assetImage = AssetImage('images/forest.jpg');
        return assetImage;
        break;
    }
  }
}
