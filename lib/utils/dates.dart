import 'package:intl/intl.dart';

class Dates {
  DateTime first;
  DateTime last;

  Dates(this.first, this.last);

  Dates.from(DateTime first, DateTime last) {
    this.first = first;
    this.last = last;
  }

  Dates.fromDates(Dates dates) {
    first = dates.first;
    last = dates.last;
  }

  Dates.fromCurrentMonth() {
    final now = DateTime.now();
    first = DateTime(now.year, now.month, 1);
    last = DateTime(now.year, now.month + 1, 0);
  }

  void replace(DateTime first, DateTime last) {
    this.first = first;
    this.last = last;
  }

  @override
  String toString() => 'Dates { [$first,$last] }';
}

bool isDateBetween(DateTime first, DateTime date, DateTime last) {
  const oneDay = Duration(days: 1);
  return date.isAfter(first.subtract(oneDay)) &&
      date.isBefore(last.add(oneDay));
}

String formatDate(DateTime date, [String format = DateFormat.YEAR_MONTH_DAY]) {
  return DateFormat(format).format(date);
}

List<DateTime> getDatesRange(Dates dates) {
  return [
    for (int i = 0; i <= dates.last.difference(dates.first).inDays; i++)
      dates.first.add(Duration(days: i))
  ];
}

bool isYearMonthDaySame(DateTime first, DateTime last) {
  return first.year == last.year &&
      first.month == last.month &&
      first.day == last.day;
}

int getWeekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
  if (woy < 1) {
    woy = numberWeeksInYear(date.year - 1);
  } else if (woy > numberWeeksInYear(date.year)) {
    woy = 1;
  }
  return woy;
}

int numberWeeksInYear(int year) {
  DateTime dec28 = DateTime(year, 12, 28);
  int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
  return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
}

String getWeekRange(DateTime date) {
  final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
  final days = List.generate(7, (index) => index)
      .map((value) => DateFormat(DateFormat.ABBR_MONTH_DAY)
          .format(firstDayOfWeek.add(Duration(days: value))))
      .toList();
  return '${days.first} - ${days.last}';
}
