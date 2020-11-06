import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/ui.dart';

final routeIndexProvider = StateProvider<int>((ref) => 0);

final routeTitleProvider = Provider<String>((ref) {
  final index = ref.watch(routeIndexProvider).state;
  return routes[RouteType.values.elementAt(index)].name;
});
