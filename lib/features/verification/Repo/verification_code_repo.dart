
import 'package:etammn/core/base_model.dart';
import 'package:etammn/features/verification/check_code_response_model.dart';

import '../../../common/models/error_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';

class VerificationCodeRepo{
  Future<BaseModel> checkCode(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network().performRequest(ApiConstants.checkCodeUrl, params, ServerMethods.post);
        return CheckCodeResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }



}