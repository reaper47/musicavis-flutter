import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/theme.dart';
import 'ui/routes/home/home.dart';
import 'utils/constants.dart';
import 'utils/themes.dart';

void main() {
  runApp(ProviderScope(child: MusicavisApp()));
}

class MusicavisApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(themeStateNotifier.state);

    return MaterialApp(
      title: APP_NAME,
      theme: getTheme(theme),
      home: const HomeRoute(),
      routes: {
        ROUTE_PRACTICE: (_) => HomeRoute(),
        ROUTE_CALENDAR: (_) => HomeRoute(),
        ROUTE_PROFILE: (_) => HomeRoute(),
      },
    );
  }
}
