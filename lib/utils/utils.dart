class Utils {
  Utils._();
  static final Utils instance = Utils._();

  static String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Email is require';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    // Check if the password is null or empty
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one number.';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#\$%\^&\*]').hasMatch(password)) {
      return 'Password must contain at least one special character.';
    }

    // Check if the password has at least 8 characters
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    return null; // Password is valid
  }
}