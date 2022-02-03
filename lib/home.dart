import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seat_booking_flutter/design.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
              IconButton(
                onPressed: () => Get.to(
                  () => Design(),
                  transition: Transition.fadeIn,
                ),
                icon: Icon(
                  Icons.add_circle_outline_rounded,
                  size: size.width * 0.14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
