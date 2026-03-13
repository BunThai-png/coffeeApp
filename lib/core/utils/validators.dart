class Validators {
  static String? requiredField(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? emailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email or phone';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? original) {
    if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? verificationCode(String? value) {
    if (value == null || value.length < 4) {
      return 'Enter valid code';
    }
    return null;
  }
}


