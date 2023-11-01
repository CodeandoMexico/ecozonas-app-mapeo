import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

MapatonPostModel mapatonPostModelFromJson(String str) => MapatonPostModel.fromJson(json.decode(str));

String mapatonPostModelToJson(MapatonPostModel data) => json.encode(data.toJson());

class MapatonPostModel {
    MapatonActivities mapaton;
    Mapper mapper;

    MapatonPostModel({
        required this.mapaton,
        required this.mapper,
    });

    factory MapatonPostModel.fromJson(Map<String, dynamic> json) => MapatonPostModel(
        mapaton: MapatonActivities.fromJson(json["mapaton"]),
        mapper: Mapper.fromJson(json["mapper"]),
    );

    Map<String, dynamic> toJson() => {
        "mapaton": mapaton.toJson(),
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

class PostActivity {
    String uuid;
    LatLng location;
    String timestamp;
    List<AnswerBlock> blocks;

    PostActivity({
        required this.uuid,
        required this.location,
        required this.timestamp,
        required this.blocks,
    });

    factory PostActivity.fromJson(Map<String, dynamic> json) => PostActivity(
        uuid: json["uuid"],
        location: json["location"] as LatLng,
        timestamp: json["timestamp"] as String,
        blocks: List<AnswerBlock>.from(json["blocks"].map((x) => AnswerBlock.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "location": location,
        "timestamp": timestamp,
        "blocks": List<dynamic>.from(blocks.map((x) => x.toJson())),
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
    String genre;
    String ageRange;
    String disability;

    SociodemographicData({
        required this.genre,
        required this.ageRange,
        required this.disability,
    });

    factory SociodemographicData.fromJson(Map<String, dynamic> json) => SociodemographicData(
        genre: json["genre"],
        ageRange: json["age_range"],
        disability: json["disability"],
    );

    Map<String, dynamic> toJson() => {
        "genre": genre,
        "age_range": ageRange,
        "disability": disability,
    };
}
