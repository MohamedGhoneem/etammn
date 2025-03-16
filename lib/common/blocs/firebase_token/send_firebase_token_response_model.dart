// import 'dart:convert';
//
// import '../../../core/base_model.dart';
//
// class SendFirebaseTokenResponseModel  extends BaseModel<SendFirebaseTokenResponseModel> {
//   int? status;
//   String? message;
//   // List<Null>? data;
//
//   SendFirebaseTokenResponseModel({this.status, this.message});
//
//   SendFirebaseTokenResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     // if (json['data'] != null) {
//     //   data = <Null>[];
//     //   json['data'].forEach((v) {
//     //     data!.add(new Null.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     // if (this.data != null) {
//     //   data['data'] = this.data!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
//
//   @override
//   SendFirebaseTokenResponseModel fromJson(Map<String, dynamic>? json) {
//     return SendFirebaseTokenResponseModel.fromJson(json!);
//   }
//
//   @override
//   SendFirebaseTokenResponseModel decodingFromJson(String str) {
//     // TODO: implement decodingFromJson
//     return SendFirebaseTokenResponseModel.fromJson(json.decode(str));
//   }
//
//   @override
//   String encodingToJson() {
//     // TODO: implement encodingToJson
//     return json.encode(toJson());
//   }
// }