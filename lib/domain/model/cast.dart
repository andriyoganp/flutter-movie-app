class Cast {
  Cast({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String profilePath;

  @override
  String toString() {
    return 'Cast{name: $name}';
  }
}
