import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:think_and_wash/core/secure_storage.dart';

class ApiClient {
  static Future<Map<String, String>> _getHeaders() async {
    final token = await SecureStorageService.readData(key: "auth_token");

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future<http.Response> post({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final headers = await _getHeaders();

    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> get({required String url}) async {
    final headers = await _getHeaders();

    return await http.get(Uri.parse(url), headers: headers);
  }
}
