import 'package:panda_technician/core/exceptions/app_exception_interface.dart';

abstract class HttpException implements AppException {
  final String message;
  final dynamic data;

  HttpException(this.message, [this.data]);

  @override
  String toString() => "$message: $data";
}

class BadRequestException extends HttpException {
  BadRequestException([String? message, dynamic data])
      : super(message ?? 'Bad Request', data);
}

class UnauthorizedException extends HttpException {
  UnauthorizedException([String? message, dynamic data])
      : super(message ?? 'Unauthorized', data);
}

class ForbiddenException extends HttpException {
  ForbiddenException([String? message, dynamic data])
      : super(message ?? 'Forbidden', data);
}

class NotFoundException extends HttpException {
  NotFoundException([String? message, dynamic data])
      : super(message ?? 'Not Found', data);
}

class InternalServerError extends HttpException {
  InternalServerError([String? message, dynamic data])
      : super(message ?? 'Internal Server Error', data);
}

class BadGatewayError extends HttpException {
  BadGatewayError([String? message, dynamic data])
      : super(message ?? 'Internal Server Error', data);
}

class ServiceUnavailableError extends HttpException {
  ServiceUnavailableError([String? message, dynamic data])
      : super(message ?? 'Service Unavailable Error', data);
}

class GatewayTimeoutError extends HttpException {
  GatewayTimeoutError([String? message, dynamic data])
      : super(message ?? 'Gateway Timeout', data);
}

class NullHTTPReponseException extends HttpException {
  NullHTTPReponseException([String? url, dynamic data])
      : super('URL: $url returned null', data);
}

class AppFuncException extends HttpException {
  AppFuncException([String? msg, dynamic data]) : super('Error: $msg', data);
}

class UnknownHttpException extends HttpException {
  UnknownHttpException([String? message, dynamic data])
      : super(message ?? 'Unknown Error', data);
}
