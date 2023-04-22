
import 'package:dio/dio.dart';
import 'package:orbi_challenge/providers/api/app.interceptors.dart';

class Api {
  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  final dio = createDio();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 15000),
      connectTimeout: const Duration(milliseconds: 15000),
      sendTimeout: const Duration(milliseconds: 15000),
    ));

    dio.interceptors.addAll({AppInterceptors(dio)});

    return dio;
  }
}
