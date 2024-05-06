import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class HttpUtil {
  static final HttpUtil _httpUtil = HttpUtil._internal();

  factory HttpUtil() {
    return _httpUtil;
  }

  late Dio dio;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authkey': 's9f72f0aa3-jos3f-u83b-ic83-w83h6fow9h',
  };

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://robokriti.co.in/common/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: headers,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    // Bypass SSL certificate verification
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
  }

  Future<Map<String,dynamic>> get({required String path}) async {
    var response = await dio.get(path);
    Map<String , dynamic> res = response.data;
    return res;
  }

  Future<Map<String, dynamic>> post({
    required String relativePath,
    dynamic data,
  }) async {
    try {
      var response = await dio.post(
        relativePath,
        data: data,
      );

      Map<String, dynamic> res = response.data;

      return res;
    } catch (e) {
      // Handle DioException or other exceptions here
      print('Error occurred: $e');
      // Rethrow the exception for the caller to handle
      throw e;
    }
  }
}
