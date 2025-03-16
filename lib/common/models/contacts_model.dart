import 'package:etammn/common/models/country_model.dart';

class ContactsModel {
  int? id;
  String? name;
  String? mobile;
  String? landline;
  int? countryId;
  CountryModel? country;

  ContactsModel(
      {this.id,
        this.name,
        this.mobile,
        this.landline,
        this.countryId,
        this.country});

  ContactsModel.fromJson(Map<String, dynamic> json) {
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