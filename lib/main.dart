import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:preferences/preferences.dart';

import 'providers/theme.dart';
import 'repository/boxes.dart';
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

  // Database
  await Hive.initFlutter();
  registerAdapters();
  openBoxes();

  runApp(ProviderScope(
    child: MusicavisApp2(),
  ));
}

class MusicavisApp2 extends StatefulHookWidget {
  MusicavisApp2({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MusicavisApp2State();
}

class _MusicavisApp2State extends State<MusicavisApp2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    var boxes = [
      PRACTICES_BOX,
      GOALS_BOX,
      EXERCISES_BOX,
      EXERCISE_NAMES_BOX,
      POSITIVES_BOX,
      IMPROVEMENTS_BOX,
    ];
    boxes.forEach((box) => Hive.box(box).compact());
    Hive.close();
    super.dispose();
  }

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
