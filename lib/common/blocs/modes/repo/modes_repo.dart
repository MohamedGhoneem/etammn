

import '../../../../core/base_model.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/network.dart';
import '../../../models/error_model.dart';
import '../model/modes_response_model.dart';

class ModesRepo {
  Future<BaseModel> getModes() async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.modesUrl, {}, ServerMethods.get);
        return ModesResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

}
