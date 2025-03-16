import 'dart:convert';

import '../../../../common/models/user_model.dart';
import '../../../../core/base_model.dart';
import '../../../users/model/users_response_model.dart';

class CreateUserResponseModel extends BaseModel<CreateUserResponseModel> {
  int? status;
  String? message;
  UserModel? data;

  CreateUserResponseModel({this.status, this.message, this.data});

  CreateUserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  @override
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
  CreateUserResponseModel fromJson(Map<String, dynamic>? json) {
    // TODO: implement fromJson
    return CreateUserResponseModel.fromJson(json!);
  }

  @override
  CreateUserResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return CreateUserResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}

class Client {
  int? id;
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;
  int? status;

  Client(
      {this.id,
      this.uuid,
      this.firstName,
      this.lastName,
      this.email,
      this.avatar,
      this.status});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    avatar = json['avatar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['avatar'] = avatar;
    data['status'] = status;
    return data;
  }
}
