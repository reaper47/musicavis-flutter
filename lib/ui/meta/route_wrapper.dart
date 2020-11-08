import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/route.dart';

class RouteKeySet {
  final GlobalKey subtreeKey;
  final GlobalKey<NavigatorState> navigatorKey;

  RouteKeySet(this.subtreeKey, this.navigatorKey);
}

class RouteWrapper extends HookWidget {
  const RouteWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeType = useProvider(currentTypeProvider);
    final routeKeys = useProvider(typeKeySetProvider(routeType));
    final routeData = useProvider(currentRouteProvider);

    return KeyedSubtree(
      key: routeKeys.subtreeKey,
      child: Navigator(
        key: routeKeys.navigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (context) => Consumer(
            builder: (_, watch, __) => watch(routeProvider(routeData)),
          ),
        ),
      ),
    );
  }
}
