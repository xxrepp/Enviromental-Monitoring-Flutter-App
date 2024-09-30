import 'package:flutter/material.dart';
import 'package:skripsi/api/anginhistory.dart';
import 'package:skripsi/controllers/unila_controller.dart';
import 'package:skripsi/models/anginhistory.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/general_controller.dart';

// ignore: must_be_immutable
class DetailAngin extends StatelessWidget {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final UnilaController parameterController = Get.put(UnilaController());

  DetailAngin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Obx(() {
      final nilaiAngin = parameterController.angin.value;
      final anginValid =
          double.tryParse(nilaiAngin)?.toStringAsFixed(1) ?? "...";

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
                            anginValid != null ? "$anginValid m/s" : "...",
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
                      "Kecepatan Angin",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    height: bodyHeight * 0.05,
                    child: Text(
                      "Menampilkan grafik perubahan kecepatan angin dari rentang waktu yang ditentukan",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              AnginChart(bodyHeight: bodyHeight)
            ],
          ),
        ),
      );
    });
  }
}

class AnginChart extends StatefulWidget {
  AnginChart({
    super.key,
    required this.bodyHeight,
  });

  final double bodyHeight;

  @override
  State<AnginChart> createState() => _AnginChartState();
}

class _AnginChartState extends State<AnginChart> {
  List<DataAngin> history = [];
  List items = ['1 Jam', '3 Jam', '6 Jam'];
  late String selectedOption;

  void getChartHistory() async {
    if (selectedOption == '1 Jam') {
      AnginHistory anginHistory = await getAngin1Hour();
      List<DataAngin> newData = anginHistory.data
          .map((datum) => DataAngin(
                tanggal: datum.tanggal,
                v1: datum.v1,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '3 Jam') {
      AnginHistory anginHistory = await getAngin3Hour();
      List<DataAngin> newData = anginHistory.data
          .map((datum) => DataAngin(
                tanggal: datum.tanggal,
                v1: datum.v1,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '6 Jam') {
      AnginHistory anginHistory = await getAngin6Hour();
      List<DataAngin> newData = anginHistory.data
          .map((datum) => DataAngin(
                tanggal: datum.tanggal,
                v1: datum.v1,
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
            title: ChartTitle(text: "Kecepatan Angin"),
            primaryXAxis: DateTimeCategoryAxis(),
            series: <LineSeries<DataAngin, dynamic>>[
              LineSeries<DataAngin, dynamic>(
                dataSource: history.reversed.toList(),
                xValueMapper: (DataAngin ambil, _) => ambil.tanggal,
                yValueMapper: (DataAngin ambil, _) => ambil.v1,
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
