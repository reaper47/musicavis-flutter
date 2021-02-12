import 'enums.dart';

extension StringExtension on String {
  String toTitleCase() => this
      .replaceAllMapped(
          RegExp(
              r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
          (Match m) =>
              "${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}")
      .replaceAll(RegExp(r'(_|-)+'), ' ');
}

extension StatisticsModuleExtension on StatisticsModule {
  static const names = {
    StatisticsModule.exercises: 'Exercises',
    StatisticsModule.instruments: 'Instruments',
    StatisticsModule.practice: 'Practice',
  };

  String get name => names[this];
}

extension PopOptionsExtension on PopOption {
  static const names = {
    PopOption.delete: 'Delete',
    PopOption.save: 'Save',
  };

  String get name => names[this];
}

extension GraphEXtension on GraphType {
  static const names = {
    GraphType.practiceTime: 'Practice over Time',
  };

  String get name => names[this];
}
