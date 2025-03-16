import '../../../common/models/error_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../../user_management/create_user/model/create_user_response_model.dart';
import '../../users/model/users_response_model.dart';
import '../model/notifications_response_model.dart';

class NotificationsRepo {
  Future<BaseModel> getNotifications() async {
    try {
      try {
        var response = await Network()
            .performRequest(ApiConstants.notificationsUrl, {}, ServerMethods.get);
        return NotificationsResponseModel.fromJson(response.data);
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
