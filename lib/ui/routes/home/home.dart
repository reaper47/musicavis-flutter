import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:musicavis/ui/widgets/theme_switch.dart';

class HomeRoute extends HookWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ThemeDropdown(),
      ),
    );
  }
}
