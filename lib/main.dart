import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:think_and_wash/core/injection.dart' as di;
import 'package:think_and_wash/core/shared_preference.dart';
import 'package:think_and_wash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:think_and_wash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:think_and_wash/features/trackOrder/bloc/track_order_bloc.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_bloc.dart';

import 'package:think_and_wash/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await SharedPreferenceService.init();
  final bool isLoggedIn = SharedPreferenceService.getBool("isLoggedIn");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  AuthBloc(getOtpUsecase: di.sl(), submitOtpUsecase: di.sl()),
        ),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => TrackOrderBloc()),
        BlocProvider(
          create:
              (_) => ProfileBloc(
                profileUsecase: di.sl(),
                getProfileUsecase: di.sl(),
              ),
        ),
        BlocProvider(create: (_) => di.sl<CategoriesBloc>()),
      ],
      child: MyApp(isLogedIn: isLoggedIn),
    ),
  );
  MobileAds.instance.initialize();
}
