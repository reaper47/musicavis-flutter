import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/ui.dart';
import 'utils/constants.dart';

final counterProvider = Provider((ref) => 0);

void main() {
  runApp(ProviderScope(child: MusicavisApp()));
}

class MusicavisApp extends StatelessWidget {
  const MusicavisApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeRoute(),
      routes: {
        ROUTE_PRACTICE: (_) => HomeRoute(),
        ROUTE_CALENDAR: (_) => HomeRoute(),
        ROUTE_PROFILE: (_) => HomeRoute(),
      },
    );
  }
}
