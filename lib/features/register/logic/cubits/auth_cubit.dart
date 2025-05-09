// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '../../data/repos/auth_repo.dart';
// import 'auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit(this.authRepo) : super(UserInitial());

//   final AuthRepo authRepo;
//   final _storage = const FlutterSecureStorage();

//   //final ApiConsumer api;
//   //Sign in Form key
//   GlobalKey<FormState> signInFormKey = GlobalKey();
//   //Sign in email
//   TextEditingController signInEmail = TextEditingController();
//   //Sign in password
//   TextEditingController signInPassword = TextEditingController();
//   //Sign Up Form key
//   GlobalKey<FormState> signUpFormKey = GlobalKey();

//   //Sign up name
//   TextEditingController signUpName = TextEditingController();
//   //Sign up phone number
//   TextEditingController signUpPhoneNumber = TextEditingController();
//   //Sign up email
//   TextEditingController signUpEmail = TextEditingController();
//   //Sign up gender
//   TextEditingController signUpGender = TextEditingController();
//   //Sign up password
//   TextEditingController signUpPassword = TextEditingController();
//   //Sign up confirm password
//   TextEditingController confirmPassword = TextEditingController();

//   register() async {
//     emit(SignUpLoading());
//     final response = await authRepo.register(
//       name: signUpName.text,
//       email: signUpEmail.text,
//       phone: signUpPhoneNumber.text,
//       gender: signUpGender.text,
//       password: signUpPassword.text,
//       confirmPassword: confirmPassword.text,
//     );
//     response.fold(
//       (errMessage) => emit(SignUpFailure(errorMessage: errMessage)),
//       (signUpModel) =>
//           emit(SignUpSuccess(message: 'Created account succesfully')),
//     );
//   }

//   signIn() async {
//     emit(SignInLoading());
//     final response = await authRepo.login(
//       email: signInEmail.text,
//       password: signInPassword.text,
//     );

//     response.fold(
//       (errMessage) => emit(SignInFailure(errorMessage: errMessage)),
//       (signInModel) async {
//         // Extract and save the username
//         final username = signInModel.data?.username ?? 'Guest';
//         await _storage.write(key: 'username', value: username);
//         await _storage.write(
//             key: 'token', value: signInModel.data?.token ?? "");

//         emit(SignInSuccess());
//       },
//     );
//   }

//   Future<String?> getSavedUsername() async {
//     return await _storage.read(key: 'username');
//   }
// }
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/repos/auth_repo.dart';
import 'auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(UserInitial());

  final AuthRepo authRepo;
  final _storage = const FlutterSecureStorage();

  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up gender
  TextEditingController signUpGender = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  // Add methods to update registration data
  void updateRegistrationData({
    String? firstName,
    String? phone,
    String? email,
    String? gender,
    String? password,
    String? confirmPass,
  }) {
    signUpName.text = firstName ?? signUpName.text;
    signUpPhoneNumber.text = phone ?? signUpPhoneNumber.text;
    signUpEmail.text = email ?? signUpEmail.text;
    signUpGender.text = gender ?? signUpGender.text;
    signUpPassword.text = password ?? signUpPassword.text;
    confirmPassword.text = confirmPass ?? confirmPassword.text;
    emit(RegisterDataUpdated());
  }

  // Clear all registration data
  void clearRegistrationData() {
    signUpName.clear();
    signUpPhoneNumber.clear();
    signUpEmail.clear();
    signUpGender.clear();
    signUpPassword.clear();
    confirmPassword.clear();
    emit(RegisterDataUpdated());
  }

  // register() async {
  //   emit(SignUpLoading());
  //   final response = await authRepo.register(
  //     name: signUpName.text,
  //     email: signUpEmail.text,
  //     phone: signUpPhoneNumber.text,
  //     gender: signUpGender.text,
  //     password: signUpPassword.text,
  //     confirmPassword: confirmPassword.text,
  //   );
  //   response.fold(
  //     (errMessage) => emit(SignUpFailure(errorMessage: errMessage)),
  //     (signUpModel) =>
  //         emit(SignUpSuccess(message: 'Created account succesfully')),
  //   );
  // }

  signIn() async {
    emit(SignInLoading());
    final response = await authRepo.login(
      email: signInEmail.text,
      password: signInPassword.text,
    );

    response.fold(
      (errMessage) => emit(SignInFailure(errorMessage: errMessage)),
      (signInModel) async {
        // Extract and save the username
        final username = signInModel.data?.username ?? 'Guest';
        await _storage.write(key: 'username', value: username);
        await _storage.write(
            key: 'token', value: signInModel.data?.token ?? "");

        emit(SignInSuccess());
      },
    );
  }

  Future<String?> getSavedUsername() async {
    return await _storage.read(key: 'username');
  }
}
