import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/trackOrder/bloc/track_order_bloc.dart';
import 'package:think_and_wash/features/trackOrder/widgets/order_tracking.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: Text(
          'Track Order',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<TrackOrderBloc, TrackOrderState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: OrderTracking(currentStep: state.stepIndex),
          );
        },
      ),
    );
  }
}
