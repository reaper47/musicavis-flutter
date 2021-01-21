import 'package:musicavis/providers/settings.dart';
import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/ui/widgets/simple_slider.dart';

class CrudOperations {
  final Function add;
  final Function delete;
  final Function update;

  CrudOperations({this.add, this.delete, this.update});
}

class Exercises {
  final List<Exercise> exercises;
  final SettingsState settings;

  List<Values> bpmStartRanges;
  List<Values> bpmEndRanges;
  List<Values> minuteRanges;
  List<bool> isEnabled;

  Exercises.create(this.exercises, this.settings) {
    final bpms = settings.bpmRange;
    final midBpm = (bpms.max + bpms.min) ~/ 2;
    bpmStartRanges =
        exercises.map((e) => Values(bpms.min, midBpm, bpms.max)).toList();
    bpmEndRanges =
        exercises.map((e) => Values(bpms.min, midBpm, bpms.max)).toList();

    final minutesMax = settings.minutesMax;
    minuteRanges = exercises
        .map((e) => Values(1, (minutesMax + 1) ~/ 2, minutesMax))
        .toList();

    isEnabled = exercises.map((e) => true).toList();
  }

  int get length => exercises.length;

  void toggleEnabled(int index) {
    isEnabled[index] = !isEnabled[index];
  }
}
