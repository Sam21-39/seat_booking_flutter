import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seat_booking_flutter/design.dart';

class Home extends StatelessWidget {
  static var selectedIndex = 2.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seat Booking',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Create Design',
                style: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              GestureDetector(
                onTap: () => Get.dialog(
                  AlertDialog(
                    backgroundColor: Colors.teal.shade900,
                    title: const Text("Attention"),
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    content: const Text(
                      'Choose number of rooms',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    actions: roomList,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.add_circled,
                  size: size.width * 0.14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Widget> roomList = [
    for (var i = 2; i < 7; i++)
      GestureDetector(
        onTap: () {
          selectedIndex.value = i;
          Get.off(
            () => Design(
              roomNo: selectedIndex.value,
            ),
          );
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: selectedIndex.value == i
                  ? Colors.tealAccent
                  : Colors.tealAccent.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 8.0,
            ),
            child: Text(
              i.toString(),
              style: TextStyle(
                color: selectedIndex.value == i ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
  ];
}
