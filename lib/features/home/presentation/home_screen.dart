import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/drawer/drawer.dart';
import 'package:think_and_wash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_event.dart';

import '../../cart/presentation/cart.dart';
import '../../categories/presentation/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<CategoriesBloc>().add(
      const FetchCategoriesEvent(vendorId: "69ae5cc549a2b6ad583acc8a"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const MyDrawer(),
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
            tabs: const [Tab(text: "Categories"), Tab(text: "Cart")],
          ),
        ),

        body: const TabBarView(children: [CategoriesPage(), Cart(istab: true)]),
      ),
    );
  }
}
