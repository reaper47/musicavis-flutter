import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/utils/dates.dart';

final graphicsProvider = StateNotifierProvider((_) => GraphicsProvider());

class GraphicsProvider extends StateNotifier<GraphicsData> {
  GraphicsProvider() : super(GraphicsData());

  void refresh() => state = state;
}

class GraphicsData {
  Dates _calendarDates;
  Dates _selectedPracticeDates;
  Dates _originalPracticeDates;

  GraphicsData() {
    _calendarDates = Dates.from(DateTime(2020), DateTime(2023));
    _selectedPracticeDates = Dates.fromCurrentMonth();
    _originalPracticeDates = Dates.fromDates(_selectedPracticeDates);
  }

  Dates get calendarDates => _calendarDates;
  Dates get selectedPracticeDates => _selectedPracticeDates;
  Dates get originalPracticeDates => _originalPracticeDates;
  bool get hasPractices => Hive.box<Practice>(PRACTICES_BOX).values.isNotEmpty;

  set startPracticeTime(DateTime date) {
    if (date.isBefore(_selectedPracticeDates.last)) {
      _selectedPracticeDates.first = date;
    }
  }

  set endPracticeTime(DateTime date) {
    if (date.isAfter(_selectedPracticeDates.first)) {
      _selectedPracticeDates.last = date;
    }
  }

  List<Map<String, dynamic>> get practiceGraphData {
    final box = Hive.box<Practice>(PRACTICES_BOX);

    final first = _selectedPracticeDates.first;
    final last = _selectedPracticeDates.last;
    final allPractices =
        box.values.where((x) => isDateBetween(first, x.datetime, last));

    return [
      for (var date in getDatesRange(_selectedPracticeDates))
        {
          'Date': formatDate(date, DateFormat.NUM_MONTH_DAY),
          'Time': allPractices
              .where((x) => isYearMonthDaySame(x.datetime, date))
              .fold(0, (prev, x) => prev + x.practiceTime)
        }
    ];
  }

  void restoreSelectedPracticeDates() {
    _selectedPracticeDates = Dates.fromDates(_originalPracticeDates);
  }

  void updateSelectedPracticeDates() {
    _originalPracticeDates = Dates.fromDates(_selectedPracticeDates);
  }
}
