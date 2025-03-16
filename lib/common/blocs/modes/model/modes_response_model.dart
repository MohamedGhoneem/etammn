import 'dart:convert';

import 'package:etammn/core/base_model.dart';

class ModesResponseModel extends BaseModel<ModesResponseModel> {
  int? status;
  String? message;
  Data? data;

  ModesResponseModel({this.status, this.message, this.data});

  ModesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
@override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  ModesResponseModel fromJson(Map<String, dynamic>? json) {
    // TODO: implement fromJson
    return ModesResponseModel.fromJson(json!);
  }

  @override
  ModesResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return ModesResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}

class Data {
  List<Modes>? modes;
  List<Times>? times;

  Data({this.modes, this.times});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['modes'] != null) {
      modes = <Modes>[];
      json['modes'].forEach((v) {
        modes!.add(new Modes.fromJson(v));
      });
    }
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(new Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.modes != null) {
      data['modes'] = this.modes!.map((v) => v.toJson()).toList();
    }
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modes {
  String? name;
  String? localizedName;
  bool? withDuration;

  Modes({this.name, this.localizedName, this.withDuration});

  Modes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localizedName = json['localized_name'];
    withDuration = json['withDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['localized_name'] = this.localizedName;
    data['withDuration'] = this.withDuration;
    return data;
  }
}

class Times {
  int? time;
  String? localizedName;

  Times({this.time, this.localizedName});

  Times.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    localizedName = json['localized_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['localized_name'] = this.localizedName;
    return data;
  }
}
