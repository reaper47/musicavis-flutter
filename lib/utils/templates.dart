import 'dart:collection';

LinkedHashMap makeSortedMap<T>(Iterable<T> it) {
  var map = Map();
  it.forEach((x) => map[x] = !map.containsKey(x) ? 1 : map[x] + 1);
  final sortedKeys = map.keys.toList(growable: false)
    ..sort((k1, k2) => map[k1].compareTo(map[k2]));
  final sortedMap = LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => map[k]);
  return sortedMap;
}
