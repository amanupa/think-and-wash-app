import 'package:get_it/get_it.dart';
import 'package:think_and_wash/features/categories/data/datasource/remote/categories_remote_data_source.dart';
import 'package:think_and_wash/features/categories/data/repository_impl/categories_repository_impl.dart';
import 'package:think_and_wash/features/categories/domain/repository/categories_repository.dart';
import 'package:think_and_wash/features/categories/domain/usecase/get_categories_usecase.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:think_and_wash/core/api_clients.dart';
import 'package:think_and_wash/features/auth/data/auth_datasource.dart';
import 'package:think_and_wash/features/auth/data/auth_repository_impl.dart';
import 'package:think_and_wash/features/auth/domain/auth_repository.dart';
import 'package:think_and_wash/features/auth/domain/get_otp_usecase.dart';
import 'package:think_and_wash/features/auth/domain/submit_otp_usecase.dart';
import 'package:think_and_wash/features/order/data/datasource/remote_datasource.dart';
import 'package:think_and_wash/features/order/data/order_repository_impl.dart';
import 'package:think_and_wash/features/order/domain/order_repository.dart';
import 'package:think_and_wash/features/order/domain/usecase/create_order_usecase.dart';
import 'package:think_and_wash/features/order/domain/usecase/get_order_usecase.dart';
import 'package:think_and_wash/features/pickupSlot/data/pickup_slot_repository_impl.dart';
import 'package:think_and_wash/features/pickupSlot/data/remote_datasource.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_repository.dart';
import 'package:think_and_wash/features/pickupSlot/domain/pickup_slot_usecase.dart';
import 'package:think_and_wash/features/profile/data/profile_repository_impl.dart';
import 'package:think_and_wash/features/profile/data/remote_data_source.dart';
import 'package:think_and_wash/features/profile/domain/get_profile_usecase.dart';
import 'package:think_and_wash/features/profile/domain/profile_repository.dart';
import 'package:think_and_wash/features/profile/domain/profile_usecase.dart';

final sl = GetIt.instance;

void init() {
  _core();
  _dataSources();
  _repositories();
  _useCases();
}

void _core() {
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
}

void _dataSources() {
  sl.registerLazySingleton<AuthDatasource>(() => AuthDataSourceImpl());
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PickUpSlotRemoteDataSource>(
    () => PickUpSlotRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(),
  );
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<PickupSlotRepository>(
    () => PickupSlotRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(remoteDataSource: sl()),
  );
}

void _useCases() {
  sl.registerLazySingleton(() => GetOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => SubmitOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => ProfileUsecase(repository: sl()));
  sl.registerLazySingleton(() => PickupSlotUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetOrderUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateOrderUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetProfileUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  
  // Blocs
  sl.registerFactory(() => CategoriesBloc(getCategoriesUseCase: sl()));
}
