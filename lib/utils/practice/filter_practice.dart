import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/repository/models/practice.dart';

class FilterPractice {
  final Practice practice;

  List<String> goalsOriginal;
  List<Exercise> exercisesOriginal;
  List<String> positivesOriginal;
  List<String> improvementsOriginal;

  FilterPractice.filter(this.practice) {
    _store();

    final goals = practice.goals.where((x) => x != '').toList();
    final exercises = practice.exercises.where((x) => x.name != '').toList();
    final positives = practice.positives.where((x) => x != '').toList();
    final improvements = practice.improvements.where((x) => x != '').toList();

    practice.goals = goals;
    practice.exercises =
        HiveList(Hive.box<Exercise>(EXERCISES_BOX), objects: exercises);
    practice.positives = positives;
    practice.improvements = improvements;
  }

  _store() {
    goalsOriginal = List.from(practice.goals);
    exercisesOriginal = [for (var x in practice.exercises) x];
    positivesOriginal = List.from(practice.positives);
    improvementsOriginal = List.from(practice.improvements);
  }

  restore() {
    practice.goals = goalsOriginal;
    practice.exercises =
        HiveList(Hive.box<Exercise>(EXERCISES_BOX), objects: exercisesOriginal);
    practice.positives = positivesOriginal;
    practice.improvements = improvementsOriginal;
  }
}
