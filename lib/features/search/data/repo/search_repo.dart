import 'package:dartz/dartz.dart';
import 'package:damma_project/features/search/data/models/search_model/search_model.dart';

abstract class SearchRepo {
  Future<Either<String, List<SearchModel>>> searchFriends(String query);
}
