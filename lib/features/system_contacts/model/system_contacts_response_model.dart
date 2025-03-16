import 'dart:convert';
import 'package:etammn/common/models/country_model.dart';
import 'package:etammn/core/base_model.dart';


class SystemContactsResponseModel
    extends BaseModel<SystemContactsResponseModel> {
  int? status;
  String? message;
  Data? data;

  SystemContactsResponseModel({this.status, this.message, this.data});

  SystemContactsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  SystemContactsResponseModel fromJson(Map<String, dynamic>? json) {
    return SystemContactsResponseModel.fromJson(json!);
  }

  @override
  SystemContactsResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return SystemContactsResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    // TODO: implement encodingToJson
    return json.encode(toJson());
  }
}

class Data {
  List<SystemContactModel>? data;
  Meta? meta;

  Data({this.data, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SystemContactModel>[];
      json['data'].forEach((v) {
        data!.add( SystemContactModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class SystemContactModel {
  int? id;
  String? name;
  String? mobile;
  String? landline;
  int? countryId;
  CountryModel? country;

  SystemContactModel(
      {this.id,
      this.name,
      this.mobile,
      this.landline,
      this.countryId,
      this.country});

  SystemContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    landline = json['landline'];
    countryId = json['country_id'];
    country =
        json['country'] != null ?  CountryModel.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['landline'] = landline;
    data['country_id'] = countryId;
    if (country != null) {
      data['country'] = country!.toJson();
    }
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['from'] = from;
    data['lastPage'] = lastPage;
    data['pageSize'] = pageSize;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
