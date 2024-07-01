const String surveyListTable = 'surveyListTable';

List<SurveyDataDbModel> surveyDataDbFromJson(List<Map<String, dynamic>> json) {
  return List<SurveyDataDbModel>.from(json.map((e) => SurveyDataDbModel.fromJson(e)));
}

class SurveyDataColumns {
  static const List<String> columns = [
    id, data
  ];
  static const String id = '_id';
  static const String data = 'data';
}

class SurveyDataDbModel {
  SurveyDataDbModel({
    this.id,
    required this.data
  });

  int? id;
  String data;

  factory SurveyDataDbModel.fromJson(Map<String, dynamic> json) => SurveyDataDbModel(
    id: json[SurveyDataColumns.id] as int?,
    data: json[SurveyDataColumns.data] as String,
  );

  Map<String, dynamic> toJson() => {
    SurveyDataColumns.id: id,
    SurveyDataColumns.data: data,
  };
}