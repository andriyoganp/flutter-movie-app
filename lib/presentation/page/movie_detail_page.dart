import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extension/string_ext.dart';
import '../../di/injection.dart';
import '../../domain/model/cast.dart';
import '../../domain/model/movie.dart';
import '../../domain/use_case/get_cast_list_use_case.dart';
import '../../domain/use_case/get_movie_detail_use_case.dart';
import '../../ui/resource/fonts.dart';
import '../../ui/resource/ui_colors.dart';
import '../component/section_text.dart';
import '../cubit/movie_detail_cubit.dart';
import '../state/movie_detail_state.dart';

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
      context.read<MovieDetailCubit>().fetchMovieDetail(widget.movieId);
      context.read<MovieDetailCubit>().fetchCast(widget.movieId);
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
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
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color:
                                              UiColors.white.withOpacity(0.12),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add_rounded,
                                            color: UiColors.primary,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Add To Favorite',
                                            style: TextStyle(
                                              color: UiColors.white,
                                              fontFamily: Fonts.sfProText,
                                              fontWeight:
                                                  Fonts.sfProTextRegular,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
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
              Padding(
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
              Expanded(
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
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.casts.length,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (_, int index) {
                          final Cast cast = state.casts[index];
                          return _CastItem(cast);
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
    );
  }
}

class _GenreNames extends StatelessWidget {
  const _GenreNames(this.names);

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        names.length,
        (int index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (index != 0)
                  Icon(
                    Icons.circle,
                    color: UiColors.primary,
                    size: 4,
                  ),
                if (index != 0) const SizedBox(width: 4),
                Text(
                  names[index],
                  style: TextStyle(
                    color: UiColors.white.withOpacity(0.7),
                    fontFamily: Fonts.sfProText,
                    fontWeight: Fonts.sfProTextRegular,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CastItem extends StatelessWidget {
  const _CastItem(this.cast);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: cast.profilePath.imageMovieUrl,
              placeholder: (_, String url) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: UiColors.white.withOpacity(0.7),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.image_outlined, color: UiColors.primary),
                );
              },
              fit: BoxFit.fitWidth,
              height: 90,
              width: 90,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            cast.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: Fonts.sfProText,
              color: UiColors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
