import 'dart:convert';

ImageApiResponseModel imageApiResponseModelFromJson(String str) => ImageApiResponseModel.fromJson(json.decode(str));

String imageApiResponseModelToJson(ImageApiResponseModel data) => json.encode(data.toJson());

class ImageApiResponseModel {
    String mapaton;
    String uuid;
    String image;
    DateTime createdAt;

    ImageApiResponseModel({
        required this.mapaton,
        required this.uuid,
        required this.image,
        required this.createdAt,
    });

    factory ImageApiResponseModel.fromJson(Map<String, dynamic> json) => ImageApiResponseModel(
        mapaton: json["mapaton"],
        uuid: json["uuid"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "mapaton": mapaton,
        "uuid": uuid,
        "image": image,
        "created_at": createdAt.toIso8601String(),
    };
}
