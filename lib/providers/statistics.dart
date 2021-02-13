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
  List<String> get categories => state.categories;
  String get category => state.category;
  bool get hasPractices => state.hasPractices();

  void updateStatistics() {
    state.updateStatistics();
    state = state;
  }

  void updateCategory(dynamic value) {
    state.selectedCategory = StatisticsModule.values.firstWhere(
        (e) => e.toString() == 'StatisticsModule.${value.toLowerCase()}');
    state = state;
  }

  void refresh() {
    state.updateStatistics();
    state = state;
  }
}

class ProfileData {
  Map<StatisticsModule, Map<String, dynamic>> _stats;
  StatisticsModule _selectedCategory;

  ProfileData() {
    _stats = {
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

  String get category => _selectedCategory.name;

  List<List<String>> get statistics {
    final items = this._stats[_selectedCategory];
    List<List<String>> stats = [];

    switch (_selectedCategory) {
      case StatisticsModule.practice:
        final base = 'practice time';
        stats.addAll(List.from([
          ['Total $base', "${items['Total']}m"],
          ['Average $base', "${items['Average'].toStringAsFixed(1)}m"],
          ['Median $base', "${items['Median'].toStringAsFixed(1)}m"],
          ['Longest $base', "${items['Longest']}m"],
          ['Shortest $base', "${items['Shortest']}m"],
        ]));
        return stats;
      case StatisticsModule.exercises:
        const String n = 'number of exercises';
        const String len = 'exercise length';
        stats.addAll(List.from([
          ['Number of exercises', "${items['Number of exercises']}"],
          ['Average $n', "${items['Average $n'].round()}", '(per practice)'],
          ['Median $n', "${items['Median $n'].round()}", '(per practice)'],
          ['Average $len', "${items['Average $len'].toStringAsFixed(1)}m"],
          ['Median $len', "${items['Median $len'].toStringAsFixed(1)}m"],
        ]));
        return stats;
      case StatisticsModule.instruments:
        items.entries
            .forEach((item) => stats.add(['${item.key}', '${item.value}']));
        return stats;
      default:
        return [];
    }
  }

  set selectedCategory(StatisticsModule value) => _selectedCategory = value;

  void updateStatistics() {
    final box = Hive.box<Practice>(PRACTICES_BOX);
    final practices = box.values;
    if (practices.isEmpty) {
      return;
    }

    var module = StatisticsModule.practice;
    final times = [for (var x in practices) x.practiceTime]..sort();
    final totalTime = times.fold(0, (prev, el) => prev + el);
    _stats[module]['Total'] = totalTime;
    _stats[module]['Average'] = totalTime / practices.length;
    _stats[module]['Median'] = times[times.length ~/ 2];
    _stats[module]['Longest'] = times.last;
    _stats[module]['Shortest'] = times.first;

    module = StatisticsModule.exercises;
    final exercisesBox = Hive.box<Exercise>(EXERCISES_BOX);
    final exercisesPerPractice =
        practices.map((e) => e.exercises.where((x) => x.name != ''));
    final numExercisesPerPractice =
        exercisesPerPractice.map((e) => e.length).toList()..sort();
    final exerciseLengths =
        exercisesPerPractice.expand((x) => x).map((e) => e.minutes).toList();

    _stats[module]['Number of exercises'] =
        exercisesBox.values.map((e) => e.name).toSet().length - 1;
    _stats[module]['Average number of exercises'] =
        numExercisesPerPractice.fold(0, (prev, el) => prev + el) /
            practices.length;
    _stats[module]['Median number of exercises'] =
        numExercisesPerPractice[numExercisesPerPractice.length ~/ 2];
    _stats[module]['Average exercise length'] =
        exerciseLengths.fold(0, (prev, el) => prev + el) /
            exerciseLengths.length;
    _stats[module]['Median exercise length'] =
        exerciseLengths[exerciseLengths.length ~/ 2];

    module = StatisticsModule.instruments;
    final instruments = practices.map((e) => e.instrument).toList();
    final sortedMap = makeSortedMap(instruments);
    _stats[module]['Most practiced'] = sortedMap.keys.last;
    _stats[module]['Least practiced'] =
        instruments.length > 1 ? sortedMap.keys.first : 'None';
  }

  bool hasPractices() {
    final box = Hive.box<Practice>(PRACTICES_BOX);
    return box.values.isNotEmpty;
  }

  @override
  String toString() => '$_stats';
}
