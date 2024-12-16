class AppValidator {
  static String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validateName(String? value) {
    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Name should only contain alphabets and spaces';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    String pattern = r'^[6-9][0-9]{9}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid Indian phone number (starting with 6,7,8,9)';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include one uppercase letter, one lowercase letter, one digit, and one special character';
    }
    return null;
  }
}
