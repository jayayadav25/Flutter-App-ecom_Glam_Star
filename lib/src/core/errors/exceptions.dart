
class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

// Firebase exceptions
class FirebaseAuthException extends AppException {
  FirebaseAuthException(String message, {String? code})
      : super(message, code: code);
}

class FirestoreException extends AppException {
  FirestoreException(String message, {String? code})
      : super(message, code: code);
}

class StorageException extends AppException {
  StorageException(String message, {String? code})
      : super(message, code: code);
}

// Network Issues
class NetworkException extends AppException {
  NetworkException(String message) : super(message, code: 'network_error');
}

// Cache / Local Storage
class CacheException extends AppException {
  CacheException(String message) : super(message, code: 'cache_error');
}

// Validation Exception
class ValidationException extends AppException {
  ValidationException(String message)
      : super(message, code: 'validation_error');
}