import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/calendar.dart';
import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/enums.dart';
import 'package:musicavis/utils/extensions.dart';

class PracticeDetailsRoute extends HookWidget {
  final StateNotifierProvider<PracticeProvider> provider;

  const PracticeDetailsRoute(this.provider, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useProvider(provider.state);
    final practice = useProvider(provider);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _save(context, popContext: true),
            tooltip: 'Back',
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) => _popMenuHandler(context, value),
              itemBuilder: (context) => PopOption.values
                  .map((x) => PopupMenuItem(value: x.name, child: Text(x.name)))
                  .toList(),
            )
          ],
          centerTitle: true,
          title: Text(practice.title),
          bottom: TabBar(
            tabs: tabs
                .map((x) => Tooltip(
                      message: x.title,
                      child: Tab(icon: Icon(x.icon, size: 28)),
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _createTabWidgets(context, practice),
        ),
      ),
    );
  }

  List<Widget> _createTabWidgets(
      BuildContext context, PracticeProvider practice) {
    return tabs.map((x) {
      switch (x.tabType) {
        case TabType.goal:
        case TabType.improvement:
        case TabType.positive:
          return ListTab(x.tabType, provider);
        case TabType.exercise:
          return ExerciseTab(provider);
        default:
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextTab(provider),
          );
      }
    }).toList();
  }

  _popMenuHandler(BuildContext context, String value) {
    if (value == PopOption.save.name) {
      _save(context);
    } else if (value == PopOption.delete.name) {
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

  _save(BuildContext context, {bool popContext = false}) {
    context.read(provider).save();
    context.read(calendarProvider).refresh();

    if (!popContext) {
      FlushbarHelper.createSuccess(
        message: 'Practice has been saved.',
        duration: Duration(milliseconds: 2225),
      )..show(context);
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      Navigator.of(context).pop();
    }
  }

  _delete(BuildContext context) {
    context.read(provider).delete();
    context.read(calendarProvider).refresh();
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.of(context).pop();
    Navigator.of(context).pop();

    FlushbarHelper.createError(
      message: 'Practice has been deleted.',
      duration: Duration(milliseconds: 2225),
    )..show(context);
  }
}
