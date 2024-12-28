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
    if (value == null) {
      return 'Phone number is required';
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

  static String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a country';
    }
    return null;
  }

  static String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a state';
    }
    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a city';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a gender';
    }
    return null;
  }
}
