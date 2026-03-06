import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:think_and_wash/core/injection.dart' as di;
import 'package:think_and_wash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:think_and_wash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:think_and_wash/features/trackOrder/bloc/track_order_bloc.dart';

import 'package:think_and_wash/my_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await MobileAds.instance.initialize();
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
        BlocProvider(create: (_) => ProfileBloc(profileUsecase: di.sl())),
      ],
      child: MyApp(),
    ),
  );
}
