const String mappersTable = 'mappersTable';

List<MapperDbModel> mapperDbModelListFromJson(List<Map<String, dynamic>> json) {
  return List<MapperDbModel>.from(json.map((e) => MapperDbModel.fromJson(e)));
}

class MapperColumns {
  static const List<String> columns = [
    id, mapperId, alias, gender, age, disability
  ];
  static const String id = '_id';
  static const String mapperId = 'mapperId';
  static const String alias = 'alias';
  static const String gender = 'gender';
  static const String age = 'age';
  static const String disability = 'disability';
}

class MapperDbModel {
  MapperDbModel({
    this.id,
    required this.mapperId,
    required this.alias,
    required this.gender,
    required this.age,
    required this.disability,
  });

  int? id;
  int mapperId;
  String alias;
  String gender;
  String age;
  String disability;

  factory MapperDbModel.fromJson(Map<String, dynamic> json) => MapperDbModel(
    id: json[MapperColumns.id] as int?,
    mapperId: json[MapperColumns.mapperId] as int,
    alias: json[MapperColumns.alias] as String,
    gender: json[MapperColumns.gender] as String,
    age: json[MapperColumns.age] as String,
    disability: json[MapperColumns.disability] as String,
  );

  Map<String, dynamic> toJson() => {
    MapperColumns.id: id,
    MapperColumns.mapperId: mapperId,
    MapperColumns.alias: alias,
    MapperColumns.gender: gender,
    MapperColumns.age: age,
    MapperColumns.disability: disability,
  };

  MapperDbModel copyWith({
    int? id,
    String? alias,
    String? gender,
    String? age,
    String? disability,
  }) {
    return MapperDbModel(
      mapperId: mapperId,
      id: id ?? this.id,
      alias: alias ?? this.alias,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      disability: disability ?? this.disability,
    );
  }

  @override
  String toString() {
    return '''
      id: $id
      mapperId: $mapperId
      alias: $alias
      gender: $gender
      age: $age
      disability: $disability
    ''';
  }
}