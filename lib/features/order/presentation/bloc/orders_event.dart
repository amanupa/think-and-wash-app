import 'package:equatable/equatable.dart';
import 'package:think_and_wash/features/order/domain/entity/create_order_entity.dart';

import '../../domain/entity/order_entity.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class GetOrdersEvent extends OrderEvent {
  const GetOrdersEvent();
  @override
  List<Object?> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final CreateOrderEntity entity;

  const CreateOrderEvent({required this.entity});
  @override
  List<Object?> get props => [entity];
}

class RefreshOrders extends OrderEvent {
  const RefreshOrders();
  @override
  List<Object?> get props => [];
}

class ChangeTab extends OrderEvent {
  final OrderStatus status;

  const ChangeTab(this.status);

  @override
  List<Object?> get props => [status];
}
