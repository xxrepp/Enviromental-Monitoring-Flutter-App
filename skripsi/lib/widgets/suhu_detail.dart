import 'package:flutter/material.dart';
import 'package:skripsi/api/suhuhistory.dart';
import 'package:skripsi/controllers/unila_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:skripsi/models/suhuhistory.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/general_controller.dart';

// ignore: must_be_immutable
class DetailSuhu extends StatelessWidget {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final UnilaController parameterController = Get.put(UnilaController());

  DetailSuhu({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Obx(() {
      final nilaiSuhu = parameterController.suhu.value;
      final suhuValid = double.tryParse(nilaiSuhu)?.toStringAsFixed(1) ?? "...";
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
                            suhuValid != null ? "$suhuValid °C" : "...",
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
                      "Suhu",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    height: bodyHeight * 0.05,
                    child: Text(
                      "Menampilkan grafik perubahan suhu dari rentang waktu yang ditentukan",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SuhuChart(bodyHeight: bodyHeight),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SuhuChart extends StatefulWidget {
  SuhuChart({
    super.key,
    required this.bodyHeight,
  });

  final double bodyHeight;

  @override
  State<SuhuChart> createState() => _SuhuChartState();
}

class _SuhuChartState extends State<SuhuChart> {
  List<DataSuhu> history = [];
  List items = ['1 Jam', '3 Jam', '6 Jam'];
  late String selectedOption;

  void getChartHistory() async {
    if (selectedOption == '1 Jam') {
      SuhuHistory suhuHistory = await getSuhu1Hour();
      List<DataSuhu> newData = suhuHistory.data
          .map((datum) => DataSuhu(
                tanggal: datum.tanggal,
                suhu: datum.suhu,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '3 Jam') {
      SuhuHistory suhuHistory = await getSuhu3Hour();
      List<DataSuhu> newData = suhuHistory.data
          .map((datum) => DataSuhu(
                tanggal: datum.tanggal,
                suhu: datum.suhu,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '6 Jam') {
      SuhuHistory suhuHistory = await getSuhu6Hour();
      List<DataSuhu> newData = suhuHistory.data
          .map((datum) => DataSuhu(
                tanggal: datum.tanggal,
                suhu: datum.suhu,
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
            title: ChartTitle(text: "Suhu"),
            primaryXAxis: DateTimeCategoryAxis(),
            series: <LineSeries<DataSuhu, dynamic>>[
              LineSeries<DataSuhu, dynamic>(
                dataSource: history.reversed.toList(),
                xValueMapper: (DataSuhu ambil, _) => ambil.tanggal,
                yValueMapper: (DataSuhu ambil, _) => ambil.suhu,
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
