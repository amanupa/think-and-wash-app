import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/order/domain/usecase/create_order_usecase.dart';
import 'package:think_and_wash/features/order/domain/usecase/get_order_usecase.dart';

import 'package:think_and_wash/features/order/presentation/bloc/orders_event.dart';
import 'package:think_and_wash/features/order/presentation/bloc/orders_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrderUsecase getOrderUsecase;
  final CreateOrderUsecase createOrderUsecase;
  OrderBloc({required this.createOrderUsecase, required this.getOrderUsecase})
    : super(OrderInitialState()) {
    on<GetOrdersEvent>(_onGetOrders);
    on<CreateOrderEvent>(_onCreateOrder);
  }

  FutureOr<void> _onGetOrders(
    GetOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderLoadingState());
      final result = await getOrderUsecase(NoParams());
      result.fold(
        (failure) {
          emit(GetOrderFailureState(msg: failure.message ?? "Something wrong"));
        },
        (success) {
          emit(GetOrderSuccessState(orders: success));
        },
      );
    } catch (err) {
      emit(
        OrderServerFailureState(
          msg: "Its not you its us, Sorry for the inconvenience",
        ),
      );
    }
  }

  FutureOr<void> _onCreateOrder(
    CreateOrderEvent event,
    Emitter<OrderState> emit,
  ) {}
}
