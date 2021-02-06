import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/ui/routes/all.dart';
import 'package:musicavis/providers/calendar.dart';

class CalendarRoute extends StatefulHookWidget {
  const CalendarRoute({Key key}) : super(key: key);

  @override
  _CalendarRouteState createState() => _CalendarRouteState();
}

class _CalendarRouteState extends State<CalendarRoute>
    with TickerProviderStateMixin {
  Map<DateTime, List<CalendarEvent>> _events = {};
  DateTime daySelected;
  AnimationController _animationController;
  CalendarController _calendarController = CalendarController();

  @override
  initState() {
    daySelected = DateTime.now();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _events = useProvider(calendarProvider.state);

    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventsList(context))
        ],
      ),
    );
  }

  TableCalendar _buildCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
        formatButtonVisible: false,
        formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) => FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: BuildContainer(
            date.day.toString(),
            Colors.deepOrange[300],
          ),
        ),
        todayDayBuilder: (context, date, _) => BuildContainer(
          date.day.toString(),
          Colors.deepOrange[400],
        ),
        singleMarkerBuilder: (context, date, event) => Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: event.color),
          width: 7.0,
          height: 7.0,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
        ),
      ),
      onDaySelected: (day, events, holidays) {
        setState(() => daySelected = day);
      },
      onVisibleDaysChanged: (first, last, format) {
        context.read(calendarProvider).refreshMonth(first, last);
      },
    );
  }

  ListView _buildEventsList(BuildContext context) {
    return ListView(
      children: context
          .read(calendarProvider)
          .getSelectedEvents(daySelected) //_selectedEvents
          .map(
            (event) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.8),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: Text(event.instrument),
                subtitle: Text('Practice time: ${event.practiceTime}'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _openPracticePage(context, event.id),
              ),
            ),
          )
          .toList(),
    );
  }

  _openPracticePage(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PracticeDetailsRoute(
          StateNotifierProvider(
            (_) => PracticeProvider(Practice.fetch(id), true),
          ),
        ),
      ),
    );
  }
}

class BuildContainer extends StatelessWidget {
  final Color color;
  final String day;

  BuildContainer(this.day, this.color, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      color: color,
      height: 100,
      width: 100,
      child: Text(day, style: TextStyle(fontSize: 16.0)),
    );
  }
}
