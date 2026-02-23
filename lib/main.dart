import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:think_and_wash/my_app.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
      ],
      child: MyApp(),
    ),
  );
}
