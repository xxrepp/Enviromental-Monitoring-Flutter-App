import 'package:flutter/material.dart';
import 'package:skripsi/api/getaranhistory.dart';
import 'package:skripsi/controllers/itera_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:skripsi/models/getaranhistory.dart';
import 'package:get/get.dart';
import 'package:skripsi/controllers/general_controller.dart';

// ignore: must_be_immutable
class DetailGetaran extends StatelessWidget {
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final IteraController parameterController = Get.put(IteraController());

  DetailGetaran({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Obx(() {
      final nilaiEhz = parameterController.ehz.value;

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
                            "Itera",
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
                            nilaiEhz != null ? "$nilaiEhz Hz" : "...",
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
                      "Getaran",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    height: bodyHeight * 0.05,
                    child: Text(
                      "Menampilkan grafik perubahan getaran dari rentang waktu yang ditentukan",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              GetaranChart(bodyHeight: bodyHeight)
            ],
          ),
        ),
      );
    });
  }
}

class GetaranChart extends StatefulWidget {
  GetaranChart({
    super.key,
    required this.bodyHeight,
  });

  final double bodyHeight;

  @override
  State<GetaranChart> createState() => _GetaranChartState();
}

class _GetaranChartState extends State<GetaranChart> {
  List<DataGetaran> history = [];
  List items = ['1 Jam', '3 Jam', '6 Jam'];
  late String selectedOption;

  void getChartHistory() async {
    if (selectedOption == '1 Jam') {
      GetaranHistory getaranHistory = await getGetaran1Hour();
      List<DataGetaran> newData = getaranHistory.data
          .map((datum) => DataGetaran(
                waktu: datum.waktu,
                nilaiEhe: datum.nilaiEhe,
                nilaiEhn: datum.nilaiEhn,
                nilaiEhz: datum.nilaiEhz,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '3 Jam') {
      GetaranHistory getaranHistory = await getGetaran3Hour();
      List<DataGetaran> newData = getaranHistory.data
          .map((datum) => DataGetaran(
                waktu: datum.waktu,
                nilaiEhe: datum.nilaiEhe,
                nilaiEhn: datum.nilaiEhn,
                nilaiEhz: datum.nilaiEhz,
              ))
          .toList();
      setState(() {
        history = newData;
      });
      print(selectedOption);
    } else if (selectedOption == '6 Jam') {
      GetaranHistory getaranHistory = await getGetaran6Hour();
      List<DataGetaran> newData = getaranHistory.data
          .map((datum) => DataGetaran(
                waktu: datum.waktu,
                nilaiEhe: datum.nilaiEhe,
                nilaiEhn: datum.nilaiEhn,
                nilaiEhz: datum.nilaiEhz,
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
            title: ChartTitle(text: "Getaran"),
            primaryXAxis: DateTimeCategoryAxis(),
            legend: Legend(isVisible: true),
            series: <LineSeries<DataGetaran, dynamic>>[
              LineSeries<DataGetaran, dynamic>(
                  dataSource: history.reversed.toList(),
                  xValueMapper: (DataGetaran ambil, _) => ambil.waktu,
                  yValueMapper: (DataGetaran ambil, _) => ambil.nilaiEhz,
                  name: "Nilai EHZ"),
              LineSeries<DataGetaran, dynamic>(
                  dataSource: history.reversed.toList(),
                  xValueMapper: (DataGetaran ambil, _) => ambil.waktu,
                  yValueMapper: (DataGetaran ambil, _) => ambil.nilaiEhe,
                  name: "Nilai EHN"),
              LineSeries<DataGetaran, dynamic>(
                  dataSource: history.reversed.toList(),
                  xValueMapper: (DataGetaran ambil, _) => ambil.waktu,
                  yValueMapper: (DataGetaran ambil, _) => ambil.nilaiEhn,
                  name: "Nilai EHE")
            ],
          )),
        ),
        Container(
          // color: Colors.yellow,
          height: widget.bodyHeight * 0.05,
          child: Row(
            children: [
              DropdownButton(
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
              DropdownButton(
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
            ],
          ),
        ),
      ],
    );
  }
}
