import 'dart:convert';

import 'package:etammn/common/models/system_item_model.dart';

import '../../../core/base_model.dart';
import '../../sign_in/model/sign_in_response_model.dart';

class DashboardResponseModel  extends BaseModel<DashboardResponseModel>{
  int? status;
  String? message;
  List<SystemItemModel>? data;

  DashboardResponseModel({this.status, this.message, this.data});

  DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SystemItemModel>[];
      json['data'].forEach((v) {
        data!.add( SystemItemModel.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  DashboardResponseModel fromJson(Map<String, dynamic>? json) {
    return DashboardResponseModel.fromJson(json!);
  }

  @override
  DashboardResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return DashboardResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}
