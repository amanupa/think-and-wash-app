part of 'pick_up_slot_bloc.dart';

sealed class PickUpSlotEvent extends Equatable {
  const PickUpSlotEvent();

  @override
  List<Object> get props => [];
}

class LoadUserSlots extends PickUpSlotEvent {
  final String vendorId;
  final String date;

  const LoadUserSlots(this.vendorId, this.date);
  @override
  List<Object> get props => [vendorId, date];
}

class SelectSlot extends PickUpSlotEvent {
  final PickupSlot slot;

  const SelectSlot(this.slot);
  @override
  List<Object> get props => [slot];
}
