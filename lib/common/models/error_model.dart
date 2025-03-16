import 'dart:convert';

import '../../core/base_model.dart';

class ErrorModel extends BaseModel<ErrorModel> {
  int? status;
  String? message;
  var data;

  ErrorModel({this.status, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = data;
    return data;
  }

  @override
  ErrorModel fromJson(Map<String, dynamic>? json) {
    return ErrorModel.fromJson(json!);
  }

  @override
  ErrorModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return ErrorModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}
