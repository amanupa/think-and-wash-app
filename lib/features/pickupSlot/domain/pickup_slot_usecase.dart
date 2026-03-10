import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/pickupSlot/data/pickup_slot_model.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_entity.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_repository.dart';

class PickupSlotUsecase extends UseCase<PickupSlotModel, PickupSlotEntity> {
  final PickupSlotRepository repository;

  PickupSlotUsecase({required this.repository});
  @override
  Future<Either<Failure, PickupSlotModel>> call(PickupSlotEntity entity) {
    return repository.getPickUpSLot(entity);
  }
}
