import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/pickupSlot/data/pickup_slot_model.dart';
import 'package:think_and_wash/features/pickupSlot/data/remote_datasource.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_entity.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_repository.dart';

class PickupSlotRepositoryImpl extends PickupSlotRepository {
  final PickUpSlotRemoteDataSource dataSource;

  PickupSlotRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, PickupSlotModel>> getPickUpSLot(
    PickupSlotEntity entity,
  ) async {
    try {
      final result = await dataSource.getPickUpSlot(entity);
      return right(result);
    } on ApiException catch (err) {
      return left(ApiFailure(message: err.message));
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
