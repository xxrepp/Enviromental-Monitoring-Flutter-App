import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/general_controller.dart';
import 'package:skripsi/pages/menu.dart';
import 'package:skripsi/pages/detail.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:skripsi/controllers/event.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final EventController eventController = Get.put(EventController());
  late var waktuEvent;
  late var jenisEvent;
  late var nilaiEvent;
  late int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    final waktuEvent = eventController.waktuEvent;
    final jenisEvent = eventController.jenisEvent;
    final nilaiEvent = eventController.nilaiEvent;

    print("waktu");
    print(waktuEvent);
    print("jenis");
    print(jenisEvent);
    print("nilai");
    print(nilaiEvent);
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
                      "Riwayat Event",
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
                  height: bodyHeight * 0.025,
                ),
                Container(
                  height: bodyHeight * 0.025,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Riwayat event satu bulan terakhir",
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
                  child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: [
                      DataColumn2(
                        label: Text('Waktu Event'),
                      ),
                      DataColumn(
                        label: Text('Jenis Event'),
                      ),
                      DataColumn(
                        label: Text('Nilai Event'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      waktuEvent.length,
                      (index) => DataRow(cells: [
                        DataCell(Text(_formatDateTime(
                            waktuEvent[index]))), // Menggunakan fungsi format
                        DataCell(Text(jenisEvent[index])),
                        DataCell(Text(nilaiEvent[index].toString())),
                      ]),
                    ),
                  ),
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

String _formatDateTime(String isoDateTime) {
  DateTime parsedDateTime = DateTime.parse(isoDateTime);
  String formattedDateTime =
      DateFormat('dd-MM-yyyy HH:mm:ss').format(parsedDateTime);
  return formattedDateTime;
}
