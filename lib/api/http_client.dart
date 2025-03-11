import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:http/http.dart';

import 'api.dart';

final logger = Logger();

class HttpClient {
  const HttpClient._();

  static final _client = Client();

  static Future<Response> getRequest(String url) async {
    final response = await _client.get(Uri.parse(url)).timeout(timeLimit);
    logger.d(response.request!.url);
    logger.d(response.body.toString());
    return response;
  }

  static Future<Response> postRequest(String url, {Object? body}) async {
    final response = await _client
        .post(Uri.parse(url), headers: customHeader(), body: jsonEncode(body))
        .timeout(timeLimit);
    logger.d(response.body.toString());
    logger.d(body.toString());
    logger.d(response.statusCode.toString());
    return response;
  }

  static Future<Response> deleteRequest(String url) async {
    final response = await _client
        .delete(Uri.parse(url), headers: customHeader())
        .timeout(timeLimit);
    logger.d(response.request!.url.toString());
    logger.d(response.statusCode.toString());
    return response;
  }

  static Future<Response> putRequest(String url, {Object? body}) async {
    final response = await _client
        .put(Uri.parse(url), headers: customHeader(), body: jsonEncode(body))
        .timeout(timeLimit);
    logger.d(response.statusCode.toString());
    logger.d(response.body.toString());
    return response;
  }
}
