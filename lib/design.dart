import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Design extends StatefulWidget {
  final int roomNo;
  const Design({
    Key? key,
    this.roomNo = 2,
  }) : super(key: key);

  @override
  State<Design> createState() => _DesignState();
}

class _DesignState extends State<Design> {
  static var rowCount = 2.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.roomNo > 2) {
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowCount.value,
                  ),
                  itemBuilder: (_, index) => const FlutterLogo(),
                  itemCount: widget.roomNo,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final List<Widget> rowList = [
    for (var i = 2; i < 5; i++)
      GestureDetector(
        onTap: () {
          rowCount.value = i;
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
}
