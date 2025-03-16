import 'package:etammn/common/models/success_model.dart';
import 'package:etammn/features/system_details/model/system_events_response_model.dart';

import '../../../common/models/error_model.dart';
import '../../../core/base_model.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/network.dart';
import '../model/system_details_response_model.dart';

class SystemDetailsRepo {
  Future<BaseModel> getSystemDetails(int? id) async {
    try {
      try {
        var response = await Network()
            .performRequest('${ApiConstants.getSystemDetailsUrl}$id', {}, ServerMethods.get);
        return SystemDetailsResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

  Future<BaseModel> getSystemEvents(int? id, Map<String,dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest('${ApiConstants.getSystemDetailsUrl}$id/events', params, ServerMethods.get);
        return SystemEventsResponseModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }
  Future<BaseModel> changeSystemMode(int? id, Map<String,dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest('${ApiConstants.getSystemDetailsUrl}$id/changemode', params, ServerMethods.post);
        return SuccessModel.fromJson(response.data);
      } catch (e) {
        return ErrorModel.fromJson(e as dynamic);
      }
    } catch (error) {
      ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
      return errorModel;
    }
  }

  Future<BaseModel> changeSystemCommand(int? id, Map<String,dynamic> params) async {
    try {
      try {
        var response = await Network()
            .performRequest('${ApiConstants.getSystemDetailsUrl}$id/command', params, ServerMethods.post);
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
