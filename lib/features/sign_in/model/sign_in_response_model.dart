
import 'dart:convert';

import '../../../common/models/location_model.dart';
import '../../../common/models/user_model.dart';
import '../../../core/base_model.dart';

// class SignInResponseModel extends BaseModel<SignInResponseModel> {
//   int? status;
//   String? message;
//  // List<Null>? data;
//   String? token;
//   String? refreshToken;
//   UserModel? user;
//
//   SignInResponseModel(
//       {this.status, this.message,
//         // this.data,
//         this.token,
//         this.refreshToken,
//         this.user});
//
//   SignInResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     // if (json['data'] != null) {
//     //   data = <Null>[];
//     //   json['data'].forEach((v) {
//     //     data!.add(new Null.fromJson(v));
//     //   });
//     // }
//     token = json['token'];
//     refreshToken = json['refresh_token'];
//     user = json['user'] != null ?  UserModel.fromJson(json['user']) : null;
//   }
//   @override
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     // if (this.data != null) {
//     //   data['data'] = this.data!.map((v) => v.toJson()).toList();
//     // }
//     data['token'] = token;
//     data['refresh_token'] = refreshToken;
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     return data;
//   }
//
//
//   @override
//   SignInResponseModel fromJson(Map<String, dynamic>? json) {
//     // TODO: implement fromJson
//     return SignInResponseModel.fromJson(json!);
//   }
//
//   @override
//   SignInResponseModel decodingFromJson(String str) {
//     // TODO: implement decodingFromJson
//     return SignInResponseModel.fromJson(json.decode(str));
//   }
//
//   @override
//   String encodingToJson() {
//     // TODO: implement encodingToJson
//     return json.encode(toJson());
//   }
// }


class SignInResponseModel  extends BaseModel<SignInResponseModel> {
  int? status;
  String? message;
  // List<Null>? data;
  String? token;
  String? refreshToken;
  UserModel? user;

  SignInResponseModel(
      {this.status,
        this.message,
        // this.data,
        this.token,
        this.refreshToken,
        this.user});

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // if (json['data'] != null) {
    //   data = <Null>[];
    //   json['data'].forEach((v) {
    //     data!.add(Null.fromJson(v));
    //   });
    // }
    token = json['token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    // if (this.data != null) {
    //   data['data'] = this.data!.map((v) => v.toJson()).toList();
    // }
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  SignInResponseModel fromJson(Map<String, dynamic>? json) {
    // TODO: implement fromJson
    return SignInResponseModel.fromJson(json!);
  }

  @override
  SignInResponseModel decodingFromJson(String str) {
    // TODO: implement decodingFromJson
    return SignInResponseModel.fromJson(json.decode(str));
  }

  @override
  String encodingToJson() {
    return json.encode(toJson());
  }
}



class CurrentStatus {
  String? name;
  String? localizedName;

  CurrentStatus({this.name, this.localizedName});

  CurrentStatus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localizedName = json['localized_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['localized_name'] = localizedName;
    return data;
  }
}


class Parent {
  int? id;
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  Null? avatar;
  int? status;

  Parent(
      {this.id,
        this.uuid,
        this.firstName,
        this.lastName,
        this.email,
        this.avatar,
        this.status});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    avatar = json['avatar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['avatar'] = avatar;
    data['status'] = status;
    return data;
  }
}

class Permissions {
  Monitoring? monitoring;
  Monitoring? systems;
  Monitoring? clients;
  Monitoring? clientUsers;

  Permissions({this.monitoring, this.systems, this.clients, this.clientUsers});

  Permissions.fromJson(Map<String, dynamic> json) {
    monitoring = json['monitoring'] != null
        ? Monitoring.fromJson(json['monitoring'])
        : null;
    systems = json['systems'] != null
        ? Monitoring.fromJson(json['systems'])
        : null;
    clients = json['clients'] != null
        ? Monitoring.fromJson(json['clients'])
        : null;
    clientUsers = json['clientUsers'] != null
        ? Monitoring.fromJson(json['clientUsers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monitoring != null) {
      data['monitoring'] = monitoring!.toJson();
    }
    if (systems != null) {
      data['systems'] = systems!.toJson();
    }
    if (clients != null) {
      data['clients'] = clients!.toJson();
    }
    if (clientUsers != null) {
      data['clientUsers'] = clientUsers!.toJson();
    }
    return data;
  }
}

class Monitoring {
  bool? create;
  bool? read;
  bool? update;
  bool? delete;
  bool? control;

  Monitoring({this.create, this.read, this.update, this.delete, this.control});

  Monitoring.fromJson(Map<String, dynamic> json) {
    create = json['create'];
    read = json['read'];
    update = json['update'];
    delete = json['delete'];
    control = json['control'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create'] = create;
    data['read'] = read;
    data['update'] = update;
    data['delete'] = delete;
    data['control'] = control;
    return data;
  }
}
