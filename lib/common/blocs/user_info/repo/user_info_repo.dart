import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/network.dart';
import '../../../models/error_model.dart';

class UserInfoRepo {
  Future<dynamic> getUserInfo() async {
    // try {
    //   try {
    //     Response response = await Network()
    //         .performRequest(ApiConstants.getUserInfo, {}, ServerMethods.get);
    //     return response.data;
    //   } catch (e) {
    //     return ErrorModel.fromJson(e as dynamic);
    //   }
    // } catch (error) {
    //   ErrorModel errorModel =
    //       ErrorModel(status: 500,error: error.toString());
    //
    //   return errorModel;
    // }
  }
}
