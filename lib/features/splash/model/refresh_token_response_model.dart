import 'dart:convert';

import '../../../core/base_model.dart';

class RefreshTokenResponseModel  extends BaseModel<RefreshTokenResponseModel> {
  int? status;
  String? message;
  Data? data;

  RefreshTokenResponseModel({this.status, this.message, this.data});

  RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
  @override
  RefreshTokenResponseModel fromJson(Map<String, dynamic>? json) {
    return RefreshTokenResponseModel.fromJson(json!);
  }

  @override
  RefreshTokenResponseModel decodingFromJson(String str) {
    return RefreshTokenResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    return json.encode(toJson());
  }
}

class Data {
  String? token;
  String? refreshToken;

  Data({this.token, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
