// import 'package:etammn/common/models/client_model.dart';
//
// class SystemsModel {
//   int? id;
//   String? deviceNo;
//   ClientModel? client;
//   String? macAddress;
//   String? imei;
//   String? serialNo;
//   String? serviceCode;
//   String? port1;
//   String? port2;
//   String? port3;
//   bool? operatorControl;
//   int? step;
//   bool? hasClientContacts;
//
//   SystemsModel(
//       {this.id,
//         this.deviceNo,
//         this.client,
//         this.macAddress,
//         this.imei,
//         this.serialNo,
//         this.serviceCode,
//         this.port1,
//         this.port2,
//         this.port3,
//         this.operatorControl,
//         this.step,
//         this.hasClientContacts});
//
//   SystemsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     deviceNo = json['deviceNo'];
//     client =
//     json['client'] != null ?  ClientModel.fromJson(json['client']) : null;
//     macAddress = json['macAddress'];
//     imei = json['imei'];
//     serialNo = json['serialNo'];
//     serviceCode = json['serviceCode'];
//     port1 = json['port1'];
//     port2 = json['port2'];
//     port3 = json['port3'];
//     operatorControl = json['operatorControl'];
//     step = json['step'];
//     hasClientContacts = json['hasClientContacts'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     data['id'] = id;
//     data['deviceNo'] = deviceNo;
//     if (client != null) {
//       data['client'] = client!.toJson();
//     }
//     data['macAddress'] = macAddress;
//     data['imei'] = imei;
//     data['serialNo'] = serialNo;
//     data['serviceCode'] = serviceCode;
//     data['port1'] = port1;
//     data['port2'] = port2;
//     data['port3'] = port3;
//     data['operatorControl'] = operatorControl;
//     data['step'] = step;
//     data['hasClientContacts'] = hasClientContacts;
//     return data;
//   }
// }
