class Chapter {
  final int mangaId;
  final int chapId;
  final String name;
  final String href;

  double get chapNum => double.parse(name.split(" ").last);

  Chapter({
    this.mangaId,
    this.chapId,
    this.name,
    this.href,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Chapter && other.name == name && other.href == href;
  }

  @override
  int get hashCode => name.hashCode ^ href.hashCode;

  @override
  String toString() {
    return "{$mangaId, $chapId, $name, $href";
  }
}
