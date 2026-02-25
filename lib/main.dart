import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:think_and_wash/features/trackOrder/bloc/track_order_bloc.dart';

import 'package:think_and_wash/my_app.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
        BlocProvider(create: (_) => TrackOrderBloc()),
      ],
      child: MyApp(),
    ),
  );
}
