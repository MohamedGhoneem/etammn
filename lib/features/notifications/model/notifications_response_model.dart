import 'dart:convert';
import 'package:etammn/core/base_model.dart';

class NotificationsResponseModel extends BaseModel<NotificationsResponseModel> {
  int? status;
  String? message;
  Data? data;

  NotificationsResponseModel({this.status, this.message, this.data});

  NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  NotificationsResponseModel fromJson(Map<String, dynamic>? json) {
    return NotificationsResponseModel.fromJson(json!);
  }

  @override
  NotificationsResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return NotificationsResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}

class Data {
  int? alarmCount;
  int? faultCount;
  int? silenceCount;
  int? resetCount;
  List<NotificationData>? data;

  Data(
      {this.alarmCount,
      this.faultCount,
      this.silenceCount,
      this.resetCount,
      this.data});

  Data.fromJson(Map<String, dynamic> json) {
    alarmCount = json['alarmCount'];
    faultCount = json['faultCount'];
    silenceCount = json['silenceCount'];
    resetCount = json['resetCount'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alarmCount'] = alarmCount;
    data['faultCount'] = faultCount;
    data['silenceCount'] = silenceCount;
    data['resetCount'] = resetCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? title;
  String? body;
  String? type;
  String? buildingName;
  String? sound;
  String? data;
  String? createdAt;

  NotificationData(
      {this.id,
      this.title,
      this.body,
      this.type,
      this.buildingName,
      this.sound,
      this.data,
      this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    buildingName = json['building_name'];
    sound = json['sound'];
    data = json['data'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['type'] = type;
    data['building_name'] = buildingName;
    data['sound'] = sound;
    data['data'] = data;
    data['created_at'] = createdAt;
    return data;
  }
}
