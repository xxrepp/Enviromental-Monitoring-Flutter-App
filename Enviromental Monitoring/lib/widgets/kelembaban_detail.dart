import 'package:flutter/material.dart';
import 'package:skripsi/api/kelembabanhistory.dart';
import 'package:skripsi/controllers/unila_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:skripsi/models/kelembabanhistory.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/general_controller.dart';

// ignore: must_be_immutable
class DetailKelembaban extends StatelessWidget {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final UnilaController parameterController = Get.put(UnilaController());

  DetailKelembaban({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Obx(() {
      final nilaiKelembaban = parameterController.kelembaban.value;
      final kelembabanValid =
          double.tryParse(nilaiKelembaban)?.toStringAsFixed(1) ?? "...";

      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        // color: Colors.red,
                        height: bodyHeight * 0.05,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rektorat Unila",
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.brown,
                        height: bodyHeight * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            kelembabanValid != null
                                ? "$kelembabanValid RH"
                                : "...",
                            style: TextStyle(
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: bodyHeight * 0.05,
                        // color: Colors.green,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Obx(
                              () => Text(
                                dateTimeController.date.value,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: bodyHeight * 0.05,
                    // color: Colors.blueGrey,
                    child: Text(
                      "Kelembaban",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    height: bodyHeight * 0.05,
                    child: Text(
                      "Menampilkan grafik perubahan kelembaban dari rentang waktu yang ditentukan",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              KelembabanChart(bodyHeight: bodyHeight)
            ],
          ),
        ),
      );
    });
  }
}

class KelembabanChart extends StatefulWidget {
  KelembabanChart({
    super.key,
    required this.bodyHeight,
  });

  final double bodyHeight;

  @override
  State<KelembabanChart> createState() => _KelembabanChartState();
}

class _KelembabanChartState extends State<KelembabanChart> {
  List<DataKelembaban> history = [];
  List items = ['1 Jam', '3 Jam', '6 Jam'];
  late String selectedOption;

  void getChartHistory() async {
    if (selectedOption == '1 Jam') {
      KelembabanHistory kelembabanHistory = await getKelembaban1Hour();
      List<DataKelembaban> newData = kelembabanHistory.data
          .map((datum) => DataKelembaban(
                tanggal: datum.tanggal,
                kelembapan: datum.kelembapan,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '3 Jam') {
      KelembabanHistory kelembabanHistory = await getKelembaban3Hour();
      List<DataKelembaban> newData = kelembabanHistory.data
          .map((datum) => DataKelembaban(
                tanggal: datum.tanggal,
                kelembapan: datum.kelembapan,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '6 Jam') {
      KelembabanHistory kelembabanHistory = await getKelembaban6Hour();
      List<DataKelembaban> newData = kelembabanHistory.data
          .map((datum) => DataKelembaban(
                tanggal: datum.tanggal,
                kelembapan: datum.kelembapan,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedOption = items[0];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.bodyHeight * 0.5,
          child: Container(
              child: SfCartesianChart(
            title: ChartTitle(text: "Kelembaban"),
            primaryXAxis: DateTimeCategoryAxis(),
            series: <LineSeries<DataKelembaban, dynamic>>[
              LineSeries<DataKelembaban, dynamic>(
                dataSource: history.reversed.toList(),
                xValueMapper: (DataKelembaban ambil, _) => ambil.tanggal,
                yValueMapper: (DataKelembaban ambil, _) => ambil.kelembapan,
              )
            ],
          )),
        ),
        Container(
          // color: Colors.yellow,
          height: widget.bodyHeight * 0.05,
          child: DropdownButton(
            value: selectedOption,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.toString()),
                    value: e.toString(),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
                getChartHistory();
              });
            },
          ),
        ),
      ],
    );
  }
}
