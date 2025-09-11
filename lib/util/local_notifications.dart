import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as timezone;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit,);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
    
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'countdown_channel',
      'Countdown Notifications', 
      channelDescription: 'Thông báo khi đếm ngược kết thúc',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    print("show notification");
    await flutterLocalNotificationsPlugin.show(
        0,
        'Hết giờ',
        'Thời gian đếm ngược đã kết thúc.',
        notificationDetails,
      );
    }

  static Future<void> showNotificationAfter(int seconds) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'countdown_channel',
      'Countdown Notifications', 
      channelDescription: 'Thông báo khi đếm ngược kết thúc',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    print("show notification");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // id
    'Hẹn giờ xong', // title
    'Đã đến lúc bạn cần xem thông báo này',
    timezone.TZDateTime.now(timezone.local).add(Duration(seconds: seconds)), 
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    payload: 'Thông tin ....',);
  }
}