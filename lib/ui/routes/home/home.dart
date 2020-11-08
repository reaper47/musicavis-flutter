import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:musicavis/providers/route.dart';
import 'package:musicavis/ui/bottom_navigation.dart';
import 'package:musicavis/ui/widgets/theme_switch.dart';

class HomeRoute extends HookWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeIndex = useProvider(routeIndexProvider).state;
    final routeTitle = useProvider(routeTitleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(routeTitle),
        elevation: 2.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Text('Light Mode',
                    style: Theme.of(context).textTheme.bodyText2),
                DarkModeSwitch(),
                Text('Dark Mode', style: Theme.of(context).textTheme.bodyText2)
              ],
            ),
          ),
        ],
      ),
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
