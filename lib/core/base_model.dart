abstract class BaseModel<T> {
  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  T decodingFromJson(String str);

  String encodingToJson();
}
