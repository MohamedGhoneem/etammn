import 'dart:convert';

import 'package:etammn/common/models/country_model.dart';
import 'package:etammn/common/models/user_model.dart';
import 'package:etammn/core/base_model.dart';

import '../../../common/models/contacts_model.dart';

class SystemEventsResponseModel extends BaseModel<SystemEventsResponseModel> {
  int? status;
  String? message;
  Data? data;

  SystemEventsResponseModel({this.status, this.message, this.data});

  SystemEventsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }

  @override
  SystemEventsResponseModel fromJson(Map<String, dynamic>? json) {
    return SystemEventsResponseModel.fromJson(json!);
  }

  @override
  SystemEventsResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return SystemEventsResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}

class Data {
  List<EventModel>? data;
  Meta? meta;

  Data({this.data, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EventModel>[];
      json['data'].forEach((v) {
        data!.add(EventModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta!.toJson();
    }
    return map;
  }
}

class EventModel {
  int? id;
  int? systemId;
  String? gdo;
  int? eventID;
  String? eventType;
  String? transition;
  String? transitionMode;
  var textLocation;
  var zone;
  int? loop;
  int? deviceNumber;
  var deviceType;
  Admin? admin;
  var operator;
  int? routedTo;
  bool? resolved;
  bool? forwarded;
  bool? forwardedTo;
  var note;
  bool? isHandleable;
  String? clientUUID;
  bool? establishing;
  String? recentCommandAt;
  String? commandCounter;
  String? command;
  int? olinet;
  String? acknowledgeBy;
  String? createdAt;
  String? buildingName;
  String? sound;

  EventModel({
    this.id,
    this.systemId,
    this.gdo,
    this.eventID,
    this.eventType,
    this.transition,
    this.transitionMode,
    this.textLocation,
    this.zone,
    this.loop,
    this.deviceNumber,
    this.deviceType,
    this.admin,
    this.operator,
    this.routedTo,
    this.resolved,
    this.forwarded,
    this.forwardedTo,
    this.note,
    this.isHandleable,
    this.clientUUID,
    this.establishing,
    this.recentCommandAt,
    this.commandCounter,
    this.command,
    this.olinet,
    this.acknowledgeBy,
    this.createdAt,
    this.buildingName,
    this.sound,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemId = json['systemId'];
    gdo = json['gdo'];
    eventID = json['eventID'];
    eventType = json['eventType'];
    transition = json['transition'];
    transitionMode = json['transitionMode'];
    textLocation = json['textLocation'];
    zone = json['zone'];
    loop = json['loop'];
    deviceNumber = json['deviceNumber'];
    deviceType = json['deviceType'];
    admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
    operator = json['operator'];
    routedTo = json['routedTo'];
    resolved = json['resolved'];
    forwarded = json['forwarded'];
    forwardedTo = json['forwardedTo'];
    note = json['note'];
    isHandleable = json['isHandleable'];
    clientUUID = json['clientUUID'];
    establishing = json['establishing'];
    recentCommandAt = json['recentCommandAt'];
    commandCounter = json['commandCounter'];
    command = json['command'];
    olinet = json['olinet'];
    acknowledgeBy = json['acknowledgeBy'];
    createdAt = json['createdAt'];
    buildingName = json['building_name'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['systemId'] = systemId;
    data['gdo'] = gdo;
    data['eventID'] = eventID;
    data['eventType'] = eventType;
    data['transition'] = transition;
    data['transitionMode'] = transitionMode;
    data['textLocation'] = textLocation;
    data['zone'] = zone;
    data['loop'] = loop;
    data['deviceNumber'] = deviceNumber;
    data['deviceType'] = deviceType;
    if (admin != null) {
      data['admin'] = admin!.toJson();
    }
    data['operator'] = operator;
    data['routedTo'] = routedTo;
    data['resolved'] = resolved;
    data['forwarded'] = forwarded;
    data['forwardedTo'] = forwardedTo;
    data['note'] = note;
    data['isHandleable'] = isHandleable;
    data['clientUUID'] = clientUUID;
    data['establishing'] = establishing;
    data['recentCommandAt'] = recentCommandAt;
    data['commandCounter'] = commandCounter;
    data['command'] = command;
    data['olinet'] = olinet;
    data['acknowledgeBy'] = acknowledgeBy;
    data['createdAt'] = createdAt;
    data['building_name'] = buildingName;
    data['sound'] = sound;
    return data;
  }
}

class Admin {
  int? id;
  String? username;

  Admin({this.id, this.username});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  int? pageSize;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.pageSize,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    from = json['from'];
    lastPage = json['lastPage'];
    pageSize = json['pageSize'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['from'] = from;
    data['lastPage'] = lastPage;
    data['pageSize'] = pageSize;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
