import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const CHANNEL_ID = '#musicavis';
const CHANNEL_NAME = 'Daily Practice Reminder';
const CHANNEL_DESCRIPTION = 'Daily reminder to practice notification';

final notificationsPlugin = FlutterLocalNotificationsPlugin();
String selectedNotificationPayload;

void initNotifications() async {
  tz.initializeTimeZones();

  const initSettingsAndroid = AndroidInitializationSettings('app_icon');
  final initializationSettings = InitializationSettings(
    android: initSettingsAndroid,
  );
  await notificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) async {
    selectedNotificationPayload = payload;
  });
}

Future<void> selectNotification(String payload) async {
  if (payload != null) {
    print('notification payload: $payload');
  }
}

Future<void> scheduleDailyNotification() async {
  const platformSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      CHANNEL_DESCRIPTION,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    ),
  );

  await notificationsPlugin.zonedSchedule(
      0,
      'Your instruments are feeling lonely',
      "Tap to set up today's practice.",
      _nextDay(19),
      platformSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

tz.TZDateTime _nextDay(time) {
  final now = tz.TZDateTime.now(tz.local);
  var scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, time);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
