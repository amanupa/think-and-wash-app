import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_state.dart';
import 'package:think_and_wash/features/categories/presentation/widgets/sliver_cart_item_list.dart';

import 'package:think_and_wash/features/categories/presentation/widgets/category_detail_screen.dart';
import '../../../core/ads/banner_ad.dart';
import '../../../route/app_routes.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  String _getCategoryIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains("dry clean")) return "assets/dry-clean.png";
    if (lower.contains("premium")) return "assets/primium.png";
    if (lower.contains("home bound")) return "assets/home-bounds.png";
    if (lower.contains("shoe")) return "assets/shoe.png";
    if (lower.contains("bag")) return "assets/bagss.png";
    if (lower.contains("white")) return "assets/white.png";
    return "assets/dry-clean.png"; // Fallback icon for unknown categories
  }

  String? _getCategoryRoute(String name) {
    final lower = name.toLowerCase();
    if (lower.contains("dry clean")) return AppRoutes.dryClean;
    if (lower.contains("premium")) return AppRoutes.premium;
    if (lower.contains("home bound")) return AppRoutes.homebounds;
    if (lower.contains("shoe")) return AppRoutes.shoes;
    if (lower.contains("bag")) return AppRoutes.bags;
    return null; // Unknown categories get routed generically
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesError) {
          return Center(child: Text(state.message));
        } else if (state is CategoriesLoaded) {
          final allCategories = state.categoryModel.data.cast<dynamic>();

          final gridCategories =
              allCategories
                  .where(
                    (cat) => !cat.categoryName.toLowerCase().contains("wash"),
                  )
                  .toList();

          final washCategory = allCategories.firstWhere(
            (cat) => cat.categoryName.toLowerCase().contains("wash"),
            orElse: () => null,
          );

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
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: -3,
                          offset: Offset(0, 0),
                          color: AppColors.boxShadowPink,
                        ),
                      ],
                    ),
                    child: const Center(child: GlobalBannerAd()),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final cat = gridCategories[index];
                    final String catName = cat.categoryName;

                    return InkWell(
                      onTap: () {
                        final routeName = _getCategoryRoute(catName);

                        if (routeName != null) {
                          Navigator.pushNamed(
                            context,
                            routeName,
                            arguments: cat.items,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CategoryDetailScreen(
                                    title: catName,
                                    items: cat.items,
                                  ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
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
                            Image.asset(
                              _getCategoryIcon(catName),
                              height: 85,
                              cacheHeight: 250,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.category,
                                  size: 40,
                                  color: AppColors.primary,
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              catName,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: gridCategories.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                ),
              ),

              if (washCategory != null) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      washCategory.categoryName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                SliverCartItemList(
                  items: washCategory.items,
                  iscartbutton: false,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ],
          );
        }
        return const Center(child: Text("Fetching Categories..."));
      },
    );
  }
}
