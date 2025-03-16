import 'package:etammn/core/base_model.dart';

import '../../../common/models/error_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../model/profile_response_model.dart';
import '../model/refresh_token_response_model.dart';

class SplashRepo {
  Future sendFirebaseToken(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.sendFirebaseTokenUrl, params, ServerMethods.post);
        return response;
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
  Future refreshToken(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.refreshTokenUrl, params, ServerMethods.post);
        return RefreshTokenResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
  
}
