import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/music_goal.dart';
import 'package:musicavis/utils/dates.dart';
import 'package:musicavis/utils/enums.dart';
import 'package:musicavis/utils/extensions.dart';

const WEEKS = 'W';
const MONTHS = 'M';
const YEARS = 'Y';

final goalsProvider = StateNotifierProvider((_) => GoalsProvider());

class GoalsProvider extends StateNotifier<GoalsProviderData> {
  GoalsProvider() : super(GoalsProviderData());

  String get currentYear => state.currentYear;
  List<String> get years => state.years;

  bool saveGoals(GoalType type) {
    final isSaved = state.saveGoals(type);
    state = state;
    return isSaved;
  }

  void updateWeek(DateTime date) {
    state.updateWeek(date);
    state = state;
  }

  void updateMonth(DateTime date) {
    state.updateMonth(date);
    state = state;
  }

  void updateYear(String year) {
    state.updateYear(int.parse(year));
    state = state;
  }

  void delete(GoalType type, int index) {
    state.delete(type, index);
    state = state;
  }
}

class GoalsProviderData {
  Box box = Hive.box(MUSIC_GOALS_BOX);
  Map<String, DateTime> dates;
  Map<String, String> keys;
  Map<String, List<MusicGoal>> goals;

  GoalsProviderData() {
    final now = DateTime.now();
    dates = {
      GoalType.weekly.name: now,
      GoalType.monthly.name: now,
      GoalType.yearly.name: now,
    };

    keys = {
      GoalType.weekly.name: 'W${getWeekNumber(now)}.${now.year}',
      GoalType.monthly.name: 'M${now.month}.${now.year}',
      GoalType.yearly.name: 'Y${now.year}',
    };

    goals = {
      GoalType.weekly.name: _getGoals(GoalType.weekly.name),
      GoalType.monthly.name: _getGoals(GoalType.monthly.name),
      GoalType.yearly.name: _getGoals(GoalType.yearly.name),
    };

    final List<String> weeks = box.get(WEEKS, defaultValue: []).cast<String>();
    var key = keys[GoalType.weekly.name];
    if (!weeks.contains(key)) {
      weeks.add(key);
      box.put(WEEKS, weeks);
    }

    final List<String> months =
        box.get(MONTHS, defaultValue: []).cast<String>();
    key = keys[GoalType.monthly.name];
    if (!months.contains(key)) {
      months.add(key);
      box.put(MONTHS, months);
    }

    final List<String> years = box.get(YEARS, defaultValue: []).cast<String>();
    key = keys[GoalType.yearly.name];
    if (!years.contains(key)) {
      years.add(key);
      box.put(YEARS, years);
    }
  }

  String get currentYear => dates[GoalType.yearly.name].year.toString();

  List<String> get years {
    final List<String> years = box.get(YEARS);
    return years.map((e) => e.substring(1)).toList()..sort();
  }

  Dates get dateRange {
    final List<String> weeks = box.get(WEEKS);

    var split = weeks.first.substring(1).split('.');
    var weekNumber = int.parse(split.first);
    var first = DateTime(int.parse(split[1]), 1, 1);
    int weekday = first.weekday;
    first = first.add(Duration(days: 7 * weekNumber - (weekday - 1)));

    split = weeks.last.substring(1).split('.');
    weekNumber = int.parse(split.first);
    var last = DateTime(int.parse(split[1]), 1, 1);
    last = last.add(Duration(days: 7 * weekNumber + (7 - weekday)));

    return Dates.from(first, last);
  }

  List<String> getGoals(GoalType type) =>
      goals[type.name].map((e) => e.name).toList();

  String getSubtitle(GoalType type) {
    final date = dates[type.name];
    switch (type) {
      case GoalType.weekly:
        return getWeekRange(date);
      case GoalType.monthly:
        return DateFormat(DateFormat.YEAR_MONTH).format(date);
      case GoalType.yearly:
        return DateFormat(DateFormat.YEAR).format(date);
      default:
        return '';
    }
  }

  bool saveGoals(GoalType type) {
    final names = goals[type.name].map((e) => e.name);
    if (names.toSet().length != names.length) {
      return false;
    }

    box.put(keys[type.name], goals[type.name]);
    if (!names.contains('')) {
      goals[type.name].add(MusicGoal(''));
    }
    return true;
  }

  void updateGoal(GoalType type, int index, String value) =>
      goals[type.name][index].name = value;

  void updateWeek(date) {
    final key = GoalType.weekly.name;
    dates[key] = date;
    keys[key] = 'W${getWeekNumber(date)}.${date.year}';
    goals[key] = _getGoals(key);
  }

  void updateMonth(DateTime date) {
    final key = GoalType.monthly.name;
    dates[key] = date;
    keys[key] = 'M${date.month}.${date.year}';
    goals[key] = _getGoals(key);
  }

  void updateYear(int year) {
    final key = GoalType.yearly.name;
    dates[key] = DateTime(year);
    keys[key] = 'Y$year';
    goals[key] = _getGoals(key);
  }

  List<MusicGoal> _getGoals(String key) =>
      box.get(keys[key], defaultValue: [MusicGoal('')]).cast<MusicGoal>();

  void delete(GoalType type, int index) {
    final key = type.name;
    goals[key].removeAt(index);
    box.put(keys[key], goals[key]);
  }
}
