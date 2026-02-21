import 'package:flutter/material.dart';
import 'package:think_and_wash/features/auth/presentation/screen/login.dart';
import 'package:think_and_wash/features/home/presentation/home_screen.dart';

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
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
