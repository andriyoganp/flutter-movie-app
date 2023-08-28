import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extension/string_ext.dart';
import '../../domain/model/movie.dart';
import '../../ui/resource/fonts.dart';
import '../../ui/resource/ui_colors.dart';
import '../component/image_placeholder.dart';
import '../component/search_field.dart';
import '../cubit/movie_list_cubit.dart';
import '../state/movie_list_state.dart';
import 'movie_detail_page.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchField(
          controller: _searchController,
          onSearchPressed: () {
            _searchMovies();
          },
          onEmptySearch: () {
            _searchMovies();
          },
        ),
        Expanded(
          child: BlocConsumer<MovieListCubit, MovieListState>(
            listener: (_, __) {},
            builder: (_, MovieListState state) {
              const double extraSpace = 40;
              final double childAspectRatio =
                  ((MediaQuery
                      .of(context)
                      .size
                      .width - extraSpace) / 2) / 310;
              return GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: childAspectRatio,
                children: List<Widget>.generate(
                    state.popularSearchMovies.length, (int index) {
                  final Movie movie = state.popularSearchMovies[index];
                  return GestureDetector(
                    onTap: () => _navigateToMovieDetail(movie.id),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: movie.posterPath.imageMovieUrl,
                              placeholder: (_, __) {
                                return const ImagePlaceholder();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Fonts.sfProText,
                            fontWeight: Fonts.sfProTextRegular,
                            color: UiColors.white,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        )
      ],
    );
  }

  void _searchMovies() {
    context.read<MovieListCubit>().searchPopularMovies(_searchController.text);
  }

  void _navigateToMovieDetail(int movieId) {
    Navigator.pushNamed(context, MovieDetailPage.routeName, arguments: movieId);
  }
}
