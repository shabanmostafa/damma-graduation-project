import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/add_post/presentation/views/add_post_view.dart';
import 'package:damma_project/features/home/data/repos/home_user_repo_impl.dart';
import 'package:damma_project/features/home/data/repos/news_feed_repo.dart';
import 'package:damma_project/features/home/manager/home_cubit.dart';
import 'package:damma_project/features/home/manager/news_feed_cubit.dart';
import 'package:damma_project/features/isFreind/presentation/views/is_friend_view.dart';
import 'package:damma_project/features/isNotFriend/presentation/views/is_not_friend_view.dart';
import 'package:damma_project/features/my_friends/data/repo/my_friends_repo_imp.dart';
import 'package:damma_project/features/my_friends/manager/my_friends_cubit.dart';
import 'package:damma_project/features/my_friends/presentation/views/my_friends_view.dart';
import 'package:damma_project/features/home/presentation/views/home_view.dart';
import 'package:damma_project/features/login/data/repo/login_repo_imp.dart';
import 'package:damma_project/features/login/presentation/views/login_view.dart';
import 'package:damma_project/features/profile/presentation/views/profile_view.dart';
import 'package:damma_project/features/register/data/repos/register_repos/register_repo_imp.dart';
import 'package:damma_project/features/register/data/repos/verify_repo/verify_repo_imp.dart';
import 'package:damma_project/features/register/logic/cubit/verify_cubit.dart';
import 'package:damma_project/features/register/presentation/views/register_view.dart';
import 'package:damma_project/features/requestes%20Sended/data/repos/request_sent_repo.dart';
import 'package:damma_project/features/requestes%20Sended/manager/request_sent_cubit.dart';
import 'package:damma_project/features/search/data/models/search_model/search_model.dart';
import 'package:damma_project/features/search/presentation/views/search_view.dart';
import 'package:damma_project/features/settings/presentation/views/settings_view.dart';
import 'package:damma_project/features/settings/presentation/views/update_profile_view.dart';
import 'package:damma_project/features/welcome/presentation/views/welcome_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/login/manager/login_cubit/login_cubit.dart';
import '../../../features/onBoarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';

import '../../../features/register/logic/cubit/register_cubit.dart';
import '../../../features/register/presentation/views/verify_account_view.dart';
import '../../../features/requestes Sended/presentation/views/requestes_sended_view.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingView:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(getIt<LoginRepoImpl>()),
            child: const LoginView(),
          ),
        );
      case Routes.welcomeView:
        return MaterialPageRoute(
          builder: (context) => const WelcomeView(),
        );

      case Routes.registerView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => RegisterCubit(getIt<RegisterRepoImpl>()),
            child: const RegisterView(),
          ),
        );
      case Routes.verifyAccountView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => VerifyCubit(getIt<VerifyRepoImpl>()),
            child: const VerifyAccountView(),
          ),
        );
      // case Routes.homeView:
      //   final userId = settings.arguments as int;
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (_) =>
      //           HomeCubit(getIt<HomeUserRepoImpl>())..fetchUser(userId),
      //       child: HomeView(userId: userId),
      //     ),
      //   );
      case Routes.homeView:
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    HomeCubit(getIt<HomeUserRepoImpl>())..fetchUser(userId),
              ),
              BlocProvider(
                create: (_) =>
                    NewsFeedCubit(getIt<NewsFeedRepo>())..fetchNewsFeed(),
              ),
            ],
            child: HomeView(userId: userId),
          ),
        );

      case Routes.addPostView:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) => AddPostView(user: user),
        );

      case Routes.searchView:
        return MaterialPageRoute(
          builder: (context) => const SearchView(),
        );
      case Routes.friendView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                MyFriendsCubit(getIt<MyFriendsRepoImpl>())..fetchFriends(),
            child: const MyFriendsView(),
          ),
        );
      case Routes.profileView:
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ProfileView(userId: userId),
        );

      case Routes.settingsView:
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => SettingsView(userId: userId),
        );

      case Routes.upateProfileView:
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => UpdateProfileView(userId: userId),
        );

      case Routes.isFriendView:
        final user = settings.arguments as SearchModel;
        return MaterialPageRoute(
          builder: (context) => IsFriendView(userId: user.id!),
        );

      case Routes.isNotFriendView:
        final user = settings.arguments as SearchModel;

        return MaterialPageRoute(
          builder: (context) => IsNotFriendView(userId: user.id!),
        );

      case Routes.requestesSendedView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                RequestSentCubit(getIt<RequestSentRepo>())..fetchSentRequests(),
            child: const RequestesSendedView(),
          ),
        );

      default:
        return null;
      // MaterialPageRoute(
      //   builder: (context) => Scaffold(
      //     body: Center(
      //       child: Text(
      //         "No route defined for ${settings.name}",
      //       ),
      //     ),
      //   ),
      // );
    }
  }
}
