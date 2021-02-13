import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/utils/dates.dart';

final calendarProvider = StateNotifierProvider((_) => CalendarEvents());

class CalendarEvent {
  final int id;
  final String instrument;
  final DateTime datetime;
  final String practiceTime;
  final Color color;

  const CalendarEvent(
    this.id, {
    this.instrument,
    this.datetime,
    this.practiceTime,
    this.color,
  });
}

class CalendarEvents extends StateNotifier<Map<DateTime, List<CalendarEvent>>> {
  DateTime _first;
  DateTime _last;

  CalendarEvents() : super({}) {
    final now = DateTime.now();
    _first = DateTime(now.year, now.month, 1);
    _last = DateTime(now.year, now.month + 1, 0);
    refreshMonth(_first, _last);
  }

  void refresh() => refreshMonth(_first, _last);

  void refreshMonth(DateTime first, DateTime last) {
    Map<DateTime, List<CalendarEvent>> eventsMap = {};
    Hive.box<Practice>(PRACTICES_BOX)
        .values
        .where((x) => isDateBetween(first, x.datetime, last))
        .map(_toCalendarEvent)
        .forEach((event) => _addToMap(eventsMap, event));

    _first = first;
    _last = last;
    state = eventsMap;
  }

  CalendarEvent _toCalendarEvent(Practice practice) {
    final int totalMinutes =
        practice.exercises.fold(0, (prev, current) => prev + current.minutes) -
            practice.exercises.last.minutes;
    final numHours = totalMinutes ~/ 60;
    final numMinutes = totalMinutes - numHours * 60;

    final date = practice.datetime;
    return CalendarEvent(
      practice.id,
      instrument: practice.instrument,
      datetime: DateTime(date.year, date.month, date.day),
      practiceTime: "${numHours}h${numMinutes.toString().padLeft(2, '0')}",
      color: Colors.primaries[practice.id % Colors.primaries.length],
    );
  }

  void _addToMap(
      Map<DateTime, List<CalendarEvent>> eventsMap, CalendarEvent event) {
    if (eventsMap[event.datetime]?.isEmpty ?? true) {
      eventsMap[event.datetime] = [];
    }
    eventsMap[event.datetime].add(event);
  }

  List getSelectedEvents(DateTime day) {
    day = DateTime(day.year, day.month, day.day);
    if (state.containsKey(day)) {
      return state[day];
    }
    return [];
  }
}
