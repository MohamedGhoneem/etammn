import 'package:etammn/core/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';

enum ThemesTypes { light, dark }

class ThemeManagerBloc extends BlocBase {
  BehaviorSubject<ThemesTypes> themeDataSubject =
      BehaviorSubject.seeded(ThemesTypes.light);

  ThemeManagerBloc() {
    if (SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.themeMode) ==
        null) {
      SharedPreferenceHelper.setValueForKey(
          SharedPrefsKeys.themeMode, ThemesTypes.light.name);
      themeDataSubject.sink.add(ThemesTypes.light);
    } else if (SharedPreferenceHelper.getValueForKey(
            SharedPrefsKeys.themeMode) ==
        ThemesTypes.light.name) {
      themeDataSubject.sink.add(ThemesTypes.light);
    } else {
      themeDataSubject.sink.add(ThemesTypes.dark);
    }

    debugPrint(
        'SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.themeMode) : ${SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.themeMode)}');
  }

  void setDarkMode() async {
    SharedPreferenceHelper.setValueForKey(
        SharedPrefsKeys.themeMode, ThemesTypes.dark.name);
    themeDataSubject.sink.add(ThemesTypes.dark);
    debugPrint('setting dark theme');
  }

  void setLightMode() async {
    SharedPreferenceHelper.setValueForKey(
        SharedPrefsKeys.themeMode, ThemesTypes.light.name);
    themeDataSubject.sink.add(ThemesTypes.light);
    debugPrint('setting light theme');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    themeDataSubject.close();
  }
}

ThemeManagerBloc themeManagerBloc = ThemeManagerBloc();
