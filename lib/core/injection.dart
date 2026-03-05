import 'package:get_it/get_it.dart';
import 'package:think_and_wash/features/auth/data/auth_datasource.dart';
import 'package:think_and_wash/features/auth/data/auth_repository_impl.dart';
import 'package:think_and_wash/features/auth/domain/auth_repository.dart';
import 'package:think_and_wash/features/auth/domain/get_otp_usecase.dart';
import 'package:think_and_wash/features/auth/domain/submit_otp_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _dataSources();
  _repositories();
  _useCases();
}

void _dataSources() {
  sl.registerLazySingleton<AuthDatasource>(() => AuthDataSourceImpl());
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );
}

void _useCases() {
  sl.registerLazySingleton(() => GetOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => SubmitOtpUsecase(repository: sl()));
}
