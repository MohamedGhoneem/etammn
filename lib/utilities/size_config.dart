import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 500.0;
  static double screenHeight = 500.0;
  static double blockSizeHorizontal = 20.0;
  static double blockSizeVertical = 20.0;
  static double bigTitleFontSize = 24.0;
  static double titleFontSize = 16.0;
  static double tapBarTextFontSize = 10.0;
  static double textFontSize = 14.0;
  static double smallTextFontSize = 13.0;
  static double iconSize = 18.0;
  static double smallIconSize = 15.0;
  static double smallestIconSize = 13.0;
  static double btnHeight = 40.0;
  static double appBarHeight = 55.0;
 static double padding = 8.0;
  static double btnRadius = 16.0;
  static double borderWidth = 1;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    bigTitleFontSize = SizeConfig.blockSizeHorizontal * 5;
    titleFontSize = SizeConfig.blockSizeHorizontal * 4.0;
    textFontSize = SizeConfig.blockSizeHorizontal * 3.0;
    smallTextFontSize = SizeConfig.blockSizeHorizontal * 2.5;
    iconSize = SizeConfig.blockSizeHorizontal * 4;
    smallIconSize = SizeConfig.blockSizeHorizontal * 3.5;
    smallestIconSize = SizeConfig.blockSizeHorizontal * 1.0;
    btnHeight = SizeConfig.blockSizeHorizontal * 10;
    appBarHeight = SizeConfig.blockSizeHorizontal * 12;
    padding = SizeConfig.blockSizeHorizontal * 3;
    btnRadius = SizeConfig.blockSizeHorizontal * 3.5;
  }
}
