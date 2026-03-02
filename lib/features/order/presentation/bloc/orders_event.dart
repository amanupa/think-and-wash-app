import 'package:equatable/equatable.dart';

import '../../domain/order_entity.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrders extends OrderEvent {
  final String usrId;

  const LoadOrders({required this.usrId});
  @override
  List<Object?> get props => [usrId];
}

class RefreshOrders extends OrderEvent {
  final String usrId;

  const RefreshOrders({required this.usrId});
  @override
  List<Object?> get props => [usrId];
}

class ChangeTab extends OrderEvent {
  final OrderStatus status;

  const ChangeTab(this.status);

  @override
  List<Object?> get props => [status];
}

class UpdateOrderStatus extends OrderEvent {
  final String orderId;
  final OrderStatus status;

  const UpdateOrderStatus({required this.orderId, required this.status});

  @override
  List<Object?> get props => [orderId, status];
}
