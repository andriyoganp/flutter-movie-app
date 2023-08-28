class Movie {
  Movie({
    required this.id,
    required this.genreNames,
    required this.overview,
    required this.posterPath,
    required this.runtime,
    required this.title,
  });

  final int id;
  final List<String> genreNames;
  final String overview;
  final String posterPath;
  final int runtime;
  final String title;

  String get durationFormat {
    final int hour = runtime ~/ 60;
    final int minutes = runtime % 60;
    return '${hour}h ${minutes}m';
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title}';
  }
}
