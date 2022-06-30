import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';


class NotificationService {
  
  Future<void> scheduleDailyNotification(
      {required DateTime scheduledDateTime,
      required String title,
      required int id}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      "Get Your Medicine",
      'its time to get medicine $title',
      _nextInstanceOfTenAM(scheduledDateTime),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM(DateTime scheduledDateTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      scheduledDateTime.hour,
      scheduledDateTime.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  int daysBetween(DateTime from, DateTime to) {
    final fromNew = DateTime(from.year, from.month, from.day);
    final toNew = DateTime(to.year, to.month, to.day);
    return (toNew.difference(fromNew).inHours / 24).round();
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void saveNotificaton(String notificationStringname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("notificationAll", notificationStringname);
  }

  
}
