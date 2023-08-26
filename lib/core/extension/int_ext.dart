extension NullableintOrEmptyExtension on int? {
  int get orZero => this ?? 0;
}
