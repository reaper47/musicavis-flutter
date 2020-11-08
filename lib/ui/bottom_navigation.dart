import 'package:flutter/material.dart';

import 'package:musicavis/utils/constants.dart';
import 'routes/home/home.dart';

final Map<RouteType, Route> routes = const {
  RouteType.home: Route(
    RouteType.home,
    ROUTE_HOME_TITLE,
    Icons.home,
    HomeRoute(),
  ),
  RouteType.practice: Route(
    RouteType.practice,
    ROUTE_PRACTICE_TITLE,
    Icons.music_note,
    HomeRoute(),
  ),
  RouteType.calendar: Route(
    RouteType.calendar,
    ROUTE_CALENDAR_TITLE,
    Icons.calendar_today,
    HomeRoute(),
  ),
  RouteType.profile: Route(
    RouteType.profile,
    ROUTE_PROFILE_TITLE,
    Icons.person,
    HomeRoute(),
  ),
};

enum RouteType {
  home,
  practice,
  calendar,
  profile,
}

class Route {
  final RouteType type;
  final String name;
  final IconData icon;
  final Widget screen;

  const Route(this.type, this.name, this.icon, this.screen);
}
