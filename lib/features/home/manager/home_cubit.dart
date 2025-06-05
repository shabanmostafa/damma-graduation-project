import 'package:bloc/bloc.dart';
import 'package:damma_project/features/home/data/repos/home_user_repo.dart.dart';
import 'package:equatable/equatable.dart';
import 'package:damma_project/core/utils/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUserRepo homeUserRepo;

  HomeCubit(this.homeUserRepo) : super(HomeInitial());

  Future<void> fetchUser(int id) async {
    emit(HomeLoading());
    final result = await homeUserRepo.getHomeUserData(id);
    result.fold(
      (errorMessage) => emit(HomeFailure(errorMessage)),
      (user) => emit(HomeSuccess(user)),
    );
  }
}
