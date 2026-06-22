import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiServices extends BaseApiServices {
  Future<Map<String, String>> _getHeaders({
    Map<String, String>? extra,
    String? token,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Updated User-Agent to a more standard one to avoid 503/WAF blocking
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (extra != null) {
      headers.addAll(extra);
    }

    return headers;
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  @override
  Future<dynamic> getApi(String url) async {
    try {
      _log('GET => $url');

      final headers = await _getHeaders();

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 20));

      return _returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  @override
  Future<dynamic> postApi(
    dynamic data,
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      _log('POST => $url');
      _log('BODY => ${jsonEncode(data)}');

      final mergedHeaders = await _getHeaders(extra: headers);

      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: mergedHeaders)
          .timeout(const Duration(seconds: 20));

      final contentType = response.headers['content-type'];

      if (contentType != null &&
          contentType.toLowerCase().contains('application/pdf')) {
        return response.bodyBytes;
      }

      return _returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  @override
  Future<dynamic> multipartApi(
    String url,
    Map<String, String> fields, {
    File? file,
    String fileField = 'file',
  }) async {
    try {
      _log('MULTIPART POST => $url');
      _log('FIELDS => $fields');

      final request = http.MultipartRequest('POST', Uri.parse(url));

      final headers = await _getHeaders();
      request.headers.addAll(headers);

      request.fields.addAll(fields);

      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            fileField,
            file.path,
            filename: file.path.split('/').last,
          ),
        );
      }

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );

      final responseBody = await streamedResponse.stream.bytesToString();

      _log('STATUS => ${streamedResponse.statusCode}');
      _log('RESPONSE => $responseBody');

      final decoded = _decodeResponse(responseBody);

      switch (streamedResponse.statusCode) {
        case 200:
        case 201:
          return decoded;

        case 400:
          throw BadRequestException(_extractMessage(decoded));

        case 401:
          throw UnauthorizedException('Session expired. Please login again.');

        case 403:
          throw UnauthorizedException('You do not have permission.');

        case 500:
          throw ServerException();

        default:
          throw FetchDataException(_extractMessage(decoded));
      }
    } on SocketException {
      throw InternetExceptions();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  dynamic _returnResponse(http.Response response) {
    _log('STATUS => ${response.statusCode}');
    _log('BODY => ${response.body}');

    final decoded = _decodeResponse(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return decoded;

      case 400:
        throw BadRequestException(_extractMessage(decoded));

      case 401:
        throw UnauthorizedException('Session expired. Please login again.');

      case 403:
        throw UnauthorizedException('You do not have permission.');

      case 500:
        throw ServerException();

      default:
        throw FetchDataException(_extractMessage(decoded));
    }
  }

  dynamic _decodeResponse(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }

  String _extractMessage(dynamic response) {
    if (response == null) {
      return 'Something went wrong';
    }

    if (response is Map<String, dynamic>) {
      if (response['message'] != null) {
        return response['message'].toString();
      }

      if (response['error'] != null) {
        return response['error'].toString();
      }

      if (response['detail'] != null) {
        return response['detail'].toString();
      }
    }

    return 'Something went wrong';
  }
}
