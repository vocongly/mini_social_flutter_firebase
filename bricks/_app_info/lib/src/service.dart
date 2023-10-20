import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

import 'config.dart';

class ServerException implements Exception {}

class ServiceClient {
  Future<Map<String, String>> getHeaders() async {
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json"
    };
  }

  Future<Response> get() async {
    try {
      final client = Client();
      Future.delayed(apiWaitingTime).whenComplete(() => client.close());
      Map<String, String> headers = await getHeaders();
      Response response = await client.get(Uri.parse(uri), headers: headers);
      return response;
    } catch (e) {
      throw ServerException();
    }
  }
}
