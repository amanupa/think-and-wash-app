import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:think_and_wash/features/order/data/model/order.dart';
import 'package:think_and_wash/features/order/domain/entity/create_order_entity.dart';

import '../../../../core/api_clients.dart';
import '../../../../core/app_url.dart';
import '../../../../core/exception.dart';

abstract class OrderRemoteDataSource {
  Future<bool> createOrder(CreateOrderEntity entity);
  Future<OrdersModel> getOrders();
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  @override
  Future<bool> createOrder(entity) async {
    try {
      final url = AppUrl.host + AppUrl.createOrder;
      debugPrint(
        "this is the url and body in api call for create order: $url ${entity.toJson()}",
      );
      final response = await ApiClient.post(url: url, body: entity.toJson());
      bool isSuccess = false;

      if ((response.statusCode >= 200 && response.statusCode < 300) ||
          isSuccess) {
        debugPrint("inside create order sucess if block before returning");
        return true;
      }
      String errorMsg = response.body;
      try {
        final decoded = jsonDecode(response.body);
        if (decoded.containsKey('message')) {
          errorMsg = decoded['message'].toString();
        }
      } catch (_) {}
      throw ApiException(message: errorMsg);
    } on ApiException {
      rethrow;
    } catch (err, stack) {
      debugPrint("createOrder parsing error: $err\\n$stack");
      throw ServerException();
    }
  }

  @override
  Future<OrdersModel> getOrders() async {
    try {
      final url = AppUrl.host + AppUrl.getOrder;
      debugPrint("this is the url  in api call for get order: $url ");
      final response = await ApiClient.post(url: url);
      debugPrint(
        "this is the respons status code and body to get orders ${response.statusCode} ${response.body}",
      );
      bool isSuccess = false;
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map && decoded['success'] == true) {
          isSuccess = true;
        }
      } catch (_) {}

      if ((response.statusCode >= 200 && response.statusCode < 300) ||
          isSuccess) {
        return orderModelFromJson(response.body);
      }
      String errorMsg = response.body;
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map && decoded.containsKey('message')) {
          errorMsg = decoded['message'].toString();
        }
      } catch (_) {}
      throw ApiException(message: errorMsg);
    } on ApiException {
      rethrow;
    } catch (err) {
      throw ServerException();
    }
  }
}
