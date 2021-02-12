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
