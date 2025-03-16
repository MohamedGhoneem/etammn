import '../../../common/models/error_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../model/sign_in_response_model.dart';

class SignInRepo {
  Future<BaseModel> login(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.signInUrl, params, ServerMethods.post);
        return SignInResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
}
