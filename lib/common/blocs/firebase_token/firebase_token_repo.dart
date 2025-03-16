import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../../models/error_model.dart';

class FirebaseTokenRepo {


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


  Future revokeFirebaseToken(Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network().performRequest(
            ApiConstants.revokeFirebaseTokenUrl, params, ServerMethods.post);
        return response;
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

}
