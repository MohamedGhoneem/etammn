import 'dart:convert';

import '../../core/base_model.dart';
import 'city_model.dart';
import 'country_model.dart';
import 'district_model.dart';
import 'property_type_model.dart';
import 'zone_model.dart';

class Location {
  int? id;
  CountryModel? country;
  int? countryId;
  var governorate;
  var governorateId;
  City? city;
  int? cityId;
  ZoneModel? zone;
  int? zoneId;
  District? district;
  int? districtId;
  PropertyType? propertyType;
  int? propertyTypeId;
  String? streetNo;
  String? streetName;
  String? buildingNo;
  String? buildingName;
  String? floorNo;
  String? flatNo;
  String? postOfficeBox;
  String? levelsNo;
  var longitude;
  var latitude;
  var altitude;

  Location(
      {this.id,
        this.country,
        this.countryId,
        this.governorate,
        this.governorateId,
        this.city,
        this.cityId,
        this.zone,
        this.zoneId,
        this.district,
        this.districtId,
        this.propertyType,
        this.propertyTypeId,
        this.streetNo,
        this.streetName,
        this.buildingNo,
        this.buildingName,
        this.floorNo,
        this.flatNo,
        this.postOfficeBox,
        this.levelsNo,
        this.longitude,
        this.latitude,
        this.altitude});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country =
    json['country'] != null ?  CountryModel.fromJson(json['country']) : null;
    countryId = json['countryId'];
    governorate = json['governorate'];
    governorateId = json['governorateId'];
    city = json['city'] != null ?  City.fromJson(json['city']) : null;
    cityId = json['cityId'];
    zone = json['zone'] != null ?  ZoneModel.fromJson(json['zone']) : null;
    zoneId = json['zoneId'];
    district = json['district'] != null
        ?  District.fromJson(json['district'])
        : null;
    districtId = json['districtId'];
    propertyType = json['propertyType'] != null
        ?  PropertyType.fromJson(json['propertyType'])
        : null;
    propertyTypeId = json['propertyTypeId'];
    streetNo = json['streetNo'];
    streetName = json['streetName'];
    buildingNo = json['buildingNo'];
    buildingName = json['buildingName'];
    floorNo = json['floorNo'];
    flatNo = json['flatNo'];
    postOfficeBox = json['postOfficeBox'];
    levelsNo = json['levelsNo'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    altitude = json['altitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['countryId'] = countryId;
    data['governorate'] = governorate;
    data['governorateId'] = governorateId;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['cityId'] = cityId;
    if (zone != null) {
      data['zone'] = zone!.toJson();
    }
    data['zoneId'] = zoneId;
    if (district != null) {
      data['district'] = district!.toJson();
    }
    data['districtId'] = districtId;
    if (propertyType != null) {
      data['propertyType'] = propertyType!.toJson();
    }
    data['propertyTypeId'] = propertyTypeId;
    data['streetNo'] = streetNo;
    data['streetName'] = streetName;
    data['buildingNo'] = buildingNo;
    data['buildingName'] = buildingName;
    data['floorNo'] = floorNo;
    data['flatNo'] = flatNo;
    data['postOfficeBox'] = postOfficeBox;
    data['levelsNo'] = levelsNo;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['altitude'] = altitude;
    return data;
  }
}