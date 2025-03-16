class DropDownModel{
  String? name;

  DropDownModel({this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    return data;
  }


  bool operator == (dynamic other) =>
      other != null && other is DropDownModel && name == other.name;

  @override
  int get hashCode => super.hashCode;
}