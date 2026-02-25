import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/drawer/drawer.dart';

import '../../cart/presentation/cart.dart';
import '../../categories/presentation/categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.background,
          title: Text(
            "Think & Wash",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            indicatorColor: AppColors.primary,
            tabs: [Tab(text: "Categories"), Tab(text: "Cart")],
          ),
        ),

        body: TabBarView(children: [CategoriesPage(), Cart()]),
      ),
    );
  }
}
