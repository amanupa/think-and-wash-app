import 'package:flutter/material.dart';
import 'package:think_and_wash/features/order/data/model/order.dart';
import 'package:think_and_wash/features/order/domain/entity/create_order_entity.dart';

import '../../../../core/api_clients.dart';
import '../../../../core/app_url.dart';
import '../../../../core/exception.dart';

abstract class OrderRemoteDataSource {
  Future<OrdersModel> createOrder(CreateOrderEntity entity);
  Future<OrdersModel> getOrders();
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  @override
  Future<OrdersModel> createOrder(entity) async {
    try {
      final url = AppUrl.host + AppUrl.createOrder;
      debugPrint(
        "this is the url and body in api call for create order: $url ${entity.toJson()}",
      );
      final response = await ApiClient.post(url: url, body: entity.toJson());
      if (response.statusCode == 200) {
        return orderModelFromJson(response.body);
      }
      throw ApiException(message: response.body);
    } catch (err) {
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
      if (response.statusCode == 200) {
        return orderModelFromJson(response.body);
      }
      throw ApiException(message: response.body);
    } catch (err) {
      throw ServerException();
    }
  }
}
