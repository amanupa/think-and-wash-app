import 'package:flutter/material.dart';
import 'package:think_and_wash/features/auth/presentation/screen/login.dart';
import 'package:think_and_wash/features/categories/presentation/widgets/dry_clean.dart';
import 'package:think_and_wash/features/helpSupport/help_and_support.dart';
import 'package:think_and_wash/features/home/presentation/home_screen.dart';
import 'package:think_and_wash/features/privacyPolicy/privay_policy.dart';
import 'package:think_and_wash/features/profile/presentation/profile.dart';
import 'package:think_and_wash/features/trackOrder/track_order.dart';
import 'package:think_and_wash/features/watchEarn/watch_and_earn.dart';

import 'package:think_and_wash/route/app_routes.dart';
import 'package:think_and_wash/splash_screen.dart';

class RoutesNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.entry:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => Login(),
          settings: settings,
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: settings,
        );
      case AppRoutes.privacyNpolicy:
        return MaterialPageRoute(
          builder: (context) => PrivayPolicy(),
          settings: settings,
        );
      case AppRoutes.helpNsupport:
        return MaterialPageRoute(
          builder: (context) => HelpAndSupport(),
          settings: settings,
        );
      case AppRoutes.watchNearn:
        return MaterialPageRoute(
          builder: (context) => WatchAndEarn(),
          settings: settings,
        );
      case AppRoutes.trackOrder:
        return MaterialPageRoute(
          builder: (context) => TrackOrder(),
          settings: settings,
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (context) => Profile(),
          settings: settings,
        );
      case AppRoutes.dryClean:
        return MaterialPageRoute(
          builder: (context) => DryClean(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
