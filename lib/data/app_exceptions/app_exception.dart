class AppException implements Exception {
  final String message;
  final String? details;

  AppException(this.message, {this.details});

  @override
  String toString() => '$message $details';
}

class NoInternetException extends AppException {
  NoInternetException(String message) : super('', details: message);
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException(String message) : super(',', details: message);
}

class RequestTimeoutException extends AppException {
  RequestTimeoutException(String message) : super('', details: message);
}

class UserExistsException extends AppException {
  UserExistsException(String message) : super('', details: message);
}

class UnauthorizedAccessException extends AppException {
  UnauthorizedAccessException(String message) : super('', details: message);
}

class ResourceNotFoundException extends AppException {
  ResourceNotFoundException(String message) : super('', details: message);
}

class ServerException extends AppException {
  ServerException(String message) : super('', details: message);
}

class ValidationException extends AppException {
  ValidationException(String message) : super('', details: message);
}

class WebSocketException extends AppException {
  WebSocketException(String message) : super('', details: message);
}


class BadGatewayException extends AppException {
  BadGatewayException(String message) : super('', details: message);
}

class UnAuthorizedUserException extends AppException {
  UnAuthorizedUserException(String message) : super('', details: message);
}




