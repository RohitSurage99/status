class ApiException implements Exception {

  final _message;

  ApiException([this._message]);

  String toString() {
    return _message;
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String super.message = ""]);
}

class BadRequestException extends ApiException {
  BadRequestException([super.message]);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([super.message]);
}

class InvalidInputException extends ApiException {
  InvalidInputException([String super.message = ""]);
}

class ServerException extends ApiException {
  ServerException([String super.message = ""]);
}