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
      _onRefresh();
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
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 260,
                        child: PageView(
                          children: List<Widget>.generate(
                              state.nowPlayingMovies.length, (int index) {
                            final Movie movie = state.nowPlayingMovies[index];
                            return _MovieItem(movie, fit: BoxFit.fitWidth);
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
                              child: SectionText('Popular Movies')),
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
                                return _MovieItem(movie);
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
                                return _MovieItem(movie);
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
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Future<void> _onRefresh() async {
    context.read<MovieListCubit>()
      ..fetchNowPlayingMovies()
      ..fetchPopularMovies()
      ..fetchUpcomingMovies();
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem(this.movie, {this.fit});

  final Movie movie;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToMovieDetail(context, movie.id),
      child: CachedNetworkImage(
        imageUrl: movie.posterPath.imageMovieUrl,
        fit: fit,
      ),
    );
  }

  void _navigateToMovieDetail(BuildContext context, int movieId) {
    Navigator.pushNamed(context, MovieDetailPage.routeName, arguments: movieId);
  }
}
