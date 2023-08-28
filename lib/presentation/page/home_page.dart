import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extension/string_ext.dart';
import '../../domain/model/movie.dart';
import '../../ui/resource/images.dart';
import '../../ui/resource/ui_colors.dart';
import '../component/section_text.dart';
import '../cubit/movie_list_cubit.dart';
import '../state/movie_list_state.dart';
import 'movie_detail_page.dart';

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
                          final Movie movie = state.nowPlayingMovies[index];
                          return GestureDetector(
                            onTap: () => _navigateToMovieDetail(movie.id),
                            child: CachedNetworkImage(
                              imageUrl: movie.posterPath.imageMovieUrl,
                              fit: BoxFit.fitWidth,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: SectionText('Popular Movies')
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
                              final Movie movie = state.popularMovies[index];
                              return GestureDetector(
                                onTap: () => _navigateToMovieDetail(movie.id),
                                child: CachedNetworkImage(
                                  imageUrl: movie.posterPath.imageMovieUrl,
                                ),
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
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: SectionText(
                            'Coming Soon',
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
                              final Movie movie = state.upcomingMovies[index];
                              return GestureDetector(
                                onTap: () => _navigateToMovieDetail(movie.id),
                                child: CachedNetworkImage(
                                  imageUrl: movie.posterPath.imageMovieUrl,
                                ),
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

  void _navigateToMovieDetail(int movieId) {
    debugPrint("NAVIGATE TO DETAIL");
    Navigator.pushNamed(context, MovieDetailPage.routeName, arguments: movieId);
  }
}
