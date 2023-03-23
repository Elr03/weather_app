import 'dart:io';

import 'package:dio/dio.dart';

class RequestApi {
  static final Dio _dio = Dio();

  /// Set all configurations in dio.
  static Future<void> configureDio() async {
    _dio
      ..options.baseUrl = 'https://'
      ..options.connectTimeout = const Duration(milliseconds: 60000)
      ..options.receiveTimeout = const Duration(milliseconds: 60000)
      ..options.headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
  }

  /// Get function is a get http request
  static Future<Response> get(String path) async {
    final resp = await _dio.get(path);
    return resp;
  }

  /// It checks that the code status is successful and returns a boolean..
  static bool checkStatusCode({required int statusCode}) {
    var successfulStatusCode = false;
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      successfulStatusCode = true;
    }
    return successfulStatusCode;
  }
}
