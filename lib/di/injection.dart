import 'package:get_it/get_it.dart';

import 'database_di.dart';
import 'network_di.dart';
import 'repository_di.dart';
import 'service_di.dart';
import 'use_case_di.dart';

final GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
  await initDatabase(getIt);
  initNetwork(getIt);
  initService(getIt);
  initRepository(getIt);
  initUseCase(getIt);
}
