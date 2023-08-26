class ParamsMovieList {
  ParamsMovieList({this.page = 1, this.isUpcoming = false});

  final int page;
  final bool isUpcoming;

  Map<String, dynamic> get queries => <String, dynamic>{
        'page': page,
        'include_adult': false,
        'include_video': false,
        'sort_by': 'popularity.desc'
      };
}
