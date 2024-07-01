import 'dart:convert';

List<SurveyModel> surveyListFromJson(String str) => List<SurveyModel>.from(json.decode(str).map((x) => SurveyModel.fromJson(x)));

String surveyModelToJson(List<SurveyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurveyModel {
    String uuid;
    String mapatonReference;
    String title;
    String surveyUrl;

    SurveyModel({
        required this.uuid,
        required this.mapatonReference,
        required this.title,
        required this.surveyUrl,
    });

    factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
        uuid: json["uuid"],
        mapatonReference: json["mapaton_reference"],
        title: json["title"],
        surveyUrl: json["survey_url"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "mapaton_reference": mapatonReference,
        "title": title,
        "survey_url": surveyUrl,
    };
}