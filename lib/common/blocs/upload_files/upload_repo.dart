import 'package:dio/dio.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../../models/error_model.dart';

class UploadRepo {
  Future uploadFile(FormData body) async {
    try {
      try {
        var response = await Network().performMultipartRequest(
            ApiConstants.uploadFileUrl, body, ServerMethods.post);
        return response;
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

  Future deleteFile(String url) async {
    // try {
    //   try {
    //     var response = await Network().performRequest(
    //         '${ApiConstants.deleteFileUrl}?url=$url', {}, ServerMethods.delete);
    //     return response;
    //   } catch (e) {
    //     return ErrorModel.fromJson(e as dynamic);
    //   }
    // } catch (error) {
    //   ErrorModel errorModel = ErrorModel(status: 500, error: error.toString());
    //   return errorModel;
    // }
  }
}
