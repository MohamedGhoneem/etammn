
import 'package:etammn/common/models/success_model.dart';

import '../../../common/models/error_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';

class ContactUsRepo {
  Future<BaseModel> contactUs(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.contactUsUrl, params, ServerMethods.post);
        return SuccessModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
}
