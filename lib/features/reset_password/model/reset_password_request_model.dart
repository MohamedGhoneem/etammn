
class ChangePasswordRequestModel {
  late String? code;
  late String password;
  late String passwordConfirmation;

  ChangePasswordRequestModel({this.code, required this.password, required this.passwordConfirmation});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;

    return data;
  }
}
