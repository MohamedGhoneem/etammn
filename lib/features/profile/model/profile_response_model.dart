import 'dart:convert';

import 'package:etammn/core/base_model.dart';

import '../../../common/models/user_model.dart';

class ProfileResponseModel extends BaseModel<ProfileResponseModel>{
  int? status;
  String? message;
  UserModel? data;

  ProfileResponseModel({this.status, this.message, this.data});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  UserModel.fromJson(json['data']) : null;
  }
@override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }


  @override
  ProfileResponseModel fromJson(Map<String, dynamic>? json) {
    // TODO: implement fromJson
    return ProfileResponseModel.fromJson(json!);
  }

  @override
  ProfileResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return ProfileResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}
