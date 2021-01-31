import 'package:flutter/material.dart';

import 'package:musicavis/repository/practice/index.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/themes.dart';

class TitleEnabled extends StatelessWidget {
  final int index;
  final String title;
  final CrudOperations crud;
  final FocusNode node;

  TitleEnabled(this.index, this.title, this.crud, this.node);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: title),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: defaultFontSize),
      onChanged: (value) => crud.update(TabType.exercise, index, value),
      onEditingComplete: () => crud.add(TabType.exercise),
      decoration: InputDecoration(
        hintText: captionTabType(TabType.exercise),
      ),
      focusNode: node,
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
