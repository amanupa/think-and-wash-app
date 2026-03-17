import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_usecase.dart';

import '../../data/pickup_slot_model.dart';

import '../../domain/pickup_slot_entity.dart';

part 'pick_up_slot_event.dart';
part 'pick_up_slot_state.dart';

class PickUpSlotBloc extends Bloc<PickUpSlotEvent, PickUpSlotState> {
  final PickupSlotUsecase usecase;
  PickUpSlotBloc(this.usecase) : super(PickUpSlotInitial()) {
    on<LoadUserSlots>(_onLoadSlots);
    on<SelectSlot>(_onSelectSlot);
  }
  Future<void> _onLoadSlots(
    LoadUserSlots event,
    Emitter<PickUpSlotState> emit,
  ) async {
    emit(UserSlotLoading());

    try {
      debugPrint(
        "this is hte entity in onloadSlots: ${event.entity.date} ${event.entity.vId}",
      );
      final result = await usecase(event.entity);
      result.fold(
        (failure) {
          emit(UserSlotError(failure.message ?? "Something bad"));
        },
        (success) {
          if (success.data.isEmpty) {
            emit(UserEmptySlotsState());
          } else {
            emit(UserSlotLoaded(success.data));
          }
        },
      );
    } catch (e) {
      emit(UserSlotLoaded(_generateStaticSlots()));
    }
  }

  void _onSelectSlot(SelectSlot event, Emitter<PickUpSlotState> emit) {
    if (state is UserSlotLoaded) {
      final current = state as UserSlotLoaded;

      emit(UserSlotLoaded(current.slots, selectedSlot: event.slot));
    }
  }

  List<PickUpSlot> _generateStaticSlots() {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);

    List<PickUpSlot> slots = [];

    for (int hour = 9; hour < 23; hour++) {
      final start = date.add(Duration(hours: hour));
      final end = date.add(Duration(hours: hour + 1));

      slots.add(
        PickUpSlot(
          id: "static_$hour",
          start: start,
          end: end,
          availableCapacity: 10,
        ),
      );
    }

    return slots;
  }
}
