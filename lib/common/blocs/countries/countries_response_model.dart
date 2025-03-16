// import 'dart:convert';
//
// import '../../../core/base_model.dart';
// import '../../models/country_model.dart';
//
// class CountriesResponseModel extends BaseModel<CountriesResponseModel>{
//   int? status;
//   String? message;
//   List<CountryModel>? data;
//
//   CountriesResponseModel({this.status, this.message, this.data});
//
//   CountriesResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <CountryModel>[];
//       json['data'].forEach((v) {
//         data!.add( CountryModel.fromJson(v));
//       });
//     }
//   }
//   @override
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map =  <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data!.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//   @override
//   CountriesResponseModel fromJson(Map<String, dynamic>? json) {
//     // TODO: implement fromJson
//     return CountriesResponseModel.fromJson(json!);
//   }
//
//   @override
//   CountriesResponseModel decodingFromJson(String str) {
//     // TODO: implement decodingFromJson
//     return CountriesResponseModel.fromJson(json.decode(str));
//   }
//
//   @override
//   String encodingToJson() {
//     // TODO: implement encodingToJson
//     return json.encode(toJson());
//   }
// }
