import 'dart:convert';
import 'dart:ui';
import 'package:etammn/common/blocs/firebase_token/firebase_token_bloc.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/profile/bloc/profile_bloc.dart';
import 'package:etammn/features/splash/model/refresh_token_response_model.dart';
import 'package:etammn/features/splash/repo/splash_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/blocs/modes/bloc/modes_bloc.dart';
import '../../../common/models/error_model.dart';
import '../../../common/models/success_model.dart';
import '../../../common/request_state.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/localization/locale_helper.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../../../utilities/utilities.dart';
import '../../change_language/bloc/change_language_bloc.dart';
import '../../main_view.dart';
import '../../menu/bloc/menu_bloc.dart';
import '../../notifications/bloc/notifications_bloc.dart';
import '../../sign_in/bloc/sign_in_bloc.dart';
import '../../sign_in/model/sign_in_response_model.dart';
import '../../sign_in/view/sign_in_view.dart';
import '../../users/bloc/users_bloc.dart';
import '../model/profile_response_model.dart';

class SplashBloc extends BlocBase
    with APIBlocMixin<ProfileResponseModel, ErrorModel> {
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  BehaviorSubject<SuccessModel> sendTokenSubject = BehaviorSubject();

  final SplashRepo _splashRepo = SplashRepo();

  init(FirebaseTokenBloc firebaseTokenBloc) {
    SharedPreferenceHelper();
    SharedPreferenceHelper.isPreferencesInitializedStream.listen((data) {
      if (data) {
        helper.onLocaleChanged!(Locale(Utilities.getLanguage()));
        Future.delayed(const Duration(milliseconds: 500), () async {
          print(
              'SharedPreferenceHelper.getValueForKey : ${SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey)}');

          if (SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey) !=
              null) {
            refreshToken(firebaseTokenBloc);
          } else {
            Utilities.navigateAndPop(
              BlocProvider<FirebaseTokenBloc>(
                bloc: FirebaseTokenBloc(),
                child: BlocProvider(
                  bloc: ChangeLanguageBloc(),
                  child: BlocProvider(
                    bloc: SignInBloc(),
                    child: const SignInView(),
                  ),
                ),
              ),
            );
          }
        });
      }
    });
  }

  refreshToken(FirebaseTokenBloc firebaseTokenBloc) async {
    SignInResponseModel _model = SignInResponseModel.fromJson(json.decode(
        SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.userKey)));
    Map<String, dynamic> params = {"refresh_token": _model.refreshToken};
    var model = await _splashRepo.refreshToken(params);
    if (model is RefreshTokenResponseModel) {
      SignInResponseModel signInResponseModel = SignInResponseModel.fromJson(
          json.decode(
              SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.userKey)));
      signInResponseModel.token = model.data?.token;
      signInResponseModel.refreshToken = model.data?.refreshToken;
      SharedPreferenceHelper.setValueForKey(
          SharedPrefsKeys.userKey, signInResponseModel.encodingToJson());
      profileBloc.getProfile();
      modesBloc.getModes();
      firebaseTokenBloc.getDeviceToken();
      Utilities.navigateAndPop(BlocProvider(
          bloc: UsersBloc(),
          child: BlocProvider(
            bloc: NotificationsBloc(),
            child: BlocProvider(bloc: MenuBloc(), child: const MainView()),
          )));
    }
    if (model is ErrorModel) {
      Utilities.navigateAndPop(
        BlocProvider<FirebaseTokenBloc>(
          bloc: FirebaseTokenBloc(),
          child: BlocProvider(
            bloc: ChangeLanguageBloc(),
            child: BlocProvider(
              bloc: SignInBloc(),
              child: const SignInView(),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
