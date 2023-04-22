
import 'package:dio/dio.dart';

class BadRequestException extends DioError {
  BadRequestException(RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);

  // DO SOMETHING
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  // DO SOMETHING
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  // DO SOMETHING
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  // DO SOMETHING
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  // DO SOMETHING
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  // DO SOMETHING
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  // DO SOMETHING
}
