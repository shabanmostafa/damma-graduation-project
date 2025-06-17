import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel> getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  return UserModel(
    id: prefs.getInt('userId') ?? 0,
    firstName: prefs.getString('firstName'),
    lastName: prefs.getString('lastName'),
    profileImageUrl: prefs.getString('profileImageUrl'),
  );
}