import 'activity_db_model.dart';

const String mapatonsTable = 'mapatonsTable';

List<MapatonDbModel> mapatonDbModelListFromJson(List<Map<String, dynamic>> json) {
  return List<MapatonDbModel>.from(json.map((e) => MapatonDbModel.fromJson(e)));
}

class MapatonColumns {
  static const List<String> columns = [
    id, uuid, dateTime, mapperId, mapperGender, mapperAge, mapperDisability
  ];
  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String dateTime = 'dateTime';
  static const String mapperId = 'mapperId';
  static const String mapperGender = 'mapperGender';
  static const String mapperAge = 'mapperAge';
  static const String mapperDisability = 'mapperDisability';
}

class MapatonDbModel {
  MapatonDbModel({
    this.id,
    required this.uuid,
    required this.dateTime,
    required this.mapperId,
    required this.mapperGender,
    required this.mapperAge,
    required this.mapperDisability,
    this.activities
  });

  int? id;
  String uuid;
  DateTime dateTime;
  int mapperId;
  String mapperGender;
  String mapperAge;
  String mapperDisability;
  List<ActivityDbModel>? activities;

  factory MapatonDbModel.fromJson(Map<String, dynamic> json) => MapatonDbModel(
    id: json[MapatonColumns.id] as int?,
    uuid: json[MapatonColumns.uuid] as String,
    dateTime: DateTime.parse(json[MapatonColumns.dateTime]),
    mapperId: json[MapatonColumns.mapperId] as int,
    mapperGender: json[MapatonColumns.mapperGender] as String,
    mapperAge: json[MapatonColumns.mapperAge] as String,
    mapperDisability: json[MapatonColumns.mapperDisability] as String,
  );

  Map<String, dynamic> toJson() => {
    MapatonColumns.id: id,
    MapatonColumns.uuid: uuid,
    MapatonColumns.dateTime: dateTime.toIso8601String(),
    MapatonColumns.mapperId: mapperId,
    MapatonColumns.mapperGender: mapperGender,
    MapatonColumns.mapperAge: mapperAge,
    MapatonColumns.mapperDisability: mapperDisability,
  };

  @override
  String toString() {
    return '''
      id: $id
      uuid: $uuid
      dateTime: $dateTime
      mapperId: $mapperId
      mapperGender: $mapperGender
      mapperAge: $mapperAge
      mapperDisability: $mapperDisability
      activities: $activities
    ''';
  }
}