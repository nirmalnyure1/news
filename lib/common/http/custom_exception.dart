class CustomException implements Exception {
  CustomException(this._message, this.statusCode);

  final dynamic _message;
  final int? statusCode;

  dynamic get message => _message;
  @override
  String toString() {
    return "$_message";
  }
}

class NoInternetException extends CustomException {
  NoInternetException(String? message, int? statusCode)
      : super(message, statusCode);
}

class FetchDataException extends CustomException {
  FetchDataException(String? message, int? statusCode)
      : super(message, statusCode);
}
