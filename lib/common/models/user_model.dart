import 'country_model.dart';
import 'system_item_model.dart';
import '../../features/sign_in/model/sign_in_response_model.dart';

// class UserModel {
//   int? id;
//   String? username;
//   var clientId;
//   String? email;
//   CountryModel? country;
//   List<SystemItemModel>? systems;
//   String? mobile;
//   int? usersControl;
//   var operationLevel;
//   String? password;
//   String? avatar;
//   ClientModel? client;
//   String? createdAt;
//   String? updatedAt;
//
//   int? countryId;
//   String? lang;
//   int? status;
//   String? lastLogin;
//   String? verifiedMobile;
//   String? userType;
//
//   UserModel(
//       {this.id,
//       this.username,
//       this.clientId,
//       this.email,
//       this.country,
//       this.systems,
//       this.mobile,
//       this.usersControl,
//       this.operationLevel,
//       this.password,
//       this.avatar,
//       this.client,
//       this.createdAt,
//       this.updatedAt});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     clientId = json['client_id'];
//     email = json['email'];
//     country =
//         json['country'] != null ? CountryModel.fromJson(json['country']) : null;
//     if (json['systems'] != null) {
//       systems = <SystemItemModel>[];
//       json['systems'].forEach((v) {
//         systems!.add(SystemItemModel.fromJson(v));
//       });
//     }
//     mobile = json['mobile'];
//     usersControl = int.parse(json['users_control'].toString());
//     operationLevel = json['operation_level'];
//     password = json['password'];
//     avatar = json['avatar'];
//     client =
//         json['client'] != null ? ClientModel.fromJson(json['client']) : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//
//     countryId = json['countryId'];
//     lang = json['lang'];
//     status = json['status'];
//     lastLogin = json['lastLogin'];
//     verifiedMobile = json['verifiedMobile'];
//     userType = json['userType'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['username'] = username;
//     data['client_id'] = clientId;
//     data['email'] = email;
//     if (country != null) {
//       data['country'] = country!.toJson();
//     }
//     if (systems != null) {
//       data['systems'] = systems!.map((v) => v.toJson()).toList();
//     }
//     data['mobile'] = mobile;
//     data['users_control'] = usersControl;
//     data['operation_level'] = operationLevel;
//     data['password'] = password;
//     data['avatar'] = avatar;
//     if (client != null) {
//       data['client'] = client!.toJson();
//     }
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//
//     data['countryId'] = countryId;
//     data['lang'] = lang;
//     data['status'] = status;
//     data['lastLogin'] = lastLogin;
//     data['verifiedMobile'] = verifiedMobile;
//     data['userType'] = userType;
//     return data;
//   }
//
// // int? id;
// // String? username;
// // int? clientId;
// // int? countryId;
// // String? mobile;
// // String? lang;
// // int? status;
// // int? usersControl;
// // int? operationLevel;
// // String? lastLogin;
// // String? verifiedMobile;
// // String? userType;
// // String? avatar;
// // String? email;
// // String? createdAt;
// // UserModel(
// //     {this.id,
// //       this.username,
// //       this.clientId,
// //       this.countryId,
// //       this.mobile,
// //       this.lang,
// //       this.status,
// //       this.usersControl,
// //       this.operationLevel,
// //       this.lastLogin,
// //       this.verifiedMobile,
// //       this.userType,
// //       this.avatar,
// //       this.email,
// //       this.createdAt});
// //
// // UserModel.fromJson(Map<String, dynamic> json) {
// //   id = json['id'];
// //   username = json['username'];
// //   clientId = json['clientId'];
// //   countryId = json['countryId'];
// //   mobile = json['mobile'];
// //   lang = json['lang'];
// //   status = json['status'];
// //   usersControl = json['users_control'];
// //   operationLevel = json['operationLevel'];
// //   lastLogin = json['lastLogin'];
// //   verifiedMobile = json['verifiedMobile'];
// //   userType = json['userType'];
// //   avatar = json['avatar'];
// //   email = json['email'];
// //   createdAt = json['createdAt'];
// // }
// //
// // Map<String, dynamic> toJson() {
// //   final Map<String, dynamic> data =  <String, dynamic>{};
// //   data['id'] = id;
// //   data['username'] = username;
// //   data['clientId'] = clientId;
// //   data['countryId'] = countryId;
// //   data['mobile'] =mobile;
// //   data['lang'] = lang;
// //   data['status'] = status;
// //   data['users_control'] = usersControl;
// //   data['operationLevel'] = operationLevel;
// //   data['lastLogin'] = lastLogin;
// //   data['verifiedMobile'] = verifiedMobile;
// //   data['userType'] = userType;
// //   data['avatar'] = avatar;
// //   data['email'] = email;
// //   data['createdAt'] = createdAt;
// //   return data;
// // }
// }


class UserModel {
  int? id;
  String? username;
  int? parentId;
  String? countryKey;
  String? clientUuid;
  String? mobile;
  String? lang;
  int? status;
  int? usersControl;
  String? lastLogin;
  String? userType;
  int? isSuperClient;
  String? avatar;
  String? email;
  int? muteNotifications;
  int? receiveEmailNotifications;
  List<SystemItemModel>? systems;
  CountryModel? country;
  CountryModel? parent;
  String? createdAt;
  String? updatedAt;
  String? mobileVerifiedAt;
  Permissions? permissions;

  UserModel(
      {this.id,
        this.username,
        this.parentId,
        this.countryKey,
        this.clientUuid,
        this.mobile,
        this.lang,
        this.status,
        this.usersControl,
        this.lastLogin,
        this.userType,
        this.isSuperClient,
        this.avatar,
        this.email,
        this.muteNotifications,
        this.receiveEmailNotifications,
        this.systems,
        this.country,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.mobileVerifiedAt,
        this.permissions});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    parentId = json['parent_id'];
    countryKey = json['country_key'];
    clientUuid = json['client_uuid'];
    mobile = json['mobile'];
    lang = json['lang'];
    status = json['status'];
    usersControl = json['users_control'];
    lastLogin = json['last_login'];
    userType = json['userType'];
    isSuperClient = json['is_super_client'];
    avatar = json['avatar'];
    email = json['email'];
    muteNotifications = json['mute_notifications'];
    receiveEmailNotifications = json['receive_email_notifications'];
    if (json['systems'] != null) {
      systems = <SystemItemModel>[];
      json['systems'].forEach((v) {
        systems!.add(SystemItemModel.fromJson(v));
      });
    }
    country =
    json['country'] != null ? CountryModel.fromJson(json['country']) : null;
    parent =
    json['parent'] != null ? CountryModel.fromJson(json['parent']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mobileVerifiedAt = json['mobile_verified_at'];
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['parent_id'] = parentId;
    data['country_key'] = countryKey;
    data['client_uuid'] = clientUuid;
    data['mobile'] = mobile;
    data['lang'] = lang;
    data['status'] = status;
    data['users_control'] = usersControl;
    data['last_login'] = lastLogin;
    data['userType'] = userType;
    data['is_super_client'] = isSuperClient;
    data['avatar'] = avatar;
    data['email'] = email;
    data['mute_notifications'] = muteNotifications;
    data['receive_email_notifications'] = receiveEmailNotifications;
    if (systems != null) {
      data['systems'] = systems!.map((v) => v.toJson()).toList();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['mobile_verified_at'] = mobileVerifiedAt;
    if (permissions != null) {
      data['permissions'] = permissions!.toJson();
    }
    return data;
  }
}
