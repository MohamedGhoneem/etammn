import 'package:dio/dio.dart';
import 'package:etammn/common/models/success_model.dart';

import '../../../common/models/error_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';

class MenuRepo {
  Future muteNotification(int? muteNotification) async {
    try {
      try {
        Response response = await Network().performRequest(ApiConstants.profileUrl,
            {'mute-notification': muteNotification}, ServerMethods.put,
            putOrDeleteParams: {'mute-notification': muteNotification});
        return response;
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel =
          ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
  Future muteEmailNotification(int? muteNotification) async {
    try {
      try {
        Response response = await Network().performRequest(ApiConstants.profileUrl,
            {'receive_email_notifications': muteNotification}, ServerMethods.put,
            putOrDeleteParams: {'receive_email_notifications': muteNotification});
        return response;
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel =
      ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
}
