import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/injection.dart' as di;
import 'package:think_and_wash/features/auth/presentation/bloc/auth_bloc.dart';

import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/trackOrder/bloc/track_order_bloc.dart';

class AppBlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider(
      create:
          (_) => AuthBloc(getOtpUsecase: di.sl(), submitOtpUsecase: di.sl()),
    ),
    BlocProvider(create: (_) => CartBloc()),
    BlocProvider(create: (_) => TrackOrderBloc()),
  ];
}
