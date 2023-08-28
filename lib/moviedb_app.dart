import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/injection.dart';
import 'domain/use_case/get_movie_list_use_case.dart';
import 'presentation/cubit/movie_list_cubit.dart';
import 'presentation/page/main_page.dart';
import 'router/router_list.dart';
import 'ui/resource/ui_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieListCubit>(
      create: (_) => MovieListCubit(getIt<GetMovieListUseCase>()),
      child: MaterialApp(
        routes: RouterList.list,
        initialRoute: RouterList.initialRoute,
        title: 'MovieDB',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: UiColors.primary),
        ),
        home: const MainPage(),
      ),
    );
  }
}
