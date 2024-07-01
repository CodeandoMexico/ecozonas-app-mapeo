import 'dart:convert';

ApiResponseModel apiResponseModelFromJson(String str) => ApiResponseModel.fromJson(json.decode(str));

String apiResponseModelToJson(ApiResponseModel data) => json.encode(data.toJson());

class ApiResponseModel {
  ApiResponseModel({
    required this.isSuccess,
    this.result,
    this.error,
  });

  bool isSuccess;
  // Map<String, dynamic>? result;
  dynamic result;
  String? error;

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) => ApiResponseModel(
    isSuccess: json['isSuccess'],
    result: json['result'],
    error: json['error'],
  );

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'result': result,
    'error': error,
  };
}