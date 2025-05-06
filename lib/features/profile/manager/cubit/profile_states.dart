abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

/// حالة تحميل بيانات البروفايل (مثلاً لو هنجلب من API)
class ProfileLoading extends ProfileState {}

/// حالة نجاح تحميل البيانات
class ProfileLoaded extends ProfileState {}

/// حالة فشل تحميل البيانات
class Profilefailure extends ProfileState {
  final String message;

  Profilefailure(this.message);
}
