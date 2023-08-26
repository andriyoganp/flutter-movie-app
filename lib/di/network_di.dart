import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/config.dart';

void initNetwork(GetIt getIt) {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      queryParameters: <String, dynamic>{
        'api_key': Config.apiKey,
      },
    ),
  );
  dio.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton<Dio>(dio);
}
