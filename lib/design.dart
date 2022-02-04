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
  late RxList seatIndex = [].obs;
  static var userSize = 150.0.obs;
  static var roomNos = 2.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.roomNo > 2) {
        getRowCountDialog();
      }
      roomNos.value = widget.roomNo;
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
      bottomNavigationBar: Container(
        width: size.width,
        height: size.height * 0.1,
        color: Colors.teal.shade100,
        child: botomNavItems(),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowCount.value,
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
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: userSize.value,
                              height: userSize.value,
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
                          ],
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

  botomNavItems() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => roomNos.value++,
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
          Column(
            children: const [
              Icon(
                CupertinoIcons.pen,
              ),
              Text('Add Seat Name'),
            ],
          ),
        ],
      );
}
