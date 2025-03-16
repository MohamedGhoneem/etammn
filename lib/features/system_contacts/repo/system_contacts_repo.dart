import '../../../common/models/error_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../model/system_contacts_response_model.dart';

class SystemContactsRepo {
  Future<BaseModel> getSystemContacts(int? id, int? page) async {
    try {
      try {
        var response = await Network().performRequest(
            '${ApiConstants.getSystemDetailsUrl}$id/contacts?page=$page&pageSize=20',
            {},
            ServerMethods.get);
        return SystemContactsResponseModel.fromJson(response.data);
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
