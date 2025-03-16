import 'dart:ui';
import 'package:etammn/common/blocs/theme/theme_manager_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '../shared_preferences_helper.dart';
import '../shared_preferences_keys.dart';

class AppColors {
  static const Color primaryColor = Color(0xffA61E21);
  static const Color greyColor = Color(0xffAFAFAF);
  static const Color lightGreyColor = Color(0xffCFCFCF);
  static const Color _fontColor = Color(0xFF000000);
  static const Color _darkColor = Color(0xFF555454);
  static const Color whiteColor = Color(0xffffffff);
  static const Color transparentColor = Color(0x00000080);
  static const Color borderColor = Color(0xffE5E5E5);
  static const Color redColor = Color(0xffFF0000);
  static const Color orangeColor = Color(0xffe79111);
  static const Color darkRredColor = Color(0xff610b0b);
  static Color hintColor = Color(0xFF96A0B5);

  static const Color greenColor = Color(0xff2CC536);
  static const Color faultsColor = Color(0xffEFB20B);
  static const Color _backGroundColor = Color(0xffFBFBFB);
  static const Color blueColor = Color(0xff1D7FE1);
  static const Color _profileItemBGColor = Color(0xffE1E1E1);
  static const Color _darkProfileItemBGColor = Color(0xff5c5c5c);
  static const Color resetBtnColor = Color(0xff288CFF);


  static Color fontColor() {
    if (SharedPreferenceHelper.getValueForKey(
        SharedPrefsKeys.themeMode) == null) {
      return _fontColor;
    } else if (SharedPreferenceHelper.getValueForKey(
        SharedPrefsKeys.themeMode) == ThemesTypes.light.name) {
      return _fontColor;
    } else {
      return whiteColor;
    }
  }

  static Color lightFontColor() {
    if (SharedPreferenceHelper.getValueForKey(
        SharedPrefsKeys.themeMode) == null) {
      return _darkColor;
    } else if (SharedPreferenceHelper.getValueForKey(
        SharedPrefsKeys.themeMode) == ThemesTypes.light.name) {
      return _darkColor;
    } else {
      return lightGreyColor;
    }
  }
    static Color backGroundColor() {
      if (SharedPreferenceHelper.getValueForKey(
          SharedPrefsKeys.themeMode) == null) {
        return _backGroundColor;
      } else if (SharedPreferenceHelper.getValueForKey(
          SharedPrefsKeys.themeMode) == ThemesTypes.light.name) {
        return _backGroundColor;
      } else {
        return _darkColor;
      }
    }

    static Color profileItemBGColor() {
      if (SharedPreferenceHelper.getValueForKey(
          SharedPrefsKeys.themeMode) == null) {
        return whiteColor;
      } else if (SharedPreferenceHelper.getValueForKey(
          SharedPrefsKeys.themeMode) == ThemesTypes.light.name) {
        return whiteColor;
      } else {
        return _darkProfileItemBGColor;
      }

    }
  }
