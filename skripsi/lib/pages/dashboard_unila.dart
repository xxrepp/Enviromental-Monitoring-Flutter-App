import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/status_unila.dart';
import 'package:skripsi/controllers/unila_controller.dart';
import 'package:skripsi/main.dart';
import 'package:skripsi/controllers/general_controller.dart';
import 'package:skripsi/controllers/noti_controller.dart';
import 'package:skripsi/pages/menu.dart';
import 'package:skripsi/pages/detail.dart';

class DashboardUnila extends StatefulWidget {
  const DashboardUnila({super.key});

  @override
  State<DashboardUnila> createState() => _DashboardUnilaState();
}

class _DashboardUnilaState extends State<DashboardUnila> {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  late int index = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.blue[300]!,
              Colors.blue[50]!,
            ])),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: bodyHeight * 0.05,
              ),
              Container(
                height: bodyHeight * 0.05,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rektorat Unila",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: bodyHeight * 0.1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      dateTimeController.time.value,
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: bodyHeight * 0.05,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      dateTimeController.date.value,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.05,
              ),
              Container(
                height: bodyHeight * 0.05,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kondisi Lingkungan Saat Ini",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.05,
              ),
              Expanded(
                // height: bodyHeight * 0.55,
                child: GridParameter(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 1,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
          if (index == 0) {
            // Pindah ke halaman Menu jika index 0 ditekan
            Get.to(() => Menu());
          } else if (index == 1) {
            // Pindah ke halaman Detail jika index 1 ditekan
            Get.to(() => DetailPage());
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.equalizer), label: "Chart"),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class GridParameter extends StatefulWidget {
  GridParameter({super.key});

  @override
  State<GridParameter> createState() => _GridParameterState();
}

class _GridParameterState extends State<GridParameter> {
  final UnilaController parameterController = Get.put(UnilaController());
  final StatusUnilaController statusUnilaController =
      Get.put(StatusUnilaController());
  late var nilaiSuhu;
  late var nilaiTegangan;
  late var nilaiKelembaban;
  late var nilaiAngin;
  late var statusAngin;
  late var statusKelembaban;
  late var statusTegangan;
  late var statusSuhu;

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      final nilaiSuhu = parameterController.suhu.value;
      final nilaiTegangan = parameterController.tegangan.value;
      final nilaiAngin = parameterController.angin.value;
      final nilaiKelembaban = parameterController.kelembaban.value;
      final statusAngin = statusUnilaController.statusAngin.value;
      final statusKelembaban = statusUnilaController.statusKelembaban.value;
      final statusTegangan = statusUnilaController.statusTegangan.value;
      final statusSuhu = statusUnilaController.statusSuhu.value;

      if (statusAngin == "warning") {
        Notif.showNotif(
            id: 1,
            title: "WARNING",
            body: "Nilai Angin Melebihi Batas",
            fln: flutterLocalNotificationsPlugin);
      }
      if (statusKelembaban == "warning") {
        Notif.showNotif(
            id: 2,
            title: "WARNING",
            body: "Nilai Kelembaban Melebihi Batas",
            fln: flutterLocalNotificationsPlugin);
      }
      if (statusTegangan == "warning") {
        Notif.showNotif(
            id: 3,
            title: "WARNING",
            body: "Nilai Tegangan Melebihi Batas",
            fln: flutterLocalNotificationsPlugin);
      }
      if (statusSuhu == "warning") {
        Notif.showNotif(
            id: 4,
            title: "WARNING",
            body: "Nilai Suhu Melebihi Batas",
            fln: flutterLocalNotificationsPlugin);
      }

      return Center(
        child: Container(
          height: bodyHeight * 0.85,
          width: bodyWidth * 0.85,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 2 / 2),
            children: [
              CardMenu(
                iconData: Icons.wb_sunny_outlined,
                dataParameter: "Suhu",
                nilaiData:
                    nilaiSuhu != null && double.tryParse(nilaiSuhu) != null
                        ? "${double.parse(nilaiSuhu).toStringAsFixed(1)} °C"
                        : "...",
              ),
              CardMenu(
                iconData: Icons.bolt_outlined,
                dataParameter: "Tegangan",
                nilaiData: nilaiTegangan != null &&
                        double.tryParse(nilaiTegangan) != null
                    ? "${double.parse(nilaiTegangan).toStringAsFixed(1)} Volt"
                    : "...",
              ),
              CardMenu(
                iconData: Icons.water_drop_outlined,
                dataParameter: "Kelembaban",
                nilaiData: nilaiKelembaban != null &&
                        double.tryParse(nilaiKelembaban) != null
                    ? "${double.parse(nilaiKelembaban).toStringAsFixed(1)} RH"
                    : "...",
              ),
              CardMenu(
                iconData: Icons.air,
                dataParameter: "Kecepatan Angin",
                nilaiData:
                    nilaiAngin != null && double.tryParse(nilaiAngin) != null
                        ? "${double.parse(nilaiAngin).toStringAsFixed(1)} m/s"
                        : "...",
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({
    super.key,
    required this.iconData,
    required this.dataParameter,
    required this.nilaiData,
  });

  final IconData iconData;
  final String dataParameter;
  final String nilaiData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Icon(
              iconData,
              size: 40,
              color: Colors.blue,
            ),
          ),
          Container(
            child: Text(
              dataParameter,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: Text(
              "${nilaiData.toString()}",
              style: TextStyle(fontSize: 35),
            ),
          ),
        ],
      ),
    );
  }
}
