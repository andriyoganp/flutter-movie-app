import 'package:flutter/widgets.dart';

import '../presentation/page/main_page.dart';
import '../presentation/page/movie_detail_page.dart';

class RouterList {
  RouterList._();

  static const String initialRoute = MainPage.routeName;

  static Map<String, WidgetBuilder> list = <String, WidgetBuilder>{
    MainPage.routeName: (_) => const MainPage(),
    MovieDetailPage.routeName: (BuildContext context) {
      final Object? movieId = ModalRoute.of(context)?.settings.arguments;
      if (movieId is int) {
        return MovieDetailPage(movieId: movieId);
      } else {
        return const SizedBox.shrink();
      }
    }
  };
}
