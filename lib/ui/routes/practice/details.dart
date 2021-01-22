import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';

enum PopOptions {
  Save,
  Delete,
}

class PracticeDetailsRoute extends HookWidget {
  const PracticeDetailsRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useProvider(practiceStateNotifier.state);
    final practice = useProvider(practiceStateNotifier);
    final crud = practice.crud;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Back',
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) => _popMenuHandler(context, value),
              itemBuilder: (context) => EnumToString.toList(PopOptions.values)
                  .map((x) => PopupMenuItem(value: x, child: Text(x)))
                  .toList(),
            )
          ],
          centerTitle: true,
          title: Text(practice.title),
          bottom: TabBar(
            tabs: tabs
                .map(
                  (x) => Tooltip(
                    message: x.title,
                    child: Tab(icon: Icon(x.icon, size: 28)),
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((x) {
            switch (x.tabType) {
              case TabType.goal:
                return ListTab(x.tabType, practice.goals, crud);
              case TabType.exercise:
                return ExerciseTab(practice.dataHolder.exercises, crud);
              case TabType.improvement:
                return ListTab(x.tabType, practice.improvements, crud);
              case TabType.positive:
                return ListTab(x.tabType, practice.positives, crud);
              default:
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextTab(),
                );
            }
          }).toList(),
        ),
      ),
    );
  }

  void _popMenuHandler(BuildContext context, String value) {
    if (value == EnumToString.convertToString(PopOptions.Save)) {
      _save(context);
    } else if (value == EnumToString.convertToString(PopOptions.Delete)) {
      showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Delete Practice'),
          content: Text('Are you sure you want to delete this practice?'),
          actions: [
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
            RaisedButton(
              color: Colors.red[700],
              onPressed: () => _delete(context),
              child: Text('Yes'),
            ),
          ],
          elevation: 24.0,
        ),
      );
    }
  }

  void _save(BuildContext context, {bool popContext = false}) {
    context.read(practiceStateNotifier).save();

    if (!popContext) {
      FlushbarHelper.createSuccess(
        message: 'Practice has been saved.',
        duration: Duration(milliseconds: 2225),
      )..show(context);
    }

    if (popContext) {
      Navigator.of(context).pop();
    }
  }

  void _delete(BuildContext context) {
    context.read(practiceStateNotifier).delete();

    Navigator.of(context).pop();
    Navigator.of(context).pop();

    FlushbarHelper.createError(
      message: 'Practice has been deleted.',
      duration: Duration(milliseconds: 2225),
    )..show(context);
  }
}
