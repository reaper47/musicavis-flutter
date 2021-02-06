import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/repository/practice/index.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';

class DataHolder {
  Map<TabType, List<String>> listData;
  Exercises exercises;

  DataHolder.from(Practice practice, bool isFromCalendar) {
    listData = {
      TabType.goal: List.from(practice.goals),
      TabType.positive: List.from(practice.positives),
      TabType.improvement: List.from(practice.improvements),
    };
    exercises = Exercises.create(practice.exercises, isFromCalendar);
  }

  bool isEligibleForNewItem(TabType type) {
    if (type == TabType.exercise) {
      return exercises.isElgigibleToAdd();
    }
    return _isEligibleListTabHelper(listData[type]);
  }

  bool _isEligibleListTabHelper(List<String> items) {
    final hasEmptyValue = items.contains('');
    final hasDuplicate = items.toSet().length != items.length;
    return !hasEmptyValue && !hasDuplicate;
  }

  void addEntry(TabType type) {
    if (type == TabType.exercise) {
      exercises.add();
    } else {
      listData[type].add('');
    }
  }

  void deleteItem(TabType type, int index) {
    if (type == TabType.exercise) {
      exercises.delete(index);
    } else {
      listData[type].removeAt(index);
    }
  }

  void refresh(int index, Exercise exercise) {
    exercise.bpmStart = exercises.bpmStartRanges[index].current;
    exercise.bpmEnd = exercises.bpmEndRanges[index].current;
    exercise.minutes = exercises.minuteRanges[index].current;
  }
}
