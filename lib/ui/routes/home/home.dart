import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ui.dart';
import '../../../providers/route.dart';

class HomeRoute extends HookWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeIndex = useProvider(routeIndexProvider).state;
    final routeTitle = useProvider(routeTitleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(routeTitle),
      ),
      body: Text(routeTitle),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routeIndex,
        onTap: (index) => context.read(routeIndexProvider).state = index,
        type: BottomNavigationBarType.fixed,
        items: routes.values
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.name,
                ))
            .toList(),
      ),
    );
  }
}
