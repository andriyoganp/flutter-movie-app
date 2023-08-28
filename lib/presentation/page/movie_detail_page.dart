import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extension/string_ext.dart';
import '../../di/injection.dart';
import '../../domain/model/cast.dart';
import '../../domain/model/movie.dart';
import '../../domain/use_case/add_to_favorite_movie_use_case.dart';
import '../../domain/use_case/check_is_favorite_movie_use_case.dart';
import '../../domain/use_case/delete_from_favorite_use_case.dart';
import '../../domain/use_case/get_cast_list_use_case.dart';
import '../../domain/use_case/get_movie_detail_use_case.dart';
import '../../ui/resource/fonts.dart';
import '../../ui/resource/ui_colors.dart';
import '../component/image_placeholder.dart';
import '../component/section_text.dart';
import '../cubit/movie_detail_cubit.dart';
import '../state/movie_detail_state.dart';

part 'movie_detail_page.component.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movieId});

  final int movieId;

  static const String routeName = 'movie-detail-page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>(
      create: (_) => MovieDetailCubit(
        getIt<GetMovieDetailUseCase>(),
        getIt<GetCastListUseCase>(),
        getIt<AddToFavoriteMovieUseCase>(),
        getIt<DeleteFromFavoriteUseCase>(),
        getIt<CheckIsFavoriteMovieUseCase>(),
      ),
      child: _MovieDetailPageContent(movieId: movieId),
    );
  }
}

class _MovieDetailPageContent extends StatefulWidget {
  const _MovieDetailPageContent({required this.movieId});

  final int movieId;

  @override
  State<_MovieDetailPageContent> createState() =>
      __MovieDetailPageContentState();
}

class __MovieDetailPageContentState extends State<_MovieDetailPageContent> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.backgroundColor,
      body: BlocConsumer<MovieDetailCubit, MovieDetailState>(
        listener: (BuildContext context, MovieDetailState state) {},
        builder: (_, MovieDetailState state) {
          final Movie movie = state.movie;
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      if (movie.posterPath.isNotEmpty)
                        CachedNetworkImage(
                          imageUrl: movie.posterPath.imageMovieUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              UiColors.black,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: UiColors.primary,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const <double>[0.5, 1.0],
                                    colors: <Color>[
                                      Colors.transparent,
                                      UiColors.black,
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                        color: UiColors.white,
                                        fontFamily: Fonts.sfProText,
                                        fontWeight: Fonts.sfProTextBold,
                                        fontSize: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      movie.durationFormat,
                                      style: TextStyle(
                                        color: UiColors.white.withOpacity(0.7),
                                        fontFamily: Fonts.sfProText,
                                        fontWeight: Fonts.sfProTextRegular,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    _GenreNames(movie.genreNames),
                                    const SizedBox(height: 12),
                                    IntrinsicWidth(
                                      child: BlocBuilder<MovieDetailCubit,
                                          MovieDetailState>(
                                        builder: (BuildContext context,
                                            MovieDetailState state) {
                                          return state.status.isSuccess
                                              ? _FavoriteButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            MovieDetailCubit>()
                                                        .addOrDeleteFavorite(
                                                          !state.isFavorite,
                                                        );
                                                  },
                                                  isFavorite: state.isFavorite,
                                                )
                                              : const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    movie.overview,
                    style: TextStyle(
                      color: UiColors.white.withOpacity(0.7),
                      fontFamily: Fonts.sfProText,
                      fontWeight: Fonts.sfProTextRegular,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (state.status.isSuccess)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SectionText(
                          'Cast',
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 150,
                        child: state.castStateStatus.isSuccess
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.casts.length,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                itemBuilder: (_, int index) {
                                  final Cast cast = state.casts[index];
                                  return _CastItem(cast);
                                },
                                separatorBuilder: (_, int index) {
                                  return const SizedBox(width: 8);
                                },
                              )
                            : state.castStateStatus.isFailure
                                ? const _CastFailurePlaceholder()
                                : const SizedBox.shrink(),
                      )
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    context.read<MovieDetailCubit>()
      ..fetchMovieDetail(widget.movieId)
      ..fetchCast(widget.movieId)
      ..checkIsFavorite(widget.movieId);
  }
}
