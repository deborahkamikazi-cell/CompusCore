/// Form validators. ALU email checks are ready for the register/login forms.
abstract final class Validators {
  // TODO: Confirm official ALU domains with the identity team before launch.
  static const aluStudentDomain = '@alustudent.com';
  static const aluStaffDomain = '@alueducation.com';

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredField(value, fieldName: 'Email');
    if (requiredError != null) {
      return requiredError;
    }
    if (!_emailPattern.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? aluEmail(String? value) {
    final emailError = email(value);
    if (emailError != null) {
      return emailError;
    }
    if (!isAluEmail(value!.trim())) {
      return 'Use a verified ALU email address';
    }
    return null;
  }

  static bool isAluEmail(String email) {
    final normalized = email.trim().toLowerCase();
    return normalized.endsWith(aluStudentDomain) ||
        normalized.endsWith(aluStaffDomain);
  }

  static String? minLength(
    String? value,
    int min, {
    String fieldName = 'This field',
  }) {
    final requiredError = requiredField(value, fieldName: fieldName);
    if (requiredError != null) {
      return requiredError;
    }
    if (value!.trim().length < min) {
      return '$fieldName must be at least $min characters';
    }
    return null;
  }
}
