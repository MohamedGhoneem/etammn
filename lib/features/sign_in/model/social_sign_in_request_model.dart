class SocialSignInRequestModel {
  late String provider;
  late String socialId;
  late String firstName;
  late String lastName;
  late String email;
  late String imageUrl;

  SocialSignInRequestModel(
      {required this.provider,
      required this.socialId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.imageUrl});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provider'] = provider;
    data['socialId'] = socialId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['imageUrl'] = imageUrl;

    return data;
  }
}
