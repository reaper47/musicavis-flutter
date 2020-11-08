import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicavis/ui/meta/bottom_navigation.dart';
import 'package:musicavis/ui/meta/route_wrapper.dart';

final routeIndexProvider = StateProvider<int>((ref) => 0);

final routeTitleProvider = Provider<String>((ref) {
  final index = ref.watch(routeIndexProvider).state;
  return routes[RouteType.values.elementAt(index)].name;
});

final currentRouteProvider = ScopedProvider<AppRoute>((_) => null);

final currentTypeProvider = ScopedProvider<RouteType>((_) => null);

final typeKeySetProvider =
    Provider.autoDispose.family<RouteKeySet, RouteType>((ref, type) {
  final keySet = RouteKeySet(GlobalKey(), GlobalKey<NavigatorState>());
  ref.maintainState = true;
  return keySet;
});

final routeProvider =
    Provider.family<Widget, AppRoute>((ref, routeData) => routeData.screen);
