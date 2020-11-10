import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:preferences/preferences.dart';

import 'providers/theme.dart';
import 'ui/meta/meta.dart';
import 'ui/routes/all.dart';
import 'ui/routes/profile/settings.dart';
import 'utils/constants.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Preferences
  await PrefService.init(prefix: 'pref_');
  PrefService.setDefaultValues({
    THEME_PREF: BLACK_THEME_PREF,
    BPM_MIN_PREF: 60.0,
    BPM_MAX_PREF: 200.0,
    EXERCISE_MINUTES_MAX_PREF: '30',
  });

  runApp(ProviderScope(
    child: MusicavisApp(),
  ));
}

class MusicavisApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(themeStateNotifier.state);

    return MaterialApp(
      title: APP_NAME,
      theme: getTheme(theme),
      home: const MetaRoute(),
      routes: {
        ROUTE_HOME: (_) => HomeRoute(),
        ROUTE_PRACTICE: (_) => PracticeRoute(),
        ROUTE_CALENDAR: (_) => CalendarRoute(),
        ROUTE_PROFILE: (_) => ProfileRoute(),
        ROUTE_PROFILE_SETTINGS: (_) => ProfileSettingsRoute(),
      },
    );
  }
}
