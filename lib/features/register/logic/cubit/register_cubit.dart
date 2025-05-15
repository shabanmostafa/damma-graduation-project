import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repos/register_repos/register_repo_imp.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepoImpl registerRepo;

  RegisterCubit(this.registerRepo) : super(RegisterInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String dateOfBirth,
    String? phoneNumber,
    String? profileImagePath,
    String? coverImagePath,
  }) async {
    emit(RegisterLoading());
    try {
      final response = await registerRepo.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        dateOfBirth: dateOfBirth,
        phoneNumber: phoneNumber,
        profileImage: profileImagePath,
        coverImage: coverImagePath,
      );

      emit(RegisterSuccess(response));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
  
}
