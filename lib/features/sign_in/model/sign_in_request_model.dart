
class SignInRequestModel {
  late String? countryKey;
  late String? mobile;
  late String? password;

  SignInRequestModel({required this.countryKey, required this.mobile, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_key'] = countryKey;
    data['mobile'] = mobile;
    data['password'] = password;

    return data;
  }
}
