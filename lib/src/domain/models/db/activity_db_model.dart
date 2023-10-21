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
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String timestamp = 'timestamp';
  static const String blocks = 'blocks';
}

class ActivityDbModel {
  ActivityDbModel({
    this.id,
    required this.mapatonId,
    required this.uuid,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.blocks,
  });

  int? id;
  int mapatonId;
  String uuid;
  double latitude;
  double longitude;
  String timestamp;
  String blocks;

  factory ActivityDbModel.fromJson(Map<String, dynamic> json) => ActivityDbModel(
    id: json[ActivityColumns.id] as int?,
    mapatonId: json[ActivityColumns.mapatonId] as int,
    uuid: json[ActivityColumns.uuid] as String,
    latitude: json[ActivityColumns.latitude] as double,
    longitude: json[ActivityColumns.longitude] as double,
    timestamp: json[ActivityColumns.timestamp] as String,
    blocks: json[ActivityColumns.blocks] as String,
  );

  Map<String, dynamic> toJson() => {
    ActivityColumns.id: id,
    ActivityColumns.mapatonId: mapatonId,
    ActivityColumns.uuid: uuid,
    ActivityColumns.latitude: latitude,
    ActivityColumns.longitude: longitude,
    ActivityColumns.timestamp: timestamp,
    ActivityColumns.blocks: blocks,
  };

  @override
  String toString() {
    return '''
      Id: $id,
      mapatonId: $mapatonId,
      uuid: $uuid,
      latitude: $latitude,
      longitude: $longitude,
      timestamp: $timestamp,
      blocks: $blocks,
    ''';
  }
}