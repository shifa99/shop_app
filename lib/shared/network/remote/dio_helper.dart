
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/shared/componeents/constants.dart';

class DioHelper {
  static Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'lang': 'ar',
          }),
    );
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client)
    //     {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
  }

  static Future getData(
      {@required String method, Map<String, dynamic> query}) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'Authorization': token??'',
    };
    return await dio.get(method, queryParameters: query);
  }

  static Future setData({
    String methodUrl,
    Map<String, dynamic> body,
  }) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'Authorization': token??'',
    };
    return await dio.post(methodUrl, data: body);
  }

  static Future putData({
    String methodUrl,
    Map<String, dynamic> body,
  }) async {
    dio.options.headers = 
    {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'Authorization': token??'',
    };
    return await dio.put(methodUrl, data: body);
  }
}
