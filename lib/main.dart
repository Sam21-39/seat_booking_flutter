import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seat_booking_flutter/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      themeMode: ThemeMode.system,
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var isDelayed = false.obs;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        milliseconds: 700,
      ),
    ).then((value) {
      isDelayed.value = true;
    });
    Future.delayed(const Duration(milliseconds: 2500)).then(
      (value) => Get.offAll(() => Home(), predicate: (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Obx(
        () => FlutterLogo(
          style: isDelayed.value
              ? FlutterLogoStyle.horizontal
              : FlutterLogoStyle.markOnly,
          size: size.height * 0.2,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 1200),
          textColor: Colors.teal,
        ),
      ),
    );
  }
}
