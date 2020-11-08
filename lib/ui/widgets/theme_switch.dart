import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musicavis/providers/theme.dart';
import 'package:musicavis/utils/constants.dart';

class ThemeDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.read(themeStateNotifier.state);

    return DropdownButton<String>(
      value: theme,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (name) => context.read(themeStateNotifier).setTheme(name),
      items: <String>[LIGHT_THEME_PREF, DARK_THEME_PREF, BLACK_THEME_PREF]
          .map<DropdownMenuItem<String>>(
            (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
    );
  }
}
