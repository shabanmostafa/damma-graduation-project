import 'package:damma_project/features/search/models/user_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchSeccuss extends SearchState {
  final List<UserModel> results;

  SearchSeccuss(this.results);
}

class SearchFaild extends SearchState {
  final String message;

  SearchFaild(this.message);
}
