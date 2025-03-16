
import '../../../common/models/error_model.dart';
import '../../../common/models/success_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../model/dashboard_respons_model.dart';

class DashboardRepo {
  Future<BaseModel> getDashboard() async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.getDashboardUrl, {}, ServerMethods.get);
        return DashboardResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
}
