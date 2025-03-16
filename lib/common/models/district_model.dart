import 'dart:async';
import 'zone_model.dart';

class District {
  int? id;
  String? nameAr;
  String? nameEn;
  String? name;
  ZoneModel? zone;
  int? zoneId;
  String? createdAt;
  String? updatedAt;

  District(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.name,
        this.zone,
        this.zoneId,
        this.createdAt,
        this.updatedAt});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    name = json['name'];
    zone = json['zone'] != null ?  ZoneModel.fromJson(json['zone']) : null;
    zoneId = json['zoneId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    data['name'] = this.name;
    if (this.zone != null) {
      data['zone'] = this.zone!.toJson();
    }
    data['zoneId'] = this.zoneId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}