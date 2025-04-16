import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import '../../../features/register/data/repos/auth_repo_impl.dart';
import '../api/dio_consumer.dart';
import '../secure/secure_storage_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: Dio(),
      secureStorageService: SecureStorageService(),
    ),
  );
  // getIt.registerSingleton<HomeRepoImpl>(
  //   HomeRepoImpl(
  //     getIt.get<DioConsumer>(),
  //   ),
  // );

  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      getIt.get<DioConsumer>(),
      SecureStorageService(),
    ),
  );
}
