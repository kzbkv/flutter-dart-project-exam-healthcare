import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:math' as math;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _notificationPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> displayNotification({
    required String day,
    required String hour,
    required String minute,
    required String pillName,
    required String countMedicine,
    RemoteMessage? message,
  }) async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    final now = DateTime.now();
    final scheduleTime = DateTime(
      now.year,
      now.month,
      now.day + int.parse(day),
      int.parse(hour),
      int.parse(minute),
    );

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'medical_channel',
      'medical',
      importance: Importance.max,
      priority: Priority.high,
    );
    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    // Получение временной зоны для Алматы
    final timeZone = tz.getLocation('Asia/Almaty');

    // Создание объекта TZDateTime с использованием временной зоны и времени планирования
    final scheduledDateTime = tz.TZDateTime(
      timeZone,
      scheduleTime.year,
      scheduleTime.month,
      scheduleTime.day,
      scheduleTime.hour,
      scheduleTime.minute,
    );

    // Отправка немедленного уведомления сразу после установки расписания
    await _notificationPlugin.show(
      0,
      'Reminder',
      'Вы задали напоминание о том что вам надо принять $countMedicine $pillName',
      platformChannelSpecifics,
    );
    zonedScheduleNotification(
        'Вам надо принять $countMedicine таблетки препората $pillName?', scheduleTime, 'Scheduled Reminder', _notificationPlugin, platformChannelSpecifics);
    // Отправка уведомления по расписанию через 5 минут
    await _notificationPlugin.zonedSchedule(
      1,
      'Scheduled Reminder',
      'Вам надо принять $countMedicine таблетки препората $pillName?',
      scheduledDateTime, // Установка времени через 5 минут
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

Future zonedScheduleNotification(
    String note, DateTime date, String title, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, NotificationDetails notificationDetails) async {
  // IMPORTANT!!
  //tz.initializeTimeZones(); --> call this before using tz.local (ideally put it in your init state)

  int id = math.Random().nextInt(10000);
  print(date.toString());
  final timeZone = tz.getLocation('Asia/Almaty');
  print(tz.TZDateTime.parse(timeZone, date.toString()).toString());
  try {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      note,
      tz.TZDateTime.parse(tz.local, date.toString()),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    return id;
  } catch (e) {
    print("Error at zonedScheduleNotification----------------------------$e");
    if (e == "Invalid argument (scheduledDate): Must be a date in the future: Instance of 'TZDateTime'") {
      Fluttertoast.showToast(msg: "Select future date");
    }
    return -1;
  }
}
