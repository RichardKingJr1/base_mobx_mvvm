import 'dart:convert';
import 'dart:developer';

class ClientResponse {
  ClientResponse({required this.status, required this.data, this.clientError});

  bool status;
  dynamic data;
  ClientError? clientError;
  
}


class ClientError {
  ClientError({this.statusCode = "", this.data});
  String statusCode;
  dynamic data;

  String get messageError => _messageError();

  String _messageError() {
    log("Data: $data");
    try {
      if (data is String) {
        if (!_isJson()) {
          return "ClientError: ${data.toString()}";
        }
        return jsonDecode(data);
      }
      if (data is List) {
        return _decodeMessage(data[0]);
      }
      if (data is Map) {
        return _decodeMessage(data);
      }
      return "ClientError: ${data.toString()}";
    } catch (err) {
      log("ClientError: $err");
      return "ClientError: ${data.toString()}";
    }
  }

  _decodeMessage(Map<String, dynamic> msg) {
    return msg["mensagem"];
  }

  bool _isJson() {
    try {
      Map<String, dynamic> d = jsonDecode(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
