import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/search/data/repo/search_repo_imp.dart';
import 'package:damma_project/features/search/manager/cubit/search_cubit.dart';
import 'package:damma_project/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SearchCubit(getIt<SearchRepoImpl>()),
        child: const SearchViewBody(),
      ),
    );
  }
}
