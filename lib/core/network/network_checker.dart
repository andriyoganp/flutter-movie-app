import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkChecker {
  Future<bool> hasConnection();
}

class NetworkCheckerImpl extends NetworkChecker {
  NetworkCheckerImpl(this._checker);

  final InternetConnectionChecker _checker;

  @override
  Future<bool> hasConnection() => _checker.hasConnection;
}
