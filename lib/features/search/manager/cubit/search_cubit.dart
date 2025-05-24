import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damma_project/features/search/data/repo/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _repo;

  SearchCubit(this._repo) : super(SearchInitial());

  Future<void> searchFriends(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await _repo.searchFriends(query);
    result.fold(
      (failure) => emit(SearchFailure(failure)),
      (data) => emit(SearchSuccess(data)),
    );
  }
}
