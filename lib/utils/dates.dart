bool isDateBetween(DateTime first, DateTime date, DateTime last) {
  const oneDay = Duration(days: 1);
  return date.isAfter(first.subtract(oneDay)) &&
      date.isBefore(last.add(oneDay));
}
