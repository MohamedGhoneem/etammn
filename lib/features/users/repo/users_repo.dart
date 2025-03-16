import 'package:etammn/common/models/success_model.dart';

import '../../../common/models/error_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../../user_management/create_user/model/create_user_response_model.dart';
import '../model/users_response_model.dart';

class UsersRepo {
  Future<BaseModel> getUsers() async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.usersUrl, {}, ServerMethods.get);
        return UsersResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel =
          ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

  Future<BaseModel> createUser(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.usersUrl, params, ServerMethods.post, putOrDeleteParams: params);
        return CreateUserResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel =
          ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

  Future<BaseModel> editUser(Map<String, dynamic> params, int? id) async {
    try {
      try {
        var response = await Network().performRequest(
            '${ApiConstants.usersUrl}/$id', {}, ServerMethods.put,putOrDeleteParams: params);
        return CreateUserResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel =
          ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

  Future<BaseModel> deleteUser(int? id) async {
    try {
      try {
        var response = await Network().performRequest(
            '${ApiConstants.usersUrl}/$id', {}, ServerMethods.delete,
            putOrDeleteParams: {});
        return SuccessModel.fromJson(response.data);
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
