import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/pickupSlot/data/pickup_slot_model.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_entity.dart';

abstract class PickupSlotRepository {
  Future<Either<Failure, PickupSlotModel>> getPickUpSLot(
    PickupSlotEntity entity,
  );
}
