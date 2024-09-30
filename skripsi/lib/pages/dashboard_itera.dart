import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/itera_controller.dart';
import 'package:skripsi/controllers/status_itera.dart';
import 'package:skripsi/main.dart';
import 'package:skripsi/controllers/general_controller.dart';
import 'package:skripsi/controllers/noti_controller.dart';
import 'package:skripsi/pages/menu.dart';
import 'package:skripsi/pages/detail.dart';

class DashboardItera extends StatefulWidget {
  const DashboardItera({super.key});

  @override
  State<DashboardItera> createState() => _DashboardIteraState();
}

class _DashboardIteraState extends State<DashboardItera> {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  late int index = 0;

  @override
  void initState() {
    super.initState();
  }

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
                      "Itera",
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            )),
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
  final IteraController parameterController = Get.put(IteraController());
  final StatusIteraController statusIteraController =
      Get.put(StatusIteraController());
  late var nilaiEhz;
  late var nilaiEhn;
  late var nilaiEhe;
  var statusEhe = "safe";
  var statusEhn = "safe";
  var statusEhz = "safe";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      final nilaiEhz = parameterController.ehz.value;
      final nilaiEhn = parameterController.ehn.value;
      final nilaiEhe = parameterController.ehe.value;
      final statusEhe = statusIteraController.statusEhe.value;
      final statusEhn = statusIteraController.statusEhn.value;
      final statusEhz = statusIteraController.statusEhz.value;

      if (statusEhe == "warning") {
        Notif.showNotif(
            id: 5,
            title: "WARNING",
            body: "Nilai Getaran E Melebihi Batas",
            fln: flutterLocalNotificationsPlugin);
      }
      if (statusEhn == "warning") {
        Notif.showNotif(
            id: 6,
            title: "WARNING",
            body: "Nilai Getaran N Melebihi Batas",
            fln: flutterLocalNotificationsPlugin);
      }
      if (statusEhz == "warning") {
        Notif.showNotif(
            id: 7,
            title: "WARNING",
            body: "Nilai Getaran Z Melebihi Batas",
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
                iconData: Icons.vibration_outlined,
                dataParameter: "Getaran Z",
                nilaiData: nilaiEhz != null && double.tryParse(nilaiEhz) != null
                    ? "$nilaiEhz Hz"
                    : "...",
              ),
              CardMenu(
                iconData: Icons.vibration_outlined,
                dataParameter: "Getaran E",
                nilaiData: nilaiEhe != null && double.tryParse(nilaiEhe) != null
                    ? "$nilaiEhe Hz"
                    : "...",
              ),
              CardMenu(
                iconData: Icons.vibration_outlined,
                dataParameter: "Getaran N",
                nilaiData: nilaiEhn != null && double.tryParse(nilaiEhn) != null
                    ? "$nilaiEhn Hz"
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
              style: TextStyle(fontSize: 28),
            ),
          ),
        ],
      ),
    );
  }
}
