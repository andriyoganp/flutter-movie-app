import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extension/string_ext.dart';
import '../../di/injection.dart';
import '../../domain/model/movie.dart';
import '../../domain/use_case/delete_from_favorite_use_case.dart';
import '../../domain/use_case/get_favorite_movies_use_case.dart';
import '../../ui/resource/ui_colors.dart';
import '../component/search_field.dart';
import '../cubit/favorite_list_cubit.dart';
import '../state/favorite_list_state.dart';
import 'movie_detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteListCubit>(
      create: (_) => FavoriteListCubit(
        getIt<GetFavoriteMoviesUseCase>(),
        getIt<DeleteFromFavoriteUseCase>(),
      ),
      child: const _FavoritePageContent(),
    );
  }
}

class _FavoritePageContent extends StatefulWidget {
  const _FavoritePageContent();

  @override
  State<_FavoritePageContent> createState() => _FavoritePageContentState();
}

class _FavoritePageContentState extends State<_FavoritePageContent> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchFavoriteMovies);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteListCubit>().fetchFavoriteMovies();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchFavoriteMovies);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchField(
          controller: _searchController,
          onSearchPressed: _searchFavoriteMovies,
          onEmptySearch: _searchFavoriteMovies,
        ),
        Expanded(
          child: BlocBuilder<FavoriteListCubit, FavoriteListState>(
            builder: (BuildContext context, FavoriteListState state) {
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: state.searchMovies.length,
                itemBuilder: (_, int index) {
                  final Movie movie = state.searchMovies[index];
                  return GestureDetector(
                    onTap: () => _navigateToMovieDetail(movie.id),
                    child: SizedBox(
                      height: 90,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: movie.backdropPath.imageMovieUrl,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: UiColors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          _deleteFromFavorite(movie.id),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.favorite,
                                          color: UiColors.primary,
                                          size: 13,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.year.toString(),
                                  style: TextStyle(
                                    color: UiColors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  movie.genresInAString,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: UiColors.white.withOpacity(0.4),
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, int index) {
                  return const SizedBox(height: 12);
                },
              );
            },
          ),
        )
      ],
    );
  }

  void _navigateToMovieDetail(int movieId) {
    Navigator.pushNamed(context, MovieDetailPage.routeName, arguments: movieId);
  }

  void _searchFavoriteMovies() {
    if (_debounce != null) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context
          .read<FavoriteListCubit>()
          .searchFavoriteMovies(_searchController.text);
    });
  }

  void _deleteFromFavorite(int movieId) {
    context.read<FavoriteListCubit>().deleteFavoriteMovie(movieId);
  }
}
