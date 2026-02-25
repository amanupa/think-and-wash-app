part of 'track_order_bloc.dart';

@immutable
sealed class TrackOrderEvent {}

class UpdateOrderStatus extends TrackOrderEvent {
  final OrderStatus status;
  UpdateOrderStatus(this.status);
}

enum OrderStatus { confirmed, pickedUp, washing, outForDelivery, delivered }
