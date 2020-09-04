import 'package:diary/model/Story.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  static Color selectedColor = color1;

  static Color color1 = Color.fromRGBO(253, 152, 86, 1.0);
  static Color color2 = Color.fromRGBO(235, 223, 217, 1.0);
  static Color color3 = Color.fromRGBO(224, 135, 153, 1.0);
  static Color color4 = Color.fromRGBO(10, 49, 128, 1.0);
  static Color color5 = Color.fromRGBO(30, 32, 41, 1.0);

  static List<Color> listOfColors = [color1, color2, color3, color4, color5];

  //user name
  static String name;

  //functions
  static DateTime getActiveStoryDate(String value) {
    DateTime date = DateTime.parse(value);
    return date;
  }

  //
  static AssetImage getImageAsset(Story storyList) {
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

  //check username and color
  static Future<bool> checkUserAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('name') ?? '';
    final colorIndex = prefs.getInt('colorIndex') ?? 0;
    //Now initialize selectedColor
    Constant.selectedColor = Constant.listOfColors[colorIndex];
    Constant.name = username;

    if (username.isNotEmpty)
      return true;
    else
      return false;
  }

  //check morning, evening, afternon
  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
