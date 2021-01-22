import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';

class TextTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final notes = useProvider(practiceStateNotifier.state).notes;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: TextEditingController(text: notes),
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          autofocus: false,
          autocorrect: true,
          decoration: InputDecoration(hintText: 'Notes on the practice...'),
          onChanged: (x) => context
              .read(practiceStateNotifier)
              .updateItem(TabType.notes, -1, x),
        ),
      ),
    );
  }
}
