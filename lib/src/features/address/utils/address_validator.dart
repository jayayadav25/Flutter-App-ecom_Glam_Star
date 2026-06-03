class AddressValidator {

  // Full Name
  static String? validateName(String? value,) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Enter full name';
    }

    if (value.trim().length < 3) {
      return 'Name is too short';
    }

    return null;
  }

  // Phone Number
  static String? validatePhone(String? value,) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Enter phone number';
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
      return 'Invalid phone number';
    }

    return null;
  }

  // Zipcode
  static String? validateZipcode(String? value,) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter zipcode';
    }

    if (!RegExp(r'^[0-9]{6}$').hasMatch(value.trim())) {
      return 'Invalid zipcode';
    }

    return null;
  }

  // Address
  static String? validateAddress(String? value,) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter address';
    }

    if (value.trim().length < 7) {
      return 'Address is too short';
    }

    return null;
  }

  // City
  static String? validateCity(String? value,) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter city';
    }

    if (value.trim().length < 2) {
      return 'Invalid city';
    }

    return null;
  }

  // State
  static String? validateState(String? value,) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Enter state';
    }

    if (value.trim().length < 3) {
      return 'Invalid state';
    }

    return null;
  }
}