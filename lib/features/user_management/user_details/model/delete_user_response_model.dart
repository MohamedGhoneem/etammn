import 'dart:convert';

import 'package:etammn/core/base_model.dart';

class DeleteUserResponseModel extends BaseModel<DeleteUserResponseModel>{
  int? status;
  String? message;
  List<dynamic>? data;

  DeleteUserResponseModel({this.status, this.message, this.data});

  DeleteUserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Null>[];
      // json['data'].forEach((v) {
      //   data!.add(new Null.fromJson(v));
      // });
    }
  }
@override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  DeleteUserResponseModel fromJson(Map<String, dynamic>? json) {
    // TODO: implement fromJson
    return DeleteUserResponseModel.fromJson(json!);
  }

  @override
  DeleteUserResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return DeleteUserResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}