import 'dart:convert';

import 'package:etammn/core/base_model.dart';

class CheckCodeResponseModel extends BaseModel<CheckCodeResponseModel>{
  int? status;
  String? message;
  Data? data;

  CheckCodeResponseModel({this.status, this.message, this.data});

  CheckCodeResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map =  <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
  @override
  CheckCodeResponseModel fromJson(Map<String, dynamic>? json) {
    return CheckCodeResponseModel.fromJson(json!);
  }

  @override
  CheckCodeResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return CheckCodeResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}

class Data {
  String? code;

  Data({this.code});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}