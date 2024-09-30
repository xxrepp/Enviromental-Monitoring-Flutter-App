import 'package:flutter/material.dart';
import 'package:skripsi/widgets/getaran_detail.dart';
import 'package:skripsi/widgets/suhu_detail.dart';
import 'package:skripsi/widgets/angin_detail.dart';
import 'package:skripsi/widgets/kelembaban_detail.dart';
import 'package:skripsi/widgets/tegangan_detail.dart';
import 'package:skripsi/pages/menu.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          DetailSuhu(),
          DetailGetaran(),
          DetailKelembaban(),
          DetailAngin(),
          DetailTegangan(),
        ],
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
