import 'package:flutter/material.dart';

import 'package:think_and_wash/core/app_theme.dart';
import 'package:think_and_wash/core/snack_bar_messages.dart';
import 'package:think_and_wash/route/app_routes.dart';
import 'package:think_and_wash/route/routes_navigator.dart';

class MyApp extends StatelessWidget {
  final bool isLogedIn;
  const MyApp({super.key, required this.isLogedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: SnackbarService.messengerKey,
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesNavigator.controller,
      initialRoute: isLogedIn ? AppRoutes.home : AppRoutes.login,
    );
  }
}
