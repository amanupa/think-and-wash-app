import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:think_and_wash/core/app_url.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';

abstract class AuthDatasource {
  Future<String> getOtp(String phn);
  Future<AuthModel> submitOtp(String otp);
}

class AuthDataSourceImpl extends AuthDatasource {
  @override
  Future<String> getOtp(String phn) async {
    try {
      final url = AppUrl.host + AppUrl.getOtp;
      print("thsi is the url in datasource to get otp: $url");
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phn}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Otp sent successfully";
      }
      throw ApiException(
        message: "Api error with status code: ${response.statusCode}",
      );
    } catch (err) {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> submitOtp(String otp) async {
    try {
      final url = AppUrl.host + AppUrl.submitOtp;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return authModelFromJson(response.body);
      }
      throw ApiException(
        message: "Api error with status code: ${response.statusCode}",
      );
    } catch (err) {
      throw ServerException();
    }
  }
}
