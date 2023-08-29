import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/config.dart';
import '../core/network/network_checker.dart';

void initNetwork(GetIt getIt) {
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();

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

  getIt
    ..registerSingleton<InternetConnectionChecker>(internetConnectionChecker)
    ..registerLazySingleton<NetworkChecker>(() => NetworkCheckerImpl(getIt()))
    ..registerSingleton<Dio>(dio);
}
