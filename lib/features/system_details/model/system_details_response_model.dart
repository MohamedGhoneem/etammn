import 'dart:convert';
import 'package:etammn/common/models/user_model.dart';
import 'package:etammn/core/base_model.dart';

import '../../../common/blocs/modes/model/modes_response_model.dart';
import '../../../common/models/contacts_model.dart';
import '../../../common/models/location_model.dart';

class SystemDetailsResponseModel extends BaseModel<SystemDetailsResponseModel> {
  int? status;
  String? message;
  Data? data;

  SystemDetailsResponseModel({this.status, this.message, this.data});

  SystemDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
  SystemDetailsResponseModel fromJson(Map<String, dynamic>? json) {
    return SystemDetailsResponseModel.fromJson(json!);
  }

  @override
  SystemDetailsResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return SystemDetailsResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}

class Data {
  int? id;
  String? deviceNo;
  UserModel? client;
  Manufacture? manufacture;
  Brand? brand;
  Model? model;
  BaudRate? baudRate;
  Model? softwareVersion;
  Model? firmwareVersion;
  String? macAddress;
  String? imei;
  String? serialNo;
  String? serviceCode;
  String? port1;
  String? port2;
  String? port3;
  bool? operatorControl;
  int? step;
  bool? hasClientContacts;
  List<ContactsModel>? contacts;
  Location? location;
  bool? isActive;
  bool? isOnline;
  Modes? currentStatus;
  Modes? currentMode;
  num? faultCount;
  num? alarmCount;
  int? systemControl;

  Data({
    this.id,
    this.deviceNo,
    this.client,
    this.manufacture,
    this.brand,
    this.model,
    this.baudRate,
    this.softwareVersion,
    this.firmwareVersion,
    this.macAddress,
    this.imei,
    this.serialNo,
    this.serviceCode,
    this.port1,
    this.port2,
    this.port3,
    this.operatorControl,
    this.step,
    this.hasClientContacts,
    this.contacts,
    this.location,
    this.isActive,
    this.isOnline,
    this.currentStatus,
    this.currentMode,
    this.faultCount,
    this.alarmCount,
    this.systemControl,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceNo = json['deviceNo'];
   // client = json['client'] != null ? UserModel.fromJson(json['client']) : null;
    manufacture = json['manufacture'] != null
        ? Manufacture.fromJson(json['manufacture'])
        : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    baudRate =
        json['baudRate'] != null ? BaudRate.fromJson(json['baudRate']) : null;
    softwareVersion = json['softwareVersion'] != null
        ? Model.fromJson(json['softwareVersion'])
        : null;
    firmwareVersion = json['firmwareVersion'] != null
        ? Model.fromJson(json['firmwareVersion'])
        : null;
    macAddress = json['macAddress'];
    imei = json['imei'];
    serialNo = json['serialNo'];
    serviceCode = json['serviceCode'];
    port1 = json['port1'];
    port2 = json['port2'];
    port3 = json['port3'];
    operatorControl = json['operatorControl'];
    step = json['step'];
    hasClientContacts = json['hasClientContacts'];
    if (json['contacts'] != null) {
      contacts = <ContactsModel>[];
      json['contacts'].forEach((v) {
        contacts!.add(ContactsModel.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    isActive = json['isActive'];
    isOnline = json['isOnline'];
    currentStatus = json['currentStatus']!=null?Modes.fromJson(json['currentStatus']):null;


    currentMode = json['currentMode']!=null?Modes.fromJson(json['currentMode']):null;
    faultCount = json['faultCount'];
    alarmCount = json['alarmCount'];
    systemControl = json['system_control'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceNo'] = deviceNo;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (manufacture != null) {
      data['manufacture'] = manufacture!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (baudRate != null) {
      data['baudRate'] = baudRate!.toJson();
    }
    if (softwareVersion != null) {
      data['softwareVersion'] = softwareVersion!.toJson();
    }
    if (firmwareVersion != null) {
      data['firmwareVersion'] = firmwareVersion!.toJson();
    }
    data['macAddress'] = macAddress;
    data['imei'] = imei;
    data['serialNo'] = serialNo;
    data['serviceCode'] = serviceCode;
    data['port1'] = port1;
    data['port2'] = port2;
    data['port3'] = port3;
    data['operatorControl'] = operatorControl;
    data['step'] = step;
    data['hasClientContacts'] = hasClientContacts;
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['isActive'] = isActive;
    data['isOnline'] = isOnline;
    data['currentStatus'] = currentStatus;
    if(currentMode!=null) {
      data['currentMode'] = currentMode!.toJson();
    }
    data['faultCount'] = faultCount;
    data['alarmCount'] = alarmCount;
    data['system_control'] = systemControl;
    return data;
  }
}

class Manufacture {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Manufacture({this.id, this.name, this.createdAt, this.updatedAt});

  Manufacture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  int? manufacturerId;
  String? createdAt;
  String? updatedAt;

  Brand(
      {this.id,
      this.name,
      this.manufacturerId,
      this.createdAt,
      this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manufacturerId = json['manufacturerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['manufacturerId'] = manufacturerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Model {
  int? id;
  String? name;
  Brand? brand;
  int? brandId;
  String? createdAt;
  String? updatedAt;

  Model(
      {this.id,
      this.name,
      this.brand,
      this.brandId,
      this.createdAt,
      this.updatedAt});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    brandId = json['brandId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['brandId'] = brandId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class BaudRate {
  int? id;
  String? rate;
  String? createdAt;
  String? updatedAt;

  BaudRate({this.id, this.rate, this.createdAt, this.updatedAt});

  BaudRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rate'] = rate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

