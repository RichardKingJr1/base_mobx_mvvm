import 'dart:developer';

import 'package:dio/dio.dart';

class CustomDio {
  late Dio _dio;

  Dio get instance => _dio;

  CustomDio.connection() {
    _dio = Dio();
  }

  CustomDio.connectionInterceptors() {
    _dio = Dio();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
        onResponse: _onResponse,
      ),
    );
  }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "";
    options.headers["Access-Control-Allow-Origin"] = "*";
    // options.headers['Content-Type'] = 'application/json';
    options.receiveTimeout = 20 * 1000;
    options.connectTimeout = 20 * 1000;
    options.sendTimeout = 20 * 1000;
    return handler.next(options);
  }

  _onError(DioError dioError, ErrorInterceptorHandler handler) {
    log("##### Dio() Erro inteceptado #####");
    if (dioError.response?.statusCode != null) {
      log("${dioError.response!.statusCode}");
      log("${dioError.response!.data}");
    }
    log("${dioError.error}");
    log("${dioError.requestOptions.uri}");
    log("");
    log("");
    return handler.next(dioError);
  }

  _onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}