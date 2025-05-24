class Validators {
  static String? validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'يجب إدخال $fieldName';
    }
    if (value.length < 2 || value.length > 30) {
      return 'يجب أن يكون $fieldName بين حرفين و30 حرفًا';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يجب إدخال البريد الإلكتروني';
    }
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يجب إدخال كلمة المرور';
    }

    final errors = <String>[];

    if (value.length < 8) {
      errors.add('أن تكون 8 أحرف على الأقل');
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      errors.add('حرف إنجليزي كبير (A-Z)');
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      errors.add('حرف إنجليزي صغير (a-z)');
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      errors.add('رقم (0-9)');
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errors.add('حرف خاص (!@#\$...)');
    }

    if (errors.isNotEmpty) {
      return 'متطلبات كلمة المرور:\n${errors.map((e) => '• $e').join('\n')}';
    }

    return null;
  }

  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'يجب إدخال تاريخ الميلاد';
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'يجب إدخال رقم الجوال';
    }

    final mobileRegex =
        RegExp(r'^\+?\d{10,15}$'); // Supports optional '+' and 10-15 digits

    if (!mobileRegex.hasMatch(value)) {
      return 'رقم الجوال غير صحيح';
    }

    return null;
  }
}
