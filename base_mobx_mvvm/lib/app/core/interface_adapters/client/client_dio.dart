import 'dart:developer';

import 'package:base_mobx_mvvm/app/core/interface_adapters/dio/custom_dio.dart';
import 'package:dio/dio.dart';

import 'client_response.dart';

class ClientHttp {
  static Future<ClientResponse> get({required String endPoint}) async {
    try {
      Dio dio = CustomDio.connectionInterceptors().instance;
      Response response = await dio.get(endPoint);
      log(endPoint);
      log(response.data.toString().substring(0, response.data.toString().length > 200 ? 200 : response.data.toString().length));

      return ClientResponse(status: true, data: response.data);
    } on DioError catch (error) {
      return _processDioError(error);
    } catch (error) {
      return _processExceptionError(error);
    }
  }

  static Future<ClientResponse> post({required String endPoint, required dynamic data}) async {
    try {
      Dio dio = CustomDio.connectionInterceptors().instance;
      var response = await dio.post(endPoint, data: data);
      log(endPoint);
      log(response.data.toString());

      return ClientResponse(status: true, data: response.data);
    } on DioError catch (error) {
      return _processDioError(error);
    } catch (error) {
      return _processExceptionError(error);
    }
  }

  static Future<ClientResponse> put({required String endPoint, required Map<String, dynamic> data}) async {
    try {
      Dio dio = CustomDio.connectionInterceptors().instance;
      var response = await dio.put(endPoint, data: data);
      log("");
      log(endPoint);
      log(response.data);
      log("");
      return ClientResponse(status: true, data: response.data);
    } on DioError catch (error) {
      return _processDioError(error);
    } catch (error) {
      return _processExceptionError(error);
    }
  }

  static Future<ClientResponse> delete({required String endPoint, required Map<String, dynamic> data}) async {
    try {
      Dio dio = CustomDio.connectionInterceptors().instance;
      var response = await dio.delete(endPoint, data: data);
      log("");
      log(endPoint);
      log(response.data);
      log("");
      return ClientResponse(status: true, data: response.data);
    } on DioError catch (error) {
      return _processDioError(error);
    } catch (error) {
      return _processExceptionError(error);
    }
  }

  static ClientResponse _processExceptionError(Object error) {
    ClientError clientError = ClientError(
      data: {"mensagem": "Erro na requisição -> $error"},
      statusCode: "0",
    );
    return ClientResponse(status: false, data: {}, clientError: clientError);
  }

  static ClientResponse _processDioError(DioError error) {
    ClientError clientError = ClientError(
      data: error.response?.data ?? {"mensagem": "Erro na requisição -> ${error.error}"},
      statusCode: error.response?.statusCode?.toString() ?? "",
    );
    return ClientResponse(status: false, data: {}, clientError: clientError);
  }
}