// import 'package:bloc/bloc.dart';
// import 'package:damma_project/features/login/data/models/login_response.dart';
// import 'package:damma_project/features/login/data/repo/login_repo_imp.dart';
// import 'package:equatable/equatable.dart';

// part 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   final LoginRepoImpl loginRepo;

//   LoginCubit(this.loginRepo) : super(LoginInitial());

//   Future<void> login(String email, String password) async {
//     emit(LoginLoading());
//     try {
//       final response = await loginRepo.login(email, password);
//       emit(LoginSuccess(response));
//     } catch (e) {
//       emit(LoginFailure(e.toString()));
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:damma_project/features/login/data/models/login_response.dart';
import 'package:damma_project/features/login/data/repo/login_repo_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoImpl loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await loginRepo.login(email, password);
      emit(LoginSuccess(response));
      const storage = FlutterSecureStorage();
      await storage.write(key: 'accessToken', value: response.accessToken);
      await storage.write(key: 'refreshToken', value: response.refreshToken);
      await storage.write(key: 'userId', value: response.id.toString());
    } catch (e) {
      emit(LoginFailure(e.toString().replaceAll('Exception:', '').trim()));
    }
  }
}
