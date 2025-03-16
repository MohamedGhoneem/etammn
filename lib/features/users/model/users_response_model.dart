import 'dart:convert';

import 'package:etammn/core/base_model.dart';
import '../../../common/models/user_model.dart';

class UsersResponseModel extends BaseModel<UsersResponseModel>{
  int? status;
  String? message;
  List<UserModel>? data;

  UsersResponseModel({this.status, this.message, this.data});

  UsersResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data!.add( UserModel.fromJson(v));
      });
    }
  }
@override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  UsersResponseModel fromJson(Map<String, dynamic>? json) {
    return UsersResponseModel.fromJson(json!);
  }

  @override
  UsersResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return UsersResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}



