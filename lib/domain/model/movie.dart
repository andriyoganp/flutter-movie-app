import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  Movie({
    required this.id,
    required this.backdropPath,
    required this.genreNames,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  final int id;
  final String backdropPath;
  final List<String> genreNames;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;

  String get durationFormat {
    final int hour = runtime ~/ 60;
    final int minutes = runtime % 60;
    return '${hour}h ${minutes}m';
  }

  String get genresInAString {
    final StringBuffer sb = StringBuffer();
    for (final (int index, String item) in genreNames.indexed) {
      sb.write(item);
      if (index + 1 < genreNames.length) {
        sb.write(', ');
      }
    }
    return sb.toString();
  }

  int get year {
    final DateTime dateFormat = DateFormat('yyyy-MM-dd').parse(releaseDate);
    return dateFormat.year;
  }

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  String toString() {
    return 'Movie{id: $id, title: $title}';
  }
}
