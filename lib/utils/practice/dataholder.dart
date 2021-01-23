import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/practice/index.dart';

class DataHolder {
  List<String> goals;
  Exercises exercises;
  List<String> positives;
  List<String> improvements;

  DataHolder.init({Exercises exercises}) {
    goals = [''];
    this.exercises = exercises;
    positives = [''];
    improvements = [''];
  }

  addEntry(TabType type) {
    switch (type) {
      case TabType.goal:
        goals.add('');
        break;
      case TabType.exercise:
        exercises.add();
        break;
      case TabType.positive:
        positives.add('');
        break;
      case TabType.improvement:
        improvements.add('');
        break;
      default:
    }
  }

  deleteItem(TabType type, int index) {
    switch (type) {
      case TabType.goal:
        goals.removeAt(index);
        break;
      case TabType.exercise:
        exercises.delete(index);
        break;
      case TabType.positive:
        positives.removeAt(index);
        break;
      case TabType.improvement:
        improvements.removeAt(index);
        break;
      default:
    }
  }

  refresh(int index, Exercise exercise) {
    exercise.bpmStart = exercises.bpmStartRanges[index].current;
    exercise.bpmEnd = exercises.bpmEndRanges[index].current;
    exercise.minutes = exercises.minuteRanges[index].current;
  }
}
