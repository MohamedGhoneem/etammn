import 'dart:convert';

import '../../core/base_model.dart';
import 'country_model.dart';

class City {
  int? id;
  String? nameAr;
  String? nameEn;
  String? name;
  int? parentId;
  String? parentType;
  String? createdAt;
  String? updatedAt;
  CountryModel? parent;

  City(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.name,
        this.parentId,
        this.parentType,
        this.createdAt,
        this.updatedAt,
        this.parent});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    name = json['name'];
    parentId = json['parentId'];
    parentType = json['parentType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    parent =
    json['parent'] != null ? new CountryModel.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['parentType'] = this.parentType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}