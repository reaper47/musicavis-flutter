import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musicavis/providers/theme.dart';

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkModeEnabled = context.read(themeStateNotifier.state);
    return Switch(
        value: isDarkModeEnabled,
        onChanged: (isEnabled) {
          if (isEnabled) {
            context.read(themeStateNotifier).setDarkTheme();
          } else {
            context.read(themeStateNotifier).setLightTheme();
          }
        });
  }
}
