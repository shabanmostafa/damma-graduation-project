import 'package:damma_project/features/profile/data/repo/profile_repo.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;
  int? userId; // store userId internally

  ProfileCubit(this._repo) : super(ProfileInitial());

  Future<void> getProfile(int id) async {
    userId = id;
    emit(ProfileLoading());
    final result = await _repo.getProfileData(id);
    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }


  Future<void> updateCoverImage(String filePath) async {
    emit(ProfileLoading());
    final result = await _repo.updateCoverImage(filePath);
    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }

  Future<void> updateProfileImage(String filePath) async {
    emit(ProfileLoading());
    final result = await _repo.updateProfileImage(filePath);
    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }

  Future<void> updateFirstName(String firstName) async {
    emit(ProfileLoading());
    final result = await _repo.updateFirstName(firstName);
    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }

  Future<void> updateLastName(String lastName) async {
    emit(ProfileLoading());
    final result = await _repo.updateLastName(lastName);
    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    final result = await _repo.logout();
    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (_) {
        emit(ProfileInitial());
      },
    );
  }

  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    final result = await _repo.delete();
    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (_) {
        emit(ProfileInitial());
      },
    );
  }

  Future<bool> getVerificationCode() async {
    emit(ProfileLoading());
    final result = await _repo.getVerificationCode();
    bool success = false;
    result.fold(
      (failure) {
        emit(ProfileFailure(failure));
        success = false;
      },
      (_) {
        emit(ProfileInitial());
        success = true;
      },
    );
    return success;
  }

  Future<bool> resetPassword(
      String newPassword, String verificationCode) async {
    emit(ProfileLoading());
    final result = await _repo.resetPassword(newPassword, verificationCode);
    bool success = false;
    result.fold(
      (failure) {
        emit(ProfileFailure(failure));
        success = false;
      },
      (_) {
        emit(ProfileInitial());
        success = true;
      },
    );
    return success;
  }
}
