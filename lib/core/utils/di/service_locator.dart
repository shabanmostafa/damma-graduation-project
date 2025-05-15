// import 'package:dio/dio.dart';

// import 'package:get_it/get_it.dart';

// import '../../../features/register/data/repos/auth_repo_impl.dart';
// import '../api/dio_consumer.dart';
// import '../secure/secure_storage_service.dart';

// final getIt = GetIt.instance;

// void setup() {
//   getIt.registerSingleton<DioConsumer>(
//     DioConsumer(
//       dio: Dio(),
//       secureStorageService: SecureStorageService(),
//     ),
//   );

//   getIt.registerSingleton<AuthRepoImpl>(
//     AuthRepoImpl(
//       getIt.get<DioConsumer>(),
//       SecureStorageService(),
//     ),
//   );
// }

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/api/dio_consumer.dart';
import '../../../core/utils/secure/secure_storage_service.dart';

import '../../../features/login/data/repo/login_repo_imp.dart';
import '../../../features/register/data/repos/register_repos/register_repo_imp.dart';
import '../../../features/register/data/repos/verify_repo/verify_repo_imp.dart';
import '../api/endpoints.dart';

final getIt = GetIt.instance;

void setup() {
  // Core Services
  getIt.registerSingleton<SecureStorageService>(SecureStorageService());

  getIt.registerSingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = Endpoints.baseUrl;
    return dio;
  }());

  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: getIt<Dio>(),
      secureStorageService: getIt<SecureStorageService>(),
    ),
  );

  // Repositories
  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<RegisterRepoImpl>(
    RegisterRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<VerifyRepoImpl>(
    VerifyRepoImpl(getIt<DioConsumer>()),
  );
}
