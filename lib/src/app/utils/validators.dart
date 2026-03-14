// lib/src/utils/validators.dart
// Common form field validators used across Trendora App

class Validators {
  /// Validate email
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';

    return null;
  }

  /// Validate password
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  /// Validate empty field
  static String? requiredField(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  /// Validate phone number
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';

    final phoneRegex = RegExp(r'^[0-9]{10}\$');
    if (!phoneRegex.hasMatch(value)) return 'Enter a valid 10-digit phone number';

    return null;
  }

  /// Price validation
  static String? price(String? value) {
    if (value == null || value.isEmpty) return 'Price is required';

    final price = double.tryParse(value);
    if (price == null) return 'Enter a valid number';
    if (price <= 0) return 'Price must be greater than zero';

    return null;
  }
}