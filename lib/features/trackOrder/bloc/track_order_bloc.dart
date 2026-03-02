import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'track_order_event.dart';
part 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> {
  TrackOrderBloc() : super(TrackOrderState(OrderStatus.confirmed)) {
    on<UpdateOrderStatus>((event, emit) {
      emit(TrackOrderState(event.status));
    });
  }
}
