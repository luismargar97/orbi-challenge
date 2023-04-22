import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:orbi_challenge/providers/api/api.errors.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response != null) {
        log("${err.response!.data} ---- ${err.requestOptions.path}");
      }

      switch (err.type) {
        case DioErrorType.connectionTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw DeadlineExceededException(err.requestOptions);
        case DioErrorType.badResponse:
          switch (err.response?.statusCode) {
            case 400:
              handler.next(err);
              throw BadRequestException(err.requestOptions, err.response!);
            case 401:
              // RETRY REQUEST WITH AUTOMATIC REFRESH TOKEN
              break;
            case 404:
              handler.next(err);
              throw NotFoundException(err.requestOptions);
            default:
              handler.next(err);
              throw InternalServerErrorException(err.requestOptions);
          }
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.unknown:
        case DioErrorType.badCertificate:
        case DioErrorType.connectionError:
          throw InternalServerErrorException(err.requestOptions);
      }
    } catch (e) {
      return;
    }
  }
}
