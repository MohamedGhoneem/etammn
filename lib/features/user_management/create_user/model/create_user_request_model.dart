
class CreateUserRequestModel {
  String? username;
  String? avatar;
  String? email;
  String? mobile;
  String? countryKey;
  String? iso;
  String? password;
  String? passwordConfirmation;
  int? usersControl;
  int? operationLevel;
  List<CheckedSystemsModel>? checkedSystems;

  CreateUserRequestModel(
      {this.username,
      this.avatar,
      this.email,
      this.mobile,
      this.countryKey,
      this.iso,
      this.password,
      this.passwordConfirmation,
      this.usersControl,
      this.operationLevel,
      this.checkedSystems});

  // CreateUserRequestModel.fromJson(Map<String, dynamic> json) {
  //   username = json['username'];
  //   avatar = json['avatar'];
  //   email = json['email'];
  //   mobile = json['mobile'];
  //   countryId = json['country_id'];
  //   iso = json['iso'];
  //   password = json['password'];
  //   passwordConfirmation = json['password_confirmation'];
  //   systemControl = json['system_control'];
  //   operationLevel = json['operation_level'];
  //   if (json['checked_systems'] != null) {
  //     checkedSystems = [];
  //     json['checked_systems'].foreach((v) {
  //       checkedSystems!.add(CheckedSystemsModel.fromJson(v));
  //     });
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    if (avatar != null) {
      data['avatar'] = avatar;
    }
    data['email'] = email;
    data['mobile'] = mobile;
    data['countryKey'] = countryKey;
    data['iso'] = iso;
    if (password != null) {
      data['password'] = password;
    }
    if (passwordConfirmation != null) {
      data['password_confirmation'] = passwordConfirmation;
    }
    data['users_control'] = usersControl;
    data['operation_level'] = operationLevel;
    if (checkedSystems != null && checkedSystems != []) {
      data['checked_systems'] = checkedSystems!.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class CheckedSystemsModel {
  int? systemId;
  int? systemControl = 0;

  CheckedSystemsModel({this.systemId, this.systemControl});

  CheckedSystemsModel.fromJson(Map<String, dynamic> json) {
    systemId = json['system_id'];
    systemControl = json['system_control'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['system_id'] = systemId;
    data['system_control'] = systemControl;
    return data;
  }

  bool operator ==(dynamic other) =>
      other != null &&
      other is CheckedSystemsModel &&
      systemId == other.systemId;

  @override
  int get hashCode => super.hashCode;
}
