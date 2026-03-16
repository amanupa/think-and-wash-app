part of 'pick_up_slot_bloc.dart';

sealed class PickUpSlotState extends Equatable {
  const PickUpSlotState();

  @override
  List<Object?> get props => [];
}

final class PickUpSlotInitial extends PickUpSlotState {}

class UserSlotLoading extends PickUpSlotState {}

class UserSlotLoaded extends PickUpSlotState {
  final List<PickUpSlot> slots;
  final PickUpSlot? selectedSlot;

  const UserSlotLoaded(this.slots, {this.selectedSlot});
  @override
  List<Object?> get props => [slots, selectedSlot];
}

class UserSlotError extends PickUpSlotState {
  final String message;
  const UserSlotError(this.message);
  @override
  List<Object> get props => [message];
}

class UserEmptySlotsState extends PickUpSlotState {
  @override
  List<Object?> get props => [];
}
