import 'package:damma_project/features/search/models/user_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<UserModel> results;

  SearchLoaded(this.results);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
