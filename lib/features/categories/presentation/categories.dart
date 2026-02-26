import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/categories/presentation/widgets/sliver_cart_item_list.dart';

import '../../../core/ads/banner_ad.dart';
import '../../../route/app_routes.dart';
import '../data/datasource/local/wash_iron_data_source.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});
  final List<String> route = const [
    AppRoutes.dryClean,
    AppRoutes.dryClean,
    AppRoutes.dryClean,
    AppRoutes.dryClean,
    AppRoutes.dryClean,
  ];
  final List<String> serviceTitles = [
    "Dry Clean",
    "Premium",
    "Home Bounds",
    "Shoes",
    "White cloths",
    "Express",
  ];

  final List<String> serviceIcons = [
    "assets/dry-clean.png",
    "assets/primium.png",
    "assets/home-bounds.png",
    "assets/shoe.png",
    "assets/white.png",
    "assets/shoe.png",
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, route[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          spreadRadius: -3,
                          offset: Offset(0, 3),
                          color: AppColors.boxShadowPink,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(serviceIcons[index], height: 85),
                        const SizedBox(height: 8),
                        Text(
                          serviceTitles[index],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 6, // 2 rows × 3
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Wash & Iron",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        SliverCartItemList(items: washItems),
      ],
    );
  }
}
