import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: CustomScrollView(
          key: PageStorageKey('cat'),
          slivers: [
            SliverAppBar(
              shadowColor: AppColors.boxShadowPink,
              elevation: 10,

              automaticallyImplyLeading: false,
              centerTitle: true,
              pinned: true,
              //floating: true,
              stretch: true,
              //snap: true,
              backgroundColor: AppColors.background,
              title: Text(
                "Categories",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: PageView(
                  children: [
                    Container(color: Colors.red),
                    Container(color: Colors.blue),
                    Container(color: Colors.green),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    height: 80,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(0, 5),
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Center(child: Text("Item $index")),
                  );
                },
                childCount: 30, // important for scroll
              ),
            ),
          ],
        ),
      ),
    );
  }
}
