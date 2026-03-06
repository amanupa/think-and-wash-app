import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:think_and_wash/core/app_url.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/auth/domain/auth_entity.dart';

abstract class AuthDatasource {
  Future<String> getOtp(String phn);
  Future<AuthModel> submitOtp(AuthEntity entity);
}

class AuthDataSourceImpl extends AuthDatasource {
  @override
  Future<String> getOtp(String phn) async {
    try {
      final url = AppUrl.host + AppUrl.getOtp;
      debugPrint("thsi is the url in datasource to get otp: $url");
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phn}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
          "this is the success response from backend: ${response.body} ",
        );
        return response.body;
      }
      throw ApiException(
        message: "Api error with status code: ${response.statusCode}",
      );
    } catch (err) {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> submitOtp(AuthEntity entity) async {
    try {
      debugPrint("inside submit otp function");
      final url = AppUrl.host + AppUrl.verifyOtp;
      debugPrint(
        "this is the url and body of the submit otp: $url & ${jsonEncode(entity.toJson())}",
      );
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(entity.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return authModelFromJson(response.body);
      }
      throw ApiException(
        message: "Api error with status code: ${response.statusCode}",
      );
    } catch (err) {
      debugPrint("inside catch bloc with err: $err");
      throw ServerException();
    }
  }
}
