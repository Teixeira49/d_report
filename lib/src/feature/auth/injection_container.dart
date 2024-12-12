/*import 'package:get_it/get_it.dart';

import '../../core/network/network_info.dart';
import 'data/datasource/remote/auth_user_remote_datasource.dart';
import 'data/repository/auth_user_repository_impl.dart';
import 'domain/repository/auth_user_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/cubit/login_auth_cubit/auth_user_cubit.dart';



final sl = GetIt.instance;
void setup() {
  // Bloc
  sl.registerFactory(() => AuthCubit);
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: NetworkInfoImpl()));
  // Data sources
  sl.registerLazySingleton<AuthUserRemoteDataSourceImpl>(() => AuthUserRemoteDataSourceImpl());
}*/