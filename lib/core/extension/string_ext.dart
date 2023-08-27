import '../config.dart';

extension NullableStringOrEmptyExtension on String? {
  String get orEmpty => this ?? '';
}

extension MovieDBImage on String? {
  String get imageMovieUrl => '${Config.imageBaseUrl}$this';
}
