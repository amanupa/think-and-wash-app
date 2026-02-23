import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../core/ads/banner_ad.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});
  final List<Map<String, String>> cartItemPriceList = [
    {"Shirt": "15"},
    {"T-Shirt": "12"},
    {"Formal Pant": "18"},
    {"Jeans": "18"},
    {"Blazer": "40"},
    {"Hoody": "35"},
  ];
  final List<String> productImg = [
    "assets/shirt.png",
    "assets/t-shirt.png",
    "assets/formal_pant.png",
    "assets/jeans.png",
    "assets/coat_blazer.png",
    "assets/hoodie.png",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey('categories'),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: -3,
                    offset: Offset(0, 0),
                    color: AppColors.boxShadowPink,
                  ),
                ],
              ),
              // height: 200,
              child: Center(child: const GlobalBannerAd()),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var item = cartItemPriceList[index].entries.first.key;
            var itemPrice = double.parse(
              cartItemPriceList[index].entries.first.value,
            );
            print("item: $item and price: $itemPrice");
            return Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                /*boxShadow:
                    index % 2 == 0
                        ? [
                          BoxShadow(
                            blurRadius: 3,
                            spreadRadius: -5,
                            offset: Offset(10, 5),
                            color: AppColors.boxShadowPink,
                          ),
                        ]
                        : [],*/
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: -4,
                          offset: Offset(0, 5),
                          color: AppColors.boxShadowPink,
                        ),
                      ],
                    ),
                    child: Image.asset(productImg[index]),
                  ),
                  Text(item, style: Theme.of(context).textTheme.bodyLarge),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      int count = 0;
                      if (state is CartLoaded) {
                        print("this is the cart items:${state.items}");
                        final existing =
                            state.items.where((e) => e.id == index).toList();

                        if (existing.isNotEmpty) {
                          count = existing.first.quantity;
                        }
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(RemoveItem(index));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.boxShadowPink,
                              size: 30,
                            ),
                          ),
                          Text("$count"),
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                AddItem(
                                  id: index,
                                  name: item,
                                  price: itemPrice,
                                ),
                              );
                            },
                            icon: Image.asset("assets/bag.png"),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }, childCount: cartItemPriceList.length),
        ),
      ],
    );
  }
}
