// // abstract class ProfileState {}

// // class ProfileInitial extends ProfileState {}

// // /// الحالة لما المستخدم يضغط على "عرض كل المنشورات"
// // class ProfileShowAllPosts extends ProfileState {}

// // /// حالة تحميل بيانات البروفايل (مثلاً لو هنجلب من API)
// // class ProfileLoading extends ProfileState {}

// // /// حالة نجاح تحميل البيانات
// // class ProfileLoaded extends ProfileState {}

// // /// حالة فشل تحميل البيانات
// // class ProfileError extends ProfileState {
// //   final String message;

// //   ProfileError(this.message);
// // }

// import 'package:damma_project/core/utils/models/user_model.dart';

// abstract class ProfileState {}

// class ProfileInitial extends ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileSuccess extends ProfileState {
//   final UserModel profile;
//   ProfileSuccess(this.profile);
// }

// class ProfileFailure extends ProfileState {
//   final String error;
//   ProfileFailure(this.error);
// }
import 'package:damma_project/core/utils/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel profile;
  ProfileSuccess(this.profile);
}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure(this.error);
}
