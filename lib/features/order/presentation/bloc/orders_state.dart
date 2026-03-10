import 'package:equatable/equatable.dart';

import '../../data/model/order.dart';

sealed class OrderState extends Equatable {}

class OrderInitialState extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderLoadingState extends OrderState {
  @override
  List<Object?> get props => [];
}

class CreateOrderSuccessState extends OrderState {
  @override
  List<Object?> get props => [];
}

class CreateOrderFailureState extends OrderState {
  @override
  List<Object?> get props => [];
}

class GetOrderSuccessState extends OrderState {
  final OrdersModel orders;

  GetOrderSuccessState({required this.orders});
  @override
  List<Object?> get props => [orders];
}

class GetOrderFailureState extends OrderState {
  final String msg;

  GetOrderFailureState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

class OrderServerFailureState extends OrderState {
  final String msg;

  OrderServerFailureState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
