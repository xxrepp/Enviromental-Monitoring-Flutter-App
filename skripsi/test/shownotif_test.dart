import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:skripsi/controllers/noti_controller.dart';

void main() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); // Inisialisasi plugin

  setUpAll(() {
    // Inisialisasi binding untuk unit test
    TestWidgetsFlutterBinding.ensureInitialized();
    // Inisialisasi flutterLocalNotificationsPlugin jika diperlukan
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    Notif.initialize(flutterLocalNotificationsPlugin);
  });

  // Unit test for showNotif function
  test('Cek Tampilan Notifikasi', () {
    expect(
      () => Notif.showNotif(
        id: 1,
        title: "Test Notification",
        body: "This is a test notification",
        fln: flutterLocalNotificationsPlugin,
      ),
      returnsNormally,
    );
  });
}
