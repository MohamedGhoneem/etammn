import 'package:etammn/core/base_model.dart';

import '../../../common/models/error_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../model/profile_response_model.dart';

class ProfileRepo {
  Future<BaseModel> getProfile() async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.profileUrl, {}, ServerMethods.get);
        return ProfileResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
  Future<BaseModel> updateProfile(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.profileUrl, params, ServerMethods.put, putOrDeleteParams: params);
        return ProfileResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

}
