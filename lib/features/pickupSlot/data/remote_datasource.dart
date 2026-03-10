import 'package:flutter/foundation.dart';
import 'package:think_and_wash/core/api_clients.dart';
import 'package:think_and_wash/core/app_url.dart';
import 'package:think_and_wash/features/pickupSlot/data/pickup_slot_model.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_entity.dart';

import '../../../core/exception.dart';

abstract class PickUpSlotRemoteDataSource {
  Future<PickupSlotModel> getPickUpSlot(PickupSlotEntity entity);
}

class PickUpSlotRemoteDataSourceImpl extends PickUpSlotRemoteDataSource {
  PickUpSlotRemoteDataSourceImpl();
  @override
  Future<PickupSlotModel> getPickUpSlot(PickupSlotEntity entity) async {
    try {
      final url = AppUrl.host + AppUrl.getPickupSlot;
      debugPrint(
        "this is the url and body in api call for pickup slot: $url ${entity.toJson()}",
      );
      final response = await ApiClient.post(url: url, body: entity.toJson());
      if (response.statusCode == 200) {
        return pickupSlotModelFromJson(response.body);
      }
      throw ApiException(message: response.body);
    } catch (err) {
      throw ServerException();
    }
  }
}
