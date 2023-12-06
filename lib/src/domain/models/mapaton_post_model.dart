import 'dart:convert';

MapatonPostModel mapatonPostModelFromJson(String str) => MapatonPostModel.fromJson(json.decode(str));

String mapatonPostModelToJson(MapatonPostModel data) => json.encode(data.toJson());

class MapatonPostModel {
    List<PostActivity> activities;
    Mapper mapper;

    MapatonPostModel({
        required this.activities,
        required this.mapper,
    });

    factory MapatonPostModel.fromJson(Map<String, dynamic> json) => MapatonPostModel(
        activities: List<PostActivity>.from(json["activities"].map((x) => PostActivity.fromJson(x))),
        mapper: Mapper.fromJson(json["mapper"]),
    );

    Map<String, dynamic> toJson() => {
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "mapper": mapper.toJson(),
    };
}

class MapatonActivities {
    String? uuid;
    List<PostActivity> activities;

    MapatonActivities({
        this.uuid,
        required this.activities,
    });

    factory MapatonActivities.fromJson(Map<String, dynamic> json) => MapatonActivities(
        uuid: json["uuid"],
        activities: List<PostActivity>.from(json["activities"].map((x) => PostActivity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
    };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates
  });

  String type;
  GeometryLatLng coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
      type: json["type"],
      coordinates: json["coordinates"],
  );

  Map<String, dynamic> toJson() => {
      "type": type,
      "coordinates": coordinates,
  };
}

class GeometryLatLng {
  GeometryLatLng({
    required this.latitude,
    required this.longitude
  });

  double latitude;
  double longitude;

  factory GeometryLatLng.fromJson(Map<String, dynamic> json) => GeometryLatLng(
      latitude: json["latitude"],
      longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
      "latitude": latitude,
      "longitude": longitude,
  };
}

class PostActivity {
    String uuid;
    Geometry geometry;
    String timestamp;
    Map<String, dynamic> data;

    PostActivity({
        required this.uuid,
        required this.geometry,
        required this.timestamp,
        required this.data,
    });

    factory PostActivity.fromJson(Map<String, dynamic> json) => PostActivity(
        uuid: json["uuid"],
        geometry: json["geometry"] as Geometry,
        timestamp: json["timestamp"] as String,
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "geometry": geometry,
        "timestamp": timestamp,
        "data": data,
    };
}

class AnswerBlock {
    String uuid;
    dynamic answer;

    AnswerBlock({
        required this.uuid,
        required this.answer,
    });

    factory AnswerBlock.fromJson(Map<String, dynamic> json) => AnswerBlock(
        uuid: json["uuid"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "answer": answer,
    };
}

class AnswerClass {
    int latitude;
    int longitude;

    AnswerClass({
        required this.latitude,
        required this.longitude,
    });

    factory AnswerClass.fromJson(Map<String, dynamic> json) => AnswerClass(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class Mapper {
    int? dbId;
    int id;
    SociodemographicData sociodemographicData;

    Mapper({
        this.dbId,
        required this.id,
        required this.sociodemographicData,
    });

    factory Mapper.fromJson(Map<String, dynamic> json) => Mapper(
        dbId: json["dbId"],
        id: json["id"],
        sociodemographicData: SociodemographicData.fromJson(json["sociodemographic_data"]),
    );

    Map<String, dynamic> toJson() => {
        "dbId": dbId,
        "id": id,
        "sociodemographic_data": sociodemographicData.toJson(),
    };
}

class SociodemographicData {
    String gender;
    String ageRange;
    String disability;

    SociodemographicData({
        required this.gender,
        required this.ageRange,
        required this.disability,
    });

    factory SociodemographicData.fromJson(Map<String, dynamic> json) => SociodemographicData(
        gender: json["gender"],
        ageRange: json["age_range"],
        disability: json["disability"],
    );

    Map<String, dynamic> toJson() => {
        "gender": gender,
        "age_range": ageRange,
        "disability": disability,
    };
}
