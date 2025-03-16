import 'dart:convert';

import '../../core/base_model.dart';
import 'country_model.dart';

class PropertyType {
  int? id;
  String? nameAr;
  String? nameEn;
  String? name;
  String? createdAt;
  String? updatedAt;

  PropertyType(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.name,
        this.createdAt,
        this.updatedAt});

  PropertyType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
