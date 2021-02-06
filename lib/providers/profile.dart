import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/utils/enums.dart';
import 'package:musicavis/utils/extensions.dart';
import 'package:musicavis/utils/templates.dart';

final statisticsProvider = StateNotifierProvider((_) => StatisticsProvider());

class StatisticsProvider extends StateNotifier<ProfileData> {
  StatisticsProvider() : super(ProfileData());

  List<List<String>> get statistics => state.statistics;

  void updateStatistics() {
    state.updateStatistics();
    state = state;
  }

  void updateCategory(dynamic value) {
    state.selectedCategory = StatisticsModule.values.firstWhere(
        (e) => e.toString() == 'StatisticsModule.${value.toLowerCase()}');
    state = state;
  }
}

class ProfileData {
  Map<StatisticsModule, Map<String, dynamic>> stats;
  StatisticsModule selectedCategory;
  bool hasPractices;

  ProfileData() {
    stats = {
      StatisticsModule.practice: {
        'Total': 0,
        'Average': 0,
        'Median': 0,
        'Longest': 0,
        'Shortest': 0
      },
      StatisticsModule.exercises: {
        'Number of exercises': 0,
        'Average number of exercises': 0,
        'Median number of exercises': 0,
        'Average exercise length': 0,
        'Median exercise length': 0,
      },
      StatisticsModule.instruments: {
        'Most practiced': '',
        'Least practiced': '',
      },
    };

    updateStatistics();
    selectedCategory = StatisticsModule.practice;
  }

  List<String> get categories =>
      StatisticsModule.values.map((e) => e.name).toList();

  String get category => selectedCategory.name;

  List<List<String>> get statistics {
    final items = this.stats[selectedCategory];
    List<List<String>> stats = [];

    switch (selectedCategory) {
      case StatisticsModule.practice:
        items.entries.forEach((item) =>
            stats.add(['${item.key} practice time', '${item.value}m']));
        return stats;
      case StatisticsModule.exercises:
      case StatisticsModule.instruments:
        items.entries
            .forEach((item) => stats.add(['${item.key}', '${item.value}']));
        return stats;
      default:
        return [];
    }
  }

  void updateStatistics() {
    final box = Hive.box<Practice>(PRACTICES_BOX);
    final practices = box.values.toList();
    hasPractices = practices.isNotEmpty;
    if (!hasPractices) {
      return;
    }

    var module = StatisticsModule.practice;
    final times = [for (var x in practices) x.practiceTime]..sort();
    final totalTime = times.fold(0, (prev, el) => prev + el);
    stats[module]['Total'] = totalTime;
    stats[module]['Average'] = totalTime / practices.length;
    stats[module]['Median'] = times[times.length ~/ 2];
    stats[module]['Longest'] = times.last;
    stats[module]['Shortest'] = times.first;

    module = StatisticsModule.exercises;
    final exercisesBox = Hive.box<Exercise>(EXERCISES_BOX);
    final numExercises = exercisesBox.keys.length;
    final numExercisesPerPractice =
        practices.map((e) => e.exercises.length).toList()..sort();
    final exerciseLengths = exercisesBox.values.map((e) => e.minutes).toList()
      ..sort();
    stats[module]['Number of exercises'] = numExercises;
    stats[module]['Average number of exercises'] =
        numExercisesPerPractice.fold(0, (prev, el) => prev + el) /
            practices.length;
    stats[module]['Median number of exercises'] =
        numExercisesPerPractice[numExercisesPerPractice.length ~/ 2];
    stats[module]['Average exercise length'] =
        exerciseLengths.fold(0, (prev, el) => prev + el) /
            exerciseLengths.length;
    stats[module]['Median exercise length'] =
        exerciseLengths[exerciseLengths.length ~/ 2];

    module = StatisticsModule.instruments;
    final instruments = practices.map((e) => e.instrument).toList();
    final sortedMap = makeSortedMap(instruments);
    stats[module]['Most practiced'] = sortedMap.keys.last;
    stats[module]['Least practiced'] =
        instruments.length > 1 ? sortedMap.keys.first : 'None';
  }

  @override
  String toString() => '$stats';
}
