import 'package:flutter/material.dart';

import 'package:musicavis/ui/routes/all.dart';
import 'package:musicavis/utils/constants.dart';

final Map<RouteType, AppRoute> routes = const {
  RouteType.home: AppRoute(
    RouteType.home,
    ROUTE_HOME_TITLE,
    Icons.home,
    HomeRoute(),
  ),
  RouteType.practice: AppRoute(
    RouteType.practice,
    ROUTE_PRACTICE_TITLE,
    Icons.music_note,
    const PracticeRoute(),
  ),
  RouteType.calendar: AppRoute(
    RouteType.calendar,
    ROUTE_CALENDAR_TITLE,
    Icons.calendar_today,
    const CalendarRoute(),
  ),
  RouteType.profile: AppRoute(
    RouteType.profile,
    ROUTE_PROFILE_TITLE,
    Icons.person,
    const ProfileRoute(),
  ),
};

enum RouteType {
  home,
  practice,
  calendar,
  profile,
}

class AppRoute {
  final RouteType type;
  final String name;
  final IconData icon;
  final Widget screen;

  const AppRoute(this.type, this.name, this.icon, this.screen);
}
