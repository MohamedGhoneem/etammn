import 'package:etammn/core/bloc_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/blocs/theme/theme_manager_bloc.dart';
import '../../../common/models/error_model.dart';
import '../../../common/models/success_model.dart';
import '../../../common/request_state.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../repo/menu_repo.dart';

class MenuBloc extends BlocBase with APIBlocMixin<SuccessModel, ErrorModel> {
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  BehaviorSubject<bool> pauseNotificationSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> muteEmailNotificationSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> darkModeSubject = BehaviorSubject.seeded(false);
  final MenuRepo _menuRepo = MenuRepo();

  MenuBloc() {
    if (SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.themeMode) ==
        null) {
      darkModeSubject.sink.add(false);
    } else if (SharedPreferenceHelper.getValueForKey(
            SharedPrefsKeys.themeMode) ==
        ThemesTypes.light.name) {
      darkModeSubject.sink.add(false);
    } else {
      darkModeSubject.sink.add(true);
    }

    bool pauseNotification = SharedPreferenceHelper.getValueForKey(
            SharedPrefsKeys.pauseNotification) ??
        false;
    pauseNotificationSubject.sink.add(pauseNotification);
  }

  changeTheme() {
    darkModeSubject.sink.add(!darkModeSubject.value);
    darkModeSubject.value
        ? themeManagerBloc.setDarkMode()
        : themeManagerBloc.setLightMode();
  }

  pauseNotification() async {
    var model = await _menuRepo
        .muteNotification(!pauseNotificationSubject.value ? 1 : 0)
        .then((value) {
      if (value.statusCode == 200) {
        pauseNotificationSubject.sink.add(!pauseNotificationSubject.value);
        SharedPreferenceHelper.setValueForKey(SharedPrefsKeys.pauseNotification,
            pauseNotificationSubject.value ? true : false);
      }
    });
  }
  muteEmailNotification() async {
    var model = await _menuRepo
        .muteEmailNotification(!muteEmailNotificationSubject.value ? 1 : 0)
        .then((value) {
      if (value.statusCode == 200) {
        muteEmailNotificationSubject.sink.add(!muteEmailNotificationSubject.value);
        SharedPreferenceHelper.setValueForKey(SharedPrefsKeys.muteEmailNotification,
            muteEmailNotificationSubject.value ? true : false);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
    pauseNotificationSubject.close();
    muteEmailNotificationSubject.close();
    darkModeSubject.close();
  }
}
