extension NullableIterableOrEmptyExtension<T> on Iterable<T>? {
  Iterable<T> get orEmpty {
    return this ?? <T>[];
  }
}
