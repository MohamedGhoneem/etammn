import '../../features/sign_in/model/sign_in_response_model.dart';
import '../../features/system_details/model/system_details_response_model.dart';
import 'location_model.dart';

class SystemItemModel {
  int? id;
  bool? isActive;
  bool? isOnline;
  CurrentStatus? currentStatus;
  CurrentStatus? currentMode;
  Location? location;
  var faultCount;
  var alarmCount;
  int? systemControl;
  String? avatar;
  String? type;

  SystemItemModel(
      {this.id,
        this.isActive,
        this.isOnline,
        this.currentStatus,
        this.currentMode,
        this.location,
        this.faultCount,
        this.alarmCount,
        this.systemControl,
        this.avatar,
        this.type});

  SystemItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    isOnline = json['isOnline'];
    currentStatus = json['currentStatus'] != null
        ? CurrentStatus.fromJson(json['currentStatus'])
        : null;
    currentMode = json['currentMode'] != null
        ? CurrentStatus.fromJson(json['currentMode'])
        : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    faultCount = json['faultCount'];
    alarmCount = json['alarmCount'];
    systemControl = json['system_control'];
    avatar = json['avatar'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isActive'] = isActive;
    data['isOnline'] = isOnline;
    if (currentStatus != null) {
      data['currentStatus'] = currentStatus!.toJson();
    }
    if (currentMode != null) {
      data['currentMode'] = currentMode!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['faultCount'] = faultCount;
    data['alarmCount'] = alarmCount;
    data['system_control'] = systemControl;
    data['avatar'] = avatar;
    data['type'] = type;
    return data;
  }
}
