import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/route/app_routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  final List<String> leadingIcon = const [
    "assets/track-order.png",
    "assets/privacy-policy.png",
    "assets/help-support.webp",
    "assets/wathcandearn.png",
  ];
  final List<String> lable = const [
    "Track Order",
    "Privacy & Policy",
    "Customer Support",
    "Watch & Earn",
  ];
  final List<String> route = const [
    AppRoutes.trackOrder,
    AppRoutes.privacyNpolicy,
    AppRoutes.helpNsupport,
    AppRoutes.watchNearn,
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: AppColors.boxShadowPink,
      backgroundColor: AppColors.background,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: -5,
                      offset: Offset(0, 5),
                      color: AppColors.boxShadowPink,
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(route[index]);
                  },
                  leading: SizedBox(
                    height: 40,
                    width: 40,

                    child: Image.asset(leadingIcon[index]),
                  ),
                  title: Text(
                    lable[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 200, child: Image.asset("assets/punjab.png")),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 26,
                  horizontal: 10,
                ),
                child: Text(
                  "Created with love in punjab. ❤️",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    /*padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.boxShadowblue),
            child: Text("Aman"),
          ),
        ],
      ),*/
    /*Drawer(
      // backgroundColor: AppColors.primary,
      shadowColor: AppColors.boxShadowPink,
      child: Column(
        spacing: 10,
        children: [
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: -5,
                    offset: Offset(0, 0),
                    color: AppColors.boxShadowPink,
                  ),
                ],
              ),
            ),
            title: Text("Aman", style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text(
              "9241867776",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Divider(),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: -5,
                    offset: Offset(0, 0),
                    color: AppColors.boxShadowPink,
                  ),
                ],
              ),
              child: Icon(Icons.policy),
            ),
          ),
        ],
      ),
    );*/
  }
}
