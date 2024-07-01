import '../mapaton_model.dart';

const String activitiesTable = 'acivitiesTable';

List<ActivityDbModel> activityDbModelListFromJson(List<Map<String, dynamic>> json) {
  return List<ActivityDbModel>.from(json.map((e) => ActivityDbModel.fromJson(e)));
}

class ActivityColumns {
  static const List<String> columns = [
    id, mapatonId, uuid, latitude, longitude, timestamp, blocks
  ];
  static const String id = '_id';
  static const String mapatonId = 'mapatonId';
  static const String uuid = 'uuid';
  static const String name = 'name';
  static const String color = 'color';
  static const String borderColor = 'borderColor';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String timestamp = 'timestamp';
  static const String blocks = 'blocks';
  static const String categoryCode = 'categoryCode';
  static const String sent = 'sent';
}

class ActivityDbModel {
  ActivityDbModel({
    this.id,
    required this.mapatonId,
    required this.uuid,
    required this.name,
    required this.color,
    required this.borderColor,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.blocks,
    this.blockList,
    required this.categoryCode,
    this.sent = false,
  });

  int? id;
  int mapatonId;
  String uuid;
  String name;
  String color;
  String borderColor;
  double latitude;
  double longitude;
  String timestamp;
  String blocks;
  List<Block>? blockList;
  String categoryCode;
  bool sent;

  factory ActivityDbModel.fromJson(Map<dynamic, dynamic> json) => ActivityDbModel(
    id: json[ActivityColumns.id] as int?,
    mapatonId: json[ActivityColumns.mapatonId] as int,
    uuid: json[ActivityColumns.uuid] as String,
    name: json[ActivityColumns.name] as String,
    color: json[ActivityColumns.color] as String,
    borderColor: json[ActivityColumns.borderColor] as String,
    latitude: json[ActivityColumns.latitude] as double,
    longitude: json[ActivityColumns.longitude] as double,
    timestamp: json[ActivityColumns.timestamp] as String,
    blocks: json[ActivityColumns.blocks] as String,
    categoryCode: json[ActivityColumns.categoryCode] as String,
    sent: json[ActivityColumns.sent] == 1 ? true : false,
  );

  Map<String, dynamic> toJson() => {
    ActivityColumns.id: id,
    ActivityColumns.mapatonId: mapatonId,
    ActivityColumns.uuid: uuid,
    ActivityColumns.name: name,
    ActivityColumns.color: color,
    ActivityColumns.borderColor: borderColor,
    ActivityColumns.latitude: latitude,
    ActivityColumns.longitude: longitude,
    ActivityColumns.timestamp: timestamp,
    ActivityColumns.blocks: blocks,
    ActivityColumns.categoryCode: categoryCode,
    ActivityColumns.sent: sent ? 1 : 0,
  };
}