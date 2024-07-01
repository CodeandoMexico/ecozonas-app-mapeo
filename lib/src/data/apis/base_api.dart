import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/api_response_model.dart';
import '../../domain/models/multipart_file_model.dart';
import '../device/connectivity.dart';

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

class BaseApi {
  static String basePath = 'https://ecozonas.codeandomexico.org/';

  static final Map<String, String> _headers = {
    "Content-Type" : "application/json",
    "Accept" : "application/json"
  };

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
          result: json.decode(utf8.decode(response.bodyBytes)),
        );
      } else {
        return ApiResponseModel(
          isSuccess: false,
          error: 'No se pudo descargar la información'
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
        headers: _headers,
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
          error: 'No se pudo enviar la información'
        );
      }
    } else {
      return ApiResponseModel(
        isSuccess: false,
        error: 'No hay conexión a internet'
      );
    }
  }

  static Future<ApiResponseModel> postTest({
    required String endpoint,
    required Map<String, dynamic> body
  }) async {
    final connectionAvailable = await Connectivity.connectionAvailable();
    if (connectionAvailable) {
      final http.Response response = await http.post(
        Uri.parse(endpoint),
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
          error: 'No se pudo enviar la información'
        );
      }
    } else {
      return ApiResponseModel(
        isSuccess: false,
        error: 'No hay conexión a internet'
      );
    }
  }

  static Future<ApiResponseModel> postMultipart({
    required String endpoint,
    required MultipartFileModel file}
  ) async {
    final connectionAvailable = await Connectivity.connectionAvailable();
    if (connectionAvailable) {
      final multipartRequest = http.MultipartRequest(
        'POST',
        Uri.parse('${basePath}api/$endpoint'),
      );
      multipartRequest.headers.addAll(_headers);
      multipartRequest.fields.addAll({'mapaton' : file.mapatonUuid});

      final httpImage = http.MultipartFile.fromBytes(
        file.field,
        file.bytes!,
        filename: file.filename
      );
      multipartRequest.files.add(httpImage);

      final response = await http.Response.fromStream(await multipartRequest.send());

      if ((response.statusCode ~/ 100) == 2) {
        return ApiResponseModel(
          isSuccess: true,
          result: response.body,
        );
      } else {
        return ApiResponseModel(
          isSuccess: false,
          result: null,
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