import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/pickup_slot_model.dart';
import '../../data/pickup_slot_repository_impl.dart';

part 'pick_up_slot_event.dart';
part 'pick_up_slot_state.dart';

class PickUpSlotBloc extends Bloc<PickUpSlotEvent, PickUpSlotState> {
  final UserSlotRepository repository;
  PickUpSlotBloc(this.repository) : super(PickUpSlotInitial()) {
    on<LoadUserSlots>(_onLoadSlots);
    on<SelectSlot>(_onSelectSlot);
  }
  Future<void> _onLoadSlots(
    LoadUserSlots event,
    Emitter<PickUpSlotState> emit,
  ) async {
    emit(UserSlotLoading());

    try {
      final slots = await repository.fetchSlots(event.vendorId, event.date);

      if (slots.isEmpty) {
        emit(UserSlotLoaded(_generateStaticSlots()));
      } else {
        emit(UserSlotLoaded(slots));
      }
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

  List<PickupSlot> _generateStaticSlots() {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);

    List<PickupSlot> slots = [];

    for (int hour = 9; hour < 23; hour++) {
      final start = date.add(Duration(hours: hour));
      final end = date.add(Duration(hours: hour + 1));

      slots.add(
        PickupSlot(
          id: "static_$hour",
          start: start,
          end: end,
          availableCapacity: 10,
          isAvailable: true,
        ),
      );
    }

    return slots;
  }
}
