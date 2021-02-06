import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:musicavis/providers/route.dart';
import 'package:musicavis/utils/constants.dart';
import 'bottom_navigation.dart';
import 'route_wrapper.dart';

class MetaRoute extends HookWidget {
  const MetaRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeTitle = useProvider(routeTitleProvider);
    final routeIndex = useProvider(routeIndexProvider).state;

    return Scaffold(
      appBar: routeTitle == ROUTE_PROFILE_TITLE
          ? AppBar(actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () =>
                    Navigator.of(context).pushNamed(ROUTE_PROFILE_SETTINGS),
                tooltip: 'Settings',
              )
            ])
          : null,
      body: IndexedStack(
        index: routeIndex,
        children: routes.values
            .map(
              (e) => ProviderScope(
                overrides: [
                  currentRouteProvider.overrideWithValue(routes[e.type]),
                  currentTypeProvider.overrideWithValue(e.type)
                ],
                child: const RouteWrapper(),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routeIndex,
        onTap: (index) => context.read(routeIndexProvider).state = index,
        type: BottomNavigationBarType.fixed,
        items: routes.values
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.name,
              ),
            )
            .toList(),
      ),
    );
  }
}
