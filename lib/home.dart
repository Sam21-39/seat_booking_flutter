import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: const [],
      ),
    );
  }
}
