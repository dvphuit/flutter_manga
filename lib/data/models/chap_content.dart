class ChapContent {
  final int chapId;
  final List<String> pageUrls;

  ChapContent({
    this.chapId,
    this.pageUrls,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChapContent && other.chapId == chapId;
  }

  @override
  int get hashCode => chapId.hashCode ^ pageUrls.hashCode;

  @override
  String toString() {
    return "{$chapId, $pageUrls";
  }
}
