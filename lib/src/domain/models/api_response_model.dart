import 'dart:convert';

ApiResponseModel apiResponseModelFromJson(String str) => ApiResponseModel.fromJson(json.decode(str));

String apiResponseModelToJson(ApiResponseModel data) => json.encode(data.toJson());

class ApiResponseModel {
  ApiResponseModel({
    required this.isSuccess,
    this.result,
  });

  bool isSuccess;
  dynamic result;

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) => ApiResponseModel(
    isSuccess: json['isSuccess'],
    result: json['result'],
  );

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'result': result,
  };
}