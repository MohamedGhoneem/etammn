import 'dart:convert';

import '../../core/base_model.dart';

class CountryModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? name;
  String? iso;
  int? phoneCode;
  bool? hasGovernorates;
  String? createdAt;
  String? updatedAt;

  CountryModel(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.name,
        this.iso,
        this.phoneCode,
        this.hasGovernorates,
        this.createdAt,
        this.updatedAt});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    name = json['name'];
    iso = json['iso'];
    phoneCode = json['phoneCode'];
    hasGovernorates = json['hasGovernorates'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['name'] = name;
    data['iso'] = iso;
    data['phoneCode'] = phoneCode;
    data['hasGovernorates'] = hasGovernorates;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
