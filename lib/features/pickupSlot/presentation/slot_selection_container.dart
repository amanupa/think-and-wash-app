import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_entity.dart';
import 'package:think_and_wash/features/pickupSlot/presentation/bloc/pick_up_slot_bloc.dart';
import 'package:think_and_wash/features/pickupSlot/presentation/widgets/date_selector.dart';
import 'package:think_and_wash/features/pickupSlot/presentation/widgets/slot_grid.dart';

class SlotSelectionSection extends StatefulWidget {
  final String vendorId;

  const SlotSelectionSection({super.key, required this.vendorId});

  @override
  State<SlotSelectionSection> createState() => _SlotSelectionSectionState();
}

class _SlotSelectionSectionState extends State<SlotSelectionSection> {
  late String _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _formatDate(DateTime.now());

    context.read<PickUpSlotBloc>().add(
      LoadUserSlots(
        PickupSlotEntity(date: _selectedDate, vId: widget.vendorId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowPink,
            blurRadius: 10,
            spreadRadius: -4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Pickup Slot",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),

          DateSelector(
            selectedDate: _selectedDate,
            onDateChanged: _onDateChanged,
          ),

          const SizedBox(height: 16),

          BlocBuilder<PickUpSlotBloc, PickUpSlotState>(
            builder: (context, state) {
              if (state is UserSlotLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is UserSlotLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8),
                  child: SlotGrid(
                    slots: state.slots,
                    selectedSlot: state.selectedSlot,
                    onSelect: (slot) {
                      context.read<PickUpSlotBloc>().add(SelectSlot(slot));
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onDateChanged() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_selectedDate),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked == null) return;

    final formatted = _formatDate(picked);

    setState(() => _selectedDate = formatted);

    context.read<PickUpSlotBloc>().add(
      LoadUserSlots(PickupSlotEntity(date: formatted, vId: widget.vendorId)),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
