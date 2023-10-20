import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_authentication/_authentication.dart';
import 'package:_authentication/src/error/exception.dart';
import 'package:_authentication/src/utils/helper/error_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiWaitingDuration = Duration(seconds: 60);

class APIServiceClient {
  static Future<Map<String, String>> _getHeaders(
      {bool withToken = true}) async {
    String? token;
    if (withToken == true) {
      token = await AuthenticationBrick().getAccessToken();
    }
    return {
      HttpHeaders.acceptHeader: "application/json",
      if (token != null) HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
  }

  static Future<Map<String, dynamic>> post({
    required String uri,
    required Map<String, dynamic> params,
    bool withToken = true,
  }) async {
    try {
      final client = http.Client();
      Map<String, String> headers = await _getHeaders(withToken: withToken);

      /// Force close after defined waiting time
      Future.delayed(apiWaitingDuration).whenComplete(() => client.close());

      http.Response response = await client.post(Uri.parse(uri),
          headers: headers, body: jsonEncode(params));
      ErrorHelper.handleExceptionByStatusCode(response.statusCode);
      Map<String, dynamic> result =
          json.decode(utf8.decode(response.bodyBytes));
      return result;
    } catch (e) {
      if (e is AuthorizationException) {
        rethrow;
      } else {
        debugPrint("[API] Post failed: $e");
        throw ServerException();
      }
    }
  }

  static Future<Map<String, dynamic>> get({
    required String uri,
    bool withToken = true,
  }) async {
    try {
      final client = http.Client();
      Map<String, String> headers = await _getHeaders(withToken: withToken);

      /// Force close after defined waiting time
      Future.delayed(apiWaitingDuration).whenComplete(() => client.close());

      http.Response response =
          await client.get(Uri.parse(uri), headers: headers);

      ErrorHelper.handleExceptionByStatusCode(response.statusCode);
      Map<String, dynamic> result =
          json.decode(utf8.decode(response.bodyBytes));
      return result;
    } catch (e) {
      if (e is AuthorizationException) {
        rethrow;
      } else {
        debugPrint("[API] Get failed: $e");
        throw ServerException();
      }
    }
  }
}
