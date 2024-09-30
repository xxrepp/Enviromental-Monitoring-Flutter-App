import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notif {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);

    // Inisialisasi plugin notifikasi
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            'notification_channel_id',
            'channel_name',
            importance: Importance.max,
            enableVibration: true,
            playSound: true,
            enableLights: true,
          ),
        );
  }

  static Future showNotif({
    required int id,
    required String title,
    required String body,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'notification_channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    var notificationDetails =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await fln.show(id, title, body, notificationDetails);
  }
}


// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Notif {
//   static Future initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize =
//         AndroidInitializationSettings('mipmap/launcher_icon');
//     var initializationsettings =
//         InitializationSettings(android: androidInitialize);

//     //inisialisasi plugin notiifikasi
//     await flutterLocalNotificationsPlugin.initialize(initializationsettings);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(
//           AndroidNotificationChannel(
//             '@string/notification_channel_id',
//             'channel_name',
//             importance: Importance.max,
//             enableVibration: true,
//             playSound: true,
//             enableLights: true,
//           ),
//         );
//   }

//   static Future showNotif({
//     required int id,
//     required String title,
//     required String body,
//     var payload,
//     required FlutterLocalNotificationsPlugin fln,
//   }) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       '@string/notification_channel_id',
//       'channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     var not = NotificationDetails(android: androidPlatformChannelSpecifics);

//     await fln.show(id, title, body, not);
//   }
// }
