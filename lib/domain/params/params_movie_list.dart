enum MovieContentType { nowPlaying, popular, upcoming }

class ParamsMovieList {
  ParamsMovieList({
    this.page = 1,
    this.contentType = MovieContentType.nowPlaying,
  });

  final int page;
  final MovieContentType contentType;

  Map<String, dynamic> get queries => <String, dynamic>{
        'page': page,
        'include_adult': false,
        'include_video': false,
        'sort_by': 'popularity.desc'
      };
}
