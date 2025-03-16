import 'package:etammn/common/models/contacts_model.dart';

class ClientModel {
  int? id;
  String? username;
  int? clientId;
  int? countryId;
  String? mobile;
  String? lang;
  int? status;
  bool? systemControl;
  var operationLevel;
  var lastLogin;
  String? verifiedMobile;
  String? userType;
  String? avatar;
  String? email;
  String? createdAt;
  String? uuid;
  String? firstName;
  String? lastName;
  List<ContactsModel>? contacts;

  ClientModel(
      {this.id,
        this.username,
        this.clientId,
        this.countryId,
        this.mobile,
        this.lang,
        this.status,
        this.systemControl,
        this.operationLevel,
        this.lastLogin,
        this.verifiedMobile,
        this.userType,
        this.avatar,
        this.email,
        this.createdAt,
        this.uuid,
        this.firstName,
        this.lastName,
        this.contacts
      });

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    clientId = json['clientId'];
    countryId = json['countryId'];
    mobile = json['mobile'];
    lang = json['lang'];
    status = json['status'];
    systemControl = json['systemControl'];
    operationLevel = json['operationLevel'];
    lastLogin = json['lastLogin'];
    verifiedMobile = json['verifiedMobile'];
    userType = json['userType'];
    avatar = json['avatar'];
    email = json['email'];
    createdAt = json['createdAt'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (json['contacts'] != null) {
      contacts = <ContactsModel>[];
      json['contacts'].forEach((v) {
        contacts!.add( ContactsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['clientId'] = clientId;
    data['countryId'] = countryId;
    data['mobile'] = mobile;
    data['lang'] = lang;
    data['status'] = status;
    data['systemControl'] = systemControl;
    data['operationLevel'] = operationLevel;
    data['lastLogin'] = lastLogin;
    data['verifiedMobile'] = verifiedMobile;
    data['userType'] = userType;
    data['avatar'] = avatar;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['uuid'] = uuid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}