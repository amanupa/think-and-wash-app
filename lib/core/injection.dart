import 'package:get_it/get_it.dart';
import 'package:think_and_wash/core/api_clients.dart';
import 'package:think_and_wash/features/auth/data/auth_datasource.dart';
import 'package:think_and_wash/features/auth/data/auth_repository_impl.dart';
import 'package:think_and_wash/features/auth/domain/auth_repository.dart';
import 'package:think_and_wash/features/auth/domain/get_otp_usecase.dart';
import 'package:think_and_wash/features/auth/domain/submit_otp_usecase.dart';
import 'package:think_and_wash/features/profile/data/profile_repository_impl.dart';
import 'package:think_and_wash/features/profile/data/remote_data_source.dart';
import 'package:think_and_wash/features/profile/domain/profile_repository.dart';
import 'package:think_and_wash/features/profile/domain/profile_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
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
    () => ProfileRemoteDataSourceImpl(apiClient: sl()),
  );
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(dataSource: sl()),
  );
}

void _useCases() {
  sl.registerLazySingleton(() => GetOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => SubmitOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => ProfileUsecase(repository: sl()));
}
