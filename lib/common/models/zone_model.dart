import 'dart:convert';

import '../../core/base_model.dart';
import 'city_model.dart';
import 'country_model.dart';

class ZoneModel {
  int? id;
  String? name;
  City? city;
  int? cityId;
  String? createdAt;
  String? updatedAt;

  ZoneModel(
      {this.id,
        this.name,
        this.city,
        this.cityId,
        this.createdAt,
        this.updatedAt});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    cityId = json['cityId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['cityId'] = this.cityId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
