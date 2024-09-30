import 'package:flutter/material.dart';
import 'package:skripsi/api/teganganhistory.dart';
import 'package:skripsi/controllers/unila_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:skripsi/models/teganganhistory.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/general_controller.dart';

// ignore: must_be_immutable
class DetailTegangan extends StatelessWidget {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final UnilaController parameterController = Get.put(UnilaController());

  DetailTegangan({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Obx(() {
      final nilaiTegangan = parameterController.tegangan.value;
      final teganganValid =
          double.tryParse(nilaiTegangan)?.toStringAsFixed(1) ?? "...";

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
                            "Kedaton",
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
                            teganganValid != null
                                ? "$teganganValid Volt"
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
                      "Tegangan",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    height: bodyHeight * 0.05,
                    child: Text(
                      "Menampilkan grafik perubahan tegangan dari rentang waktu yang ditentukan",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TeganganChart(bodyHeight: bodyHeight),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TeganganChart extends StatefulWidget {
  TeganganChart({
    super.key,
    required this.bodyHeight,
  });

  final double bodyHeight;

  @override
  State<TeganganChart> createState() => _TeganganChartState();
}

class _TeganganChartState extends State<TeganganChart> {
  List<DataTegangan> history = [];
  List items = ['1 Jam', '3 Jam', '6 Jam'];
  late String selectedOption;

  void getChartHistory() async {
    if (selectedOption == '1 Jam') {
      TeganganHistory teganganHistory = await getTegangan1hour();
      List<DataTegangan> newData = teganganHistory.data
          .map((datum) => DataTegangan(
                tanggal: datum.tanggal,
                f1: datum.f1,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '3 Jam') {
      TeganganHistory teganganHistory = await getTegangan3Hour();
      List<DataTegangan> newData = teganganHistory.data
          .map((datum) => DataTegangan(
                tanggal: datum.tanggal,
                f1: datum.f1,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '6 Jam') {
      TeganganHistory teganganHistory = await getTegangan6Hour();
      List<DataTegangan> newData = teganganHistory.data
          .map((datum) => DataTegangan(
                tanggal: datum.tanggal,
                f1: datum.f1,
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
            title: ChartTitle(text: "Tegangan"),
            primaryXAxis: DateTimeCategoryAxis(),
            series: <LineSeries<DataTegangan, dynamic>>[
              LineSeries<DataTegangan, dynamic>(
                dataSource: history.reversed.toList(),
                xValueMapper: (DataTegangan ambil, _) => ambil.tanggal,
                yValueMapper: (DataTegangan ambil, _) => ambil.f1,
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
