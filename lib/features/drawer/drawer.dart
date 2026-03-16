import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/route/app_routes.dart';

import '../../core/shared_preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:think_and_wash/features/auth/presentation/bloc/auth_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  final List<String> leadingIcon = const [
    "assets/profile.png",
    "assets/track-order.png",
    "assets/privacy-policy.png",
    "assets/help-support.webp",
    "assets/wathcandearn.png",
    "assets/logout.png",
  ];

  final List<String> route = const [
    AppRoutes.profile,
    AppRoutes.trackOrder,
    AppRoutes.privacyNpolicy,
    AppRoutes.helpNsupport,
    AppRoutes.watchNearn,
    AppRoutes.login,
  ];

  @override
  Widget build(BuildContext context) {
    String userName = SharedPreferenceService.getString(
      "userName",
      defaultValue: "Complete Profile",
    );

    // 1. Try ProfileBloc first (handles persistent login & profile updates)
    final profileState = context.watch<ProfileBloc>().state;
    if (profileState is ProfileUpdateSuccessState &&
        profileState.usr.name != null &&
        profileState.usr.name!.isNotEmpty) {
      userName = profileState.usr.name!;
    } else {
      // 2. Fallback to AuthBloc (handles first-time login)
      final authState = context.watch<AuthBloc>().state;
      if (authState is OtpValidationSuccess &&
          authState.userMOdel.name != null &&
          authState.userMOdel.name!.isNotEmpty) {
        userName = authState.userMOdel.name!;
      }
    }

    final List<String> lable = [
      userName,
      "Track Order",
      "Privacy & Policy",
      "Customer Support",
      "Watch & Earn",
      "Log Out",
    ];

    return Drawer(
      shadowColor: AppColors.boxShadowPink,
      backgroundColor: AppColors.background,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: lable.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: -6,
                      offset: Offset(0, 5),
                      color: AppColors.boxShadowPink,
                    ),
                  ],
                ),
                child: ListTile(
                  onTap:
                      index == 5
                          ? () {
                            SharedPreferenceService.setBool(
                              "isLoggedIn",
                              false,
                            );
                            SharedPreferenceService.remove("userName");
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(route[index]);
                          }
                          : () {
                            Navigator.of(context).pushNamed(route[index]);
                          },
                  leading: SizedBox(
                    height: 40,
                    width: 40,

                    child: Image.asset(leadingIcon[index]),
                  ),
                  title: Text(
                    lable[index],
                    style: Theme.of(context).textTheme.titleSmall,
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
