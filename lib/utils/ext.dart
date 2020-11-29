import 'dart:math';

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
        <K, List<E>>{},
        (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element),
      );
}

extension ExString on String {
  String shortenLargeNumber({digits = 1}) {
    int num = int.parse(this.replaceAll(",", ""));
    int i = (log(num) / log(1000)).truncate();
    return (num / pow(1000, i)).toStringAsFixed(digits) + ['', 'k', 'M', 'B'][i];
  }
}
