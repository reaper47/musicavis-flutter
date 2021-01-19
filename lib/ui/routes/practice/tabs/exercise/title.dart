import 'package:flutter/material.dart';

import 'package:musicavis/ui/routes/practice/tabs/index.dart';

class TitleEnabled extends StatelessWidget {
  final String title;

  TitleEnabled(this.title);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: title),
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autofocus: false,
      autocorrect: true,
      //style: TextStyle(fontSize: defaultFontSize),
      //onChanged: (value) => title = value,
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
      //style: greyTextStyle(defaultFontSize),
      controller: TextEditingController(text: title),
      decoration: InputDecoration(
        hintText: captionTabType(TabType.exercise),
      ),
    );
  }
}
