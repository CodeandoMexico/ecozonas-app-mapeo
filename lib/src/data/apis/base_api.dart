import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/api_response_model.dart';
import '../device/connectivity.dart';

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

class BaseApi {
  static String basePath = 'https://eoq0m9md8v8t6h2.m.pipedream.net/';

  // static final Map<String, String> _headers = {
  //   "Content-Type" : "application/json",
  //   "Accept" : "application/json"
  // };

  // static Map<String, String> _authHeaders() {
  //   final prefs = UserPreferences();
  //   return {
  //       ..._headers,
  //       "Authorization" : "Bearer ${prefs.getLoginData!.token}"
  //   };
  // }

  /*
   * FUTURES
   */
  static Future<ApiResponseModel> get({required String endpoint}) async {
    final connectionAvailable = await Connectivity.connectionAvailable();
    if (connectionAvailable) {
      final http.Response response = await http.get(
        Uri.parse('${basePath}api/$endpoint'),
        // headers : _authHeaders()
      );
      if (response.ok) {
        return ApiResponseModel(
          isSuccess: true,
          result: json.decode(response.body),
        );
      } else {
        return ApiResponseModel(
          isSuccess: false,
          error: response.body
        );
      }
    } else {
      return ApiResponseModel(
        isSuccess: false,
        error: 'No hay conexión a internet'
      );
    }
  }

  static Future<ApiResponseModel> post({
    required String endpoint,
    required Map<String, dynamic> body,
    bool noToken = false}
  ) async {
    final connectionAvailable = await Connectivity.connectionAvailable();
    if (connectionAvailable) {
      final http.Response response = await http.post(
        Uri.parse('${basePath}api/$endpoint'),
        // headers: noToken ? _headers : _authHeaders(),
        body: json.encode(body),
      );
      if (response.ok) {
        return ApiResponseModel(
          isSuccess: true,
          result: json.decode(response.body),
        );
      } else {
        return ApiResponseModel(
          isSuccess: false,
          error: response.body
        );
      }
    } else {
      return ApiResponseModel(
        isSuccess: false,
        error: 'No hay conexión a internet'
      );
    }
  }
}