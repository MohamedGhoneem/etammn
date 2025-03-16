import 'package:flutter/material.dart';

enum Fonts {
  blackItalic,
  bold,
  boldItalic,
  heavy,
  heavyItalic,
  light,
  lightItalic,
  medium,
  mediumItalic,
  regular,
  regularItalic,
  semiBold,
  semiBoldItalic,
  thin,
  thinItalic,
  ultralight,
  ultralightItalic
}

class AppTextStyle {
  static TextStyle style({
    required String fontFamily,
    required double fontSize,
    required Color fontColor,
    TextDecoration? textDecoration,
  }) =>
      TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: fontColor,
          decoration: textDecoration);
}
