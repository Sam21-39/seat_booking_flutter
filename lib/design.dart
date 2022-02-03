import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Design extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_box_outlined,
                size: size.width * 0.14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
