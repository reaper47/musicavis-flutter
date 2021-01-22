import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:musicavis/providers/practice.dart';

import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/themes.dart';

StatelessWidget makeTitle(int index, String title, bool isEnabled) =>
    isEnabled ? TitleEnabled(index, title) : TitleDisabled(title);

class TitleEnabled extends HookWidget {
  final int index;
  final String title;

  TitleEnabled(this.index, this.title);

  @override
  Widget build(BuildContext context) {
    final practice = useProvider(practiceStateNotifier);

    return TextField(
      controller: TextEditingController(text: title),
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autofocus: false,
      autocorrect: true,
      style: TextStyle(fontSize: defaultFontSize),
      onChanged: (value) => practice.updateItem(TabType.exercise, index, value),
      decoration: InputDecoration(
        hintText: captionTabType(TabType.exercise),
      ),
    );
  }
}

class TitleDisabled extends StatelessWidget {
  final String title;

  TitleDisabled(this.title);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      style: greyTextStyle(16),
      controller: TextEditingController(text: title),
      decoration: InputDecoration(
        hintText: captionTabType(TabType.exercise),
      ),
    );
  }
}
