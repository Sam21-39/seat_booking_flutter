import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Design extends StatefulWidget {
  const Design({
    Key? key,
  }) : super(key: key);

  @override
  State<Design> createState() => _DesignState();
}

class _DesignState extends State<Design> {
  static var rowCount = 2.obs;
  late RxList seatIndex = [].obs;
  static var userSize = 1.0.obs;
  static var roomNos = 2.obs;

  final designKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (roomNos.value > 2) {
        getRowCountDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => getRowCountDialog(),
            icon: const Icon(Icons.table_rows_rounded),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: size.height * 0.14,
        color: Colors.teal.shade100,
        child: botomNavItems(),
      ),
      body: RepaintBoundary(
        key: designKey,
        child: Container(
          width: size.width,
          height: size.height,
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowCount.value,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (!seatIndex.contains(index)) {
                            seatIndex.add(
                              index,
                            );
                          } else {
                            seatIndex.removeWhere(
                              (element) => element == index,
                            );
                          }

                          // seatIndex.refresh();
                          // print(seatIndex.contains(index));
                        },
                        child: Obx(
                          () => Transform.scale(
                            scale: userSize.value,
                            child: Container(
                              color: Colors.amber,
                              child: seatIndex.contains(index)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        Text('${index + 1}'),
                                      ],
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: roomNos.value,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final List<Widget> rowList = [
    for (var i = 2; i < 5; i++)
      GestureDetector(
        onTap: () {
          rowCount.value = i;
          roomNos.value = 2;
          Get.close(1);
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: rowCount.value == i
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
                color: rowCount.value == i ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
  ];

  getRowCountDialog() => Get.dialog(
        AlertDialog(
          backgroundColor: Colors.teal.shade900,
          title: const Text("Attention"),
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          content: const Text(
            'Choose number of row count',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: rowList,
        ),
      );

  botomNavItems() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Scale'),
              Obx(
                () => CupertinoSlider(
                  max: 1.0,
                  min: 0.4,
                  value: userSize.value,
                  onChanged: (val) {
                    userSize.value = val;
                  },
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  switch (rowCount.value) {
                    case 2:
                      roomNos.value < 4 ? roomNos.value++ : null;
                      break;
                    case 3:
                      roomNos.value < 9 ? roomNos.value++ : null;
                      break;
                    case 4:
                      roomNos.value < 16 ? roomNos.value++ : null;
                      break;
                  }
                },
                child: Column(
                  children: const [
                    Icon(
                      CupertinoIcons.add,
                    ),
                    Text('Add Rooms'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => roomNos.value > 2 ? roomNos.value-- : null,
                child: Column(
                  children: const [
                    Icon(
                      CupertinoIcons.delete,
                    ),
                    Text('Delete Rooms'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  RenderRepaintBoundary boundary = designKey.currentContext
                      ?.findRenderObject() as RenderRepaintBoundary;

                  final image = await boundary.toImage();
                  var byteData =
                      await image.toByteData(format: ImageByteFormat.png);
                  var pngBytes = byteData?.buffer.asUint8List();

                  final val = await getApplicationDocumentsDirectory().then(
                    (value) => File('${value.path}/room_layout.png')
                        .writeAsBytes(pngBytes as Uint8List)
                        .then(
                          (value) => print(value.path),
                          // (value) => Get.snackbar(
                          //   'Image Saved',
                          //   value.path,
                          //   duration: const Duration(
                          //     milliseconds: 1800,
                          //   ),
                        ),
                  );
                },
                child: Column(
                  children: const [
                    Icon(
                      CupertinoIcons.download_circle,
                    ),
                    Text('Save Layout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}
