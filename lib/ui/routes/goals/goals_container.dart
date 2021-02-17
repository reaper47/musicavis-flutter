import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:musicavis/providers/goals.dart';
import 'package:musicavis/providers/theme.dart';
import 'package:musicavis/ui/routes/goals/year_selector.dart';
import 'package:musicavis/utils/colors.dart';
import 'package:musicavis/utils/enums.dart';
import 'package:musicavis/utils/extensions.dart';
import 'package:musicavis/utils/themes.dart';

class GoalsContainer extends HookWidget {
  final GoalType type;

  const GoalsContainer(this.type);

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(useProvider(themeStateNotifier.state));
    final provider = useProvider(goalsProvider.state);
    final goals = provider.getGoals(type);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.textSelectionColor.withOpacity(0.4),
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Align(
                    child: Text(type.title, style: bigTextStyle),
                    alignment: const Alignment(-1, 0),
                  ),
                  subtitle: Text(provider.getSubtitle(type)),
                  trailing: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () => onSelectPressed(context, type, provider),
                    child: const Text('Select'),
                  ),
                  onTap: null,
                ),
              ),
              Divider(
                color: theme.textSelectionColor.withOpacity(0.4),
                thickness: 3,
                height: 0,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: goals.length,
                itemBuilder: (context, index) => Padding(
                  padding: index == goals.length - 1
                      ? const EdgeInsets.only(bottom: 24, right: 8.0)
                      : const EdgeInsets.only(right: 8.0),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: rainbow[index % rainbow.length],
                          child: Text((index + 1).toString()),
                          foregroundColor: Colors.white,
                        ),
                        title: TextField(
                          controller: TextEditingController.fromValue(
                            TextEditingValue(
                              text: goals[index],
                              selection: TextSelection.collapsed(
                                offset: goals[index].length,
                              ),
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: type.caption,
                          ),
                          onChanged: (value) =>
                              provider.updateGoal(type, index, value),
                          onEditingComplete: () =>
                              onEditingComplete(context, goals, index),
                        ),
                      ),
                    ),
                    secondaryActions: goals.length == 1
                        ? []
                        : [
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () => context
                                  .read(goalsProvider)
                                  .delete(type, index),
                            )
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSelectPressed(
      BuildContext context, GoalType type, GoalsProviderData provider) {
    if (type == GoalType.yearly) {
      showDialog(
        context: context,
        builder: (context) => YearSelector(
          context.read(goalsProvider),
        ),
      );
    } else {
      _getDate(context, type, provider)
          .then((date) => update(context, type, date));
    }
  }

  Future<DateTime> _getDate(
      BuildContext context, GoalType type, GoalsProviderData provider) {
    final dates = provider.dateRange;
    switch (type) {
      case GoalType.weekly:
        return showDatePicker(
          context: context,
          initialDate: provider.dates[type.name],
          firstDate: dates.first,
          lastDate: dates.last,
        );
      case GoalType.monthly:
        return showMonthPicker(
          context: context,
          initialDate: provider.dates[type.name],
          firstDate: dates.first,
          lastDate: dates.last,
        );
      default:
        return null;
    }
  }

  void onEditingComplete(BuildContext context, List<String> goals, int index) {
    if (context.read(goalsProvider).saveGoals(type)) {
      FlushbarHelper.createSuccess(
        message: 'Goals have been saved.',
        duration: Duration(milliseconds: 2225),
      )..show(context);
    } else {
      FlushbarHelper.createInformation(
        message: 'Goal `${goals[index]}` is listed.',
        duration: Duration(milliseconds: 2225),
      )..show(context);
    }
  }

  void update(BuildContext context, GoalType type, DateTime date) {
    if (date == null) {
      return;
    }

    final goals = context.read(goalsProvider);
    if (type == GoalType.weekly) {
      goals.updateWeek(date);
    } else {
      goals.updateMonth(date);
    }
  }
}
