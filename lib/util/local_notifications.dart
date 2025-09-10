import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class LocalNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
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
    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);
    print("show notification");
    await flutterLocalNotificationsPlugin.show(
        0,
        'Hết giờ',
        'Thời gian đếm ngược đã kết thúc.',
        notificationDetails,
      );
    }
}