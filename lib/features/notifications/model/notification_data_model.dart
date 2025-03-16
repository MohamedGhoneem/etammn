class NotificationDataModel {
  int? id;
  String? ip;
  String? gdo;
  var loop;
  var note;
  var zone;
  var numel;
  var number;
  var olinet;
  var origin;
  var result;
  String? tipoTlc;
  String? command;
  var eventID;
  String? outcome;
  var deviceID;
  var adminId;
  var areaappl;
  String? classeel;
  var resolved;
  var addrperif;
  String? eventType;
  var forwarded;
  var routedTo;
  var systemId;
  String? createdAt;
  var deviceType;
  String? devicename;
  String? provenance;
  String? transition;
  String? updatedAt;
  var operatorId;
  var deviceNumber;
  var establishing;
  var forwardedTo;
  var suspendedTo;
  var textLocation;
  var operatorType;
  String? uniqueBulkId;
  String? applicationArea;
  String? transitionMode;

  NotificationDataModel(
      {this.id,
      this.ip,
      this.gdo,
      this.loop,
      this.note,
      this.zone,
      this.numel,
      this.number,
      this.olinet,
      this.origin,
      this.result,
      this.tipoTlc,
      this.command,
      this.eventID,
      this.outcome,
      this.deviceID,
      this.adminId,
      this.areaappl,
      this.classeel,
      this.resolved,
      this.addrperif,
      this.eventType,
      this.forwarded,
      this.routedTo,
      this.systemId,
      this.createdAt,
      this.deviceType,
      this.devicename,
      this.provenance,
      this.transition,
      this.updatedAt,
      this.operatorId,
      this.deviceNumber,
      this.establishing,
      this.forwardedTo,
      this.suspendedTo,
      this.textLocation,
      this.operatorType,
      this.uniqueBulkId,
      this.applicationArea,
      this.transitionMode});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ip = json['ip'];
    gdo = json['gdo'];
    loop = json['loop'];
    note = json['note'];
    zone = json['zone'];
    numel = json['numel'];
    number = json['number'];
    olinet = json['olinet'];
    olinet = json['olinet'];
    origin = json['origin'];
    result = json['result'];
    tipoTlc = json['TipoTlc'];
    command = json['command'];
    eventID = json['eventID'];
    outcome = json['outcome'];
    deviceID = json['DeviceID'];
    adminId = json['admin_id'];
    areaappl = json['areaappl'];
    classeel = json['classeel'];
    resolved = json['resolved'];
    addrperif = json['addrperif'];
    eventType = json['eventType'];
    forwarded = json['forwarded'];
    routedTo = json['routed_to'];
    systemId = json['system_id'];
    createdAt = json['created_at'];
    deviceType = json['deviceType'];
    devicename = json['devicename'];
    provenance = json['provenance'];
    transition = json['transition'];
    updatedAt = json['updated_at'];
    operatorId = json['operator_id'];
    deviceNumber = json['deviceNumber'];
    establishing = json['establishing'];
    forwardedTo = json['forwarded_to'];
    suspendedTo = json['suspended_to'];
    textLocation = json['textLocation'];
    operatorType = json['operator_type'];
    uniqueBulkId = json['unique_bulk_id'];
    applicationArea = json['applicationArea'];
    transitionMode = json['transition_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ip'] = ip;
    data['gdo'] = gdo;
    data['loop'] = loop;
    data['note'] = note;
    data['zone'] = zone;
    data['numel'] = numel;
    data['number'] = number;
    data['olinet'] = olinet;
    data['origin'] = origin;
    data['result'] = result;
    data['TipoTlc'] = tipoTlc;
    data['command'] = command;
    data['eventID'] = eventID;
    data['outcome'] = outcome;
    data['DeviceID'] = deviceID;
    data['admin_id'] = adminId;
    data['areaappl'] = areaappl;
    data['classeel'] = classeel;
    data['resolved'] = resolved;
    data['addrperif'] = addrperif;
    data['eventType'] = eventType;
    data['forwarded'] = forwarded;
    data['routed_to'] = routedTo;
    data['system_id'] = systemId;
    data['created_at'] = createdAt;
    data['deviceType'] = deviceType;
    data['devicename'] = devicename;
    data['provenance'] = provenance;
    data['transition'] = transition;
    data['updated_at'] = updatedAt;
    data['operator_id'] = operatorId;
    data['deviceNumber'] = deviceNumber;
    data['establishing'] = establishing;
    data['forwarded_to'] = forwardedTo;
    data['suspended_to'] = suspendedTo;
    data['textLocation'] = textLocation;
    data['operator_type'] = operatorType;
    data['unique_bulk_id'] = uniqueBulkId;
    data['applicationArea'] = applicationArea;
    data['transition_mode'] = transitionMode;
    return data;
  }
}
