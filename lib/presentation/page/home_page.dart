import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extension/string_ext.dart';
import '../../ui/resource/fonts.dart';
import '../../ui/resource/images.dart';
import '../../ui/resource/ui_colors.dart';
import '../cubit/movie_list_cubit.dart';
import '../state/movie_list_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.read<MovieListCubit>()
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchUpcomingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: kToolbarHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: UiColors.black,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            Images.logo,
            height: 35,
          ),
        ),
        Expanded(
          child: BlocConsumer<MovieListCubit, MovieListState>(
            listener: (BuildContext context, MovieListState state) {},
            builder: (BuildContext context, MovieListState state) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: PageView(
                        children: List<Widget>.generate(
                            state.nowPlayingMovies.length, (int index) {
                          return CachedNetworkImage(
                            imageUrl: state.nowPlayingMovies[index].posterPath
                                .imageMovieUrl,
                            fit: BoxFit.fitWidth,
                          );
                        }),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Text(
                            'Popular Movies',
                            style: TextStyle(
                                color: UiColors.white,
                                fontSize: 16,
                                fontWeight: Fonts.sfProTextBold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.popularMovies.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            itemBuilder: (_, int index) {
                              return CachedNetworkImage(
                                imageUrl: state.popularMovies[index].posterPath
                                    .imageMovieUrl,
                              );
                            },
                            separatorBuilder: (_, int index) {
                              return const SizedBox(width: 8);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Text(
                            'Coming Soon',
                            style: TextStyle(
                              color: UiColors.white,
                              fontSize: 16,
                              fontWeight: Fonts.sfProTextBold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.upcomingMovies.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            itemBuilder: (_, int index) {
                              return CachedNetworkImage(
                                imageUrl: state.upcomingMovies[index].posterPath
                                    .imageMovieUrl,
                              );
                            },
                            separatorBuilder: (_, int index) {
                              return const SizedBox(width: 8);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
