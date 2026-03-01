import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:think_and_wash/features/pickupSlot/presentation/bloc/pick_up_slot_bloc.dart';

import '../../../core/app_colors.dart';
import '../../pickupSlot/data/pickup_slot_repository_impl.dart';
import 'widgets/cart_body.dart';

class Cart extends StatelessWidget {
  final bool istab;
  const Cart({super.key, required this.istab});

  final bool isSummaryOpen = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PickUpSlotBloc>(
          create: (_) => PickUpSlotBloc(UserSlotRepository()),
        ),
      ],
      child:
          istab
              ? CartBody()
              : Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.background,
                  title: Text(
                    "Your Cart",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  centerTitle: true,
                ),
                body: CartBody(),
              ),
    );
  }
}
