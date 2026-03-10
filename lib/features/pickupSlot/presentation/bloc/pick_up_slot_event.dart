part of 'pick_up_slot_bloc.dart';

sealed class PickUpSlotEvent extends Equatable {
  const PickUpSlotEvent();

  @override
  List<Object> get props => [];
}

class LoadUserSlots extends PickUpSlotEvent {
  final PickupSlotEntity entity;

  const LoadUserSlots(this.entity);
  @override
  List<Object> get props => [entity];
}

class SelectSlot extends PickUpSlotEvent {
  final PickUpSlot slot;

  const SelectSlot(this.slot);
  @override
  List<Object> get props => [slot];
}
