import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etammn/common/models/success_model.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../features/main_view.dart';
import '../../../features/menu/bloc/menu_bloc.dart';
import '../../../features/notifications/bloc/notifications_bloc.dart';
import '../../../features/users/bloc/users_bloc.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../../../utilities/utilities.dart';
import '../../models/error_model.dart';
import '../../request_state.dart';
import 'firebase_token_repo.dart';

class FirebaseTokenBloc extends BlocBase
    with APIBlocMixin<SuccessModel, ErrorModel> {
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  final FirebaseTokenRepo _firebaseTokenRepo = FirebaseTokenRepo();

  getDeviceToken() {
    FirebaseMessaging.instance
        .getToken(
            // vapidKey:
            // 'BG6MR0Xw6iNUR54ytaWx4uVMvHLqeLwmQHpAkunjjkBb3DA5ivu0J8_aL_lqoVfLR4OyCan4XbozbryI2aki4-8'
            )
        .then((token) {
      if (token != null) {
        log('\n\n\nfirebase token : $token\n\n\n');
        sendFirebaseToken(token);
        FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
          // TODO: If necessary send token to application server.
          sendFirebaseToken(fcmToken);
          // Note: This callback is fired at each app startup and whenever a new
          // token is generated.
        }).onError((err) {
          // Error getting token.
        });
      } else {
        getDeviceToken();
      }
    });
  }

  sendFirebaseToken(String token) async {
    String deviceType = Platform.isIOS ? 'ios' : 'android';
    var model = await _firebaseTokenRepo
        .sendFirebaseToken({'token': token, 'device_type': deviceType});
    // if (model.statusCode == 200) {
    SharedPreferenceHelper.setValueForKey(
        SharedPrefsKeys.firebaseTokenKey, token);
    // } else {
    //   ErrorModel errorModel = ErrorModel(status: 500, message: 'ERROR');
    //   super.errorSubject.sink.add(errorModel);
    // }
  }

  Future revokeFirebaseToken(String token) async {
    Response model =
        await _firebaseTokenRepo.revokeFirebaseToken({'token': token});
    // debugPrint(model.data);
    // if (model.statusCode == 200) {
    //
    // } else {
    //
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
