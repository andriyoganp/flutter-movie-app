extension NullableStringOrEmptyExtension on String? {
  String get orEmpty => this ?? '';
}
