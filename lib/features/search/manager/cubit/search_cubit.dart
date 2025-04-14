import 'package:damma_project/features/search/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final List<UserModel> _dummyUsers = [
    UserModel(
        name: "محمد أحمد",
        jobTitle: "Software Engineer",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "سارة علي",
        jobTitle: "Product Manager",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "محمود خالد",
        jobTitle: "UI/UX Designer",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "محمد أحمد",
        jobTitle: "Software Engineer",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "سارة علي",
        jobTitle: "Product Manager",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "محمود خالد",
        jobTitle: "UI/UX Designer",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "محمد أحمد",
        jobTitle: "Software Engineer",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "سارة علي",
        jobTitle: "Product Manager",
        imageUrl: "assets/images/shaban.jpg"),
    UserModel(
        name: "محمود خالد",
        jobTitle: "UI/UX Designer",
        imageUrl: "assets/images/shaban.jpg"),
  ];

  void search(String query) {
    if (query.isEmpty) {
      emit(SearchInitial());
    } else {
      final results = _dummyUsers
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(SearchSeccuss(results));
    }
  }
}
