import 'package:diary/model/Story.dart';
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
      body: Hero(
        tag: 'hero$currentIndex',
        child: Container(
            color: Colors.black,
            child: SizedBox.expand(
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image(
                    image: getImageAsset(story),
                  )),
            )),
      ),
    );
  }

  AssetImage getImageAsset(Story storyList) {
    switch (storyList.reason) {
      case 'Traveling':
        AssetImage assetImage = AssetImage('images/iceforestroad.jpg');
        return assetImage;
        break;
      case 'Education':
        AssetImage assetImage = AssetImage('images/study.jpg');
        return assetImage;
        break;
      case 'Family':
        AssetImage assetImage = AssetImage('images/family2.jpg');
        return assetImage;
        break;
      case 'Food':
        AssetImage assetImage = AssetImage('images/food.jpg');
        return assetImage;
        break;
      case 'Work':
        AssetImage assetImage = AssetImage('images/work2.jpg');
        return assetImage;
        break;
      case 'Friends':
        AssetImage assetImage = AssetImage('images/friends.jpg');
        return assetImage;
        break;
      default:
        AssetImage assetImage = AssetImage('images/milky-way.jpg');
        return assetImage;
        break;
    }
  }
}
