import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';

import '../../cart/presentation/cart.dart';
import '../../categories/presentation/categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                shadowColor: AppColors.boxShadowPink,

                automaticallyImplyLeading: false,
                centerTitle: true,
                stretch: false,
                pinned: true,
                backgroundColor: AppColors.background,
                title: Text(
                  "Think & Wash",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                bottom: TabBar(
                  indicatorColor: AppColors.primary,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  tabs: [Tab(text: "Categories"), Tab(text: "Cart")],
                ),
              ),
            ];
          },

          body: TabBarView(children: [CategoriesPage(), const Cart()]),
        ),
      ),
    );
  }
}
