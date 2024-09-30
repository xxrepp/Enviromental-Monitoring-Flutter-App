import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/pages/dashboard_itera.dart';
import 'package:skripsi/pages/dashboard_unila.dart';
import 'package:skripsi/pages/detail.dart';
import 'package:skripsi/pages/event.dart';
import 'package:skripsi/controllers/event.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final EventController eventController = Get.put(EventController());
  late int index = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[300]!,
              Colors.blue[50]!,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: bodyHeight * 0.05,
              ),
              GestureDetector(
                onTap: () => Get.to(() => DashboardUnila()),
                child: Container(
                  width: bodyWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: bodyHeight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/unila.png"),
                        width: 75,
                        height: 75,
                      ),
                      Text(
                        "Rektorat Unila",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.1,
              ),
              GestureDetector(
                onTap: () => Get.to(() => DashboardItera()),
                child: Container(
                  width: bodyWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: bodyHeight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/itera.png"),
                        width: 75,
                        height: 75,
                      ),
                      Text(
                        "Gedung Itera",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => EventPage()); // Navigasi ke halaman EventPage()
                  Get.find<EventController>()
                      .getAllEvent(); // Panggil fungsi getAllEvent()
                },
                child: Container(
                  width: bodyWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: bodyHeight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/itera.png"),
                        width: 75,
                        height: 75,
                      ),
                      Text(
                        "Event",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
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
            Get.offAll(() => Menu());
          } else if (index == 1) {
            // Pindah ke halaman Detail jika index 1 ditekan
            Get.offAll(() => DetailPage());
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
