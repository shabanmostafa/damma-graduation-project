import 'package:damma_project/features/search/data/models/search_model/search_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<SearchModel> results;

  SearchSuccess(this.results);
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure(this.error);
}
