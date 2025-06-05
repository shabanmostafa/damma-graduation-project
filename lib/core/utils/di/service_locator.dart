// core/utils/di/service_locator.dart

import 'package:damma_project/features/add_post/data/repo/post_repo.dart';
import 'package:damma_project/features/add_post/data/repo/post_repo_imp.dart';
import 'package:damma_project/features/add_post/manager/post_cubit.dart';
import 'package:damma_project/features/home/data/repos/home_user_repo_impl.dart';
import 'package:damma_project/features/isNotFriend/data/repo/friend_repo.dart';
import 'package:damma_project/features/isNotFriend/data/repo/friend_repo_impl.dart';
import 'package:damma_project/features/my_friends/data/repo/my_friends_repo_imp.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo_imp.dart';
import 'package:damma_project/features/requestes%20Sended/data/repos/request_sent_repo.dart';
import 'package:damma_project/features/requestes%20Sended/data/repos/request_sent_repo_impl.dart';
import 'package:damma_project/features/requstes_recieved/data/repos/requests_received_repo.dart';
import 'package:damma_project/features/requstes_recieved/data/repos/requests_received_repo_impl.dart';
import 'package:damma_project/features/search/data/repo/search_repo_imp.dart';
import 'package:damma_project/features/isFreind/data/repos/friendship_repo.dart';
import 'package:damma_project/features/isFreind/data/repos/friendship_repo_impl.dart';
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

  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<MyFriendsRepoImpl>(
    MyFriendsRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<FriendshipRepo>(
    FriendshipRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<FriendRepo>(
    FriendRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<RequestSentRepo>(
    RequestSentRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<RequestsReceivedRepo>(
    RequestsReceivedRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerSingleton<HomeUserRepoImpl>(
    HomeUserRepoImpl(getIt<DioConsumer>()),
  );

  // Register PostRepo and PostCubit
  getIt.registerSingleton<PostRepoImpl>(
    PostRepoImpl(getIt<DioConsumer>()),
  );

  getIt.registerFactory<PostCubit>(
    () => PostCubit(getIt<PostRepoImpl>()),
  );
}
