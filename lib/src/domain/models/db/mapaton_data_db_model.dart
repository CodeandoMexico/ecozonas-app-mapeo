const String mapatonsListTable = 'mapatonsListTable';

List<MapatonDataDbModel> mapatonDataDbFromJson(List<Map<String, dynamic>> json) {
  return List<MapatonDataDbModel>.from(json.map((e) => MapatonDataDbModel.fromJson(e)));
}

class MapatonDataColumns {
  static const List<String> columns = [
    id, data
  ];
  static const String id = '_id';
  static const String data = 'data';
}

class MapatonDataDbModel {
  MapatonDataDbModel({
    this.id,
    required this.data
  });

  int? id;
  String data;

  factory MapatonDataDbModel.fromJson(Map<String, dynamic> json) => MapatonDataDbModel(
    id: json[MapatonDataColumns.id] as int?,
    data: json[MapatonDataColumns.data] as String,
  );

  Map<String, dynamic> toJson() => {
    MapatonDataColumns.id: id,
    MapatonDataColumns.data: data,
  };
}