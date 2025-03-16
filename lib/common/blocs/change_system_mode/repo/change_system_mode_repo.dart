import 'package:etammn/common/models/success_model.dart';

import '../../../../core/base_model.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/network.dart';
import '../../../models/error_model.dart';

class ChangeSystemModeRepo {
  Future<BaseModel> changeSystemMode(
      int? id, Map<String, dynamic> params) async {
    try {
      try {
        var response = await Network().performRequest(
            '${ApiConstants.getSystemDetailsUrl}$id/changemode',
            params,
            ServerMethods.post);
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
