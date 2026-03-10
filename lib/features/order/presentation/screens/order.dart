import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/app_colors.dart';

import 'package:think_and_wash/features/order/presentation/bloc/orders_bloc.dart';
import 'package:think_and_wash/features/order/presentation/bloc/orders_event.dart';

import 'package:think_and_wash/features/order/presentation/screens/delivered.dart';
import 'package:think_and_wash/features/order/presentation/screens/delivery.dart';
import 'package:think_and_wash/features/order/presentation/screens/pickup.dart';
import 'package:think_and_wash/core/injection.dart' as di;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              OrderBloc(getOrderUsecase: di.sl(), createOrderUsecase: di.sl())
                ..add(GetOrdersEvent()),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            //automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.background,
            title: Text(
              "Your Orders",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.only(right: 10),

                /* decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: -2,
                      color: AppColors.boxShadowPink,
                    ),
                  ],
                ),*/
                child: Image.asset(
                  "assets/cart.png",
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
            ],
            bottom: TabBar(
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: "PickUp"),
                Tab(text: "Delivey"),
                Tab(text: "Delivered"),
              ],
            ),
          ),

          body: TabBarView(children: [Pickup(), Delivery(), Delivered()]),
        ),
      ),
    );
  }
}
