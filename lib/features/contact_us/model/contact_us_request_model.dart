class ContactUsRequestModel {
  late int? userId;
  late String? name;
  late String? email;
  late String? countryKey;
  late String? phone;
  late String? subject;
  late String? body;
  late int? countryId;

  ContactUsRequestModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.countryKey,
    required this.phone,
    required this.subject,
    required this.body,
    required this.countryId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['countryKey'] = countryKey;
    data['phone'] = phone;
    data['subject'] = subject;
    data['body'] = body;
    data['countryId'] = countryId;

    return data;
  }
}
