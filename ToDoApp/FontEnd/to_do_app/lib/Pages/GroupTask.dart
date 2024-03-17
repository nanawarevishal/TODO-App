import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:to_do_app/Component/BottomNavigationBar.dart';
import 'package:to_do_app/Controller/ColorChangeController.dart';
import 'package:to_do_app/Model/SingleGroupModel.dart';
import 'package:to_do_app/Pages/Task.dart';
import 'package:to_do_app/Services/GroupTaskPageSerivice.dart';
import 'package:to_do_app/Utils/ColorsList.dart';
import 'package:to_do_app/main.dart';

class GroupTask extends StatefulWidget {
  const GroupTask({super.key});

  @override
  State createState() => _GroupTaskState();
}

class _GroupTaskState extends State {
  final ColorChangeController _colorController =
  Get.put(ColorChangeController());
  bool flag = false;

  List<SingleGroupModel> groupTasks =[];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: !flag ? Future.wait([GroupTaskPageService.getAllTaskGroup()]):null,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return _loadedView(snapshot);
          } else {
            return _shimmerView();
          }
        }
    );
  }

  Widget _loadedView(AsyncSnapshot<List<dynamic>> snapshot) {
    if(!flag){
        groupTasks = snapshot.data![0];
    }else{
      if(groupTasks.isEmpty){
        return Scaffold(
          body: Center(child: Text("No Task available")),
        );
      }
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _colorController.selectedButton.value = 1;
                    Get.to(() => BottomNavBarState());
                  },
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 40,
                  )),
              const Spacer(),
              Text(
                groupTasks[0].taskGroup.type,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notification_add_sharp,
                    size: 35,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    GestureDetector(
                      onTap: () async {
                        flag = false;
                        if(!flag){
                          groupTasks =  await GroupTaskPageService.getAllTaskGroup();
                        }
                        _colorController.selectedButton.value = 1;
                            // flag = false;
                        setState(() {});
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.all(7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _colorController.changeBackGroundColor(1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "All",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _colorController.changeForeGroudColor(1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        groupTasks = await GroupTaskPageService.getAllTaskByGroupIdStatus("TODO");
                        _colorController.selectedButton.value = 2;
                        flag = true;
                        setState(() {
                          
                        });
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.all(7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _colorController.changeBackGroundColor(2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "To do",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _colorController.changeForeGroudColor(2)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        groupTasks = await GroupTaskPageService.getAllTaskByGroupIdStatus("IN_PROGRESS");
                        _colorController.selectedButton.value = 3;
                        flag = true;
                        setState(() {});
                      },
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _colorController.changeBackGroundColor(3),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "In Progress",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _colorController.changeForeGroudColor(3)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        groupTasks = await GroupTaskPageService.getAllTaskByGroupIdStatus("DONE");
                        _colorController.selectedButton.value = 4;
                        flag = true;
                        setState(() {});
                      },
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _colorController.changeBackGroundColor(4),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _colorController.changeForeGroudColor(4)),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: groupTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      MainApp.storage.remove("taskId");
                      MainApp.storage.write("taskId", groupTasks[index].id);
                      Get.to(() => const Task());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      margin: const EdgeInsets.only(
                          bottom: 16, left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(groupTasks[index].title),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  groupTasks[index].objective,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.watch_later_sharp,
                                      color: Color.fromARGB(83, 26, 52, 252),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      _parseTimeString(groupTasks[index].time),
                                      //   groupTasks[index].time,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(127, 26, 52, 252)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Utils.imageBackGroundColor[index %
                                        Utils.imageBackGroundColor.length]),
                                child: Image.asset(
                                  Utils.imageUrl[index % Utils.imageUrl.length],
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Utils.taskGroupPrecentColors[index %
                                                Utils.taskGroupPrecentColors
                                                    .length][0],
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  groupTasks[index].status,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color:  Utils.taskGroupPrecentColors[index %
                                                Utils.taskGroupPrecentColors
                                                    .length][1],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _shimmerView() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 206, 206, 206),
        highlightColor: Colors.grey.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                    )),
                const Spacer(),
                const Text(
                  " Group Name",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notification_add_sharp,
                      size: 35,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 17,
                  ),
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _colorController.changeBackGroundColor(1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "All",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _colorController.changeForeGroudColor(1)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _colorController.changeBackGroundColor(2),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "To do",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _colorController.changeForeGroudColor(2)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _colorController.changeBackGroundColor(3),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "In Progress",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _colorController.changeForeGroudColor(3)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _colorController.changeBackGroundColor(4),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Completed",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _colorController.changeForeGroudColor(4)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(13),
                      margin: const EdgeInsets.only(
                          bottom: 16, left: 15, right: 15),
                      decoration: BoxDecoration(
                        //   color: Colors.white,
                        border: Border.all(
                            color: Colors.black
                        ),
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 115, 191, 252),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child:const Text("groupTasks[index].title")
                                    ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                     decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 115, 191, 252),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  child: const Text(
                                    " groupTasks[index].objective",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.watch_later_sharp,
                                      color: Color.fromARGB(83, 26, 52, 252),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "     ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(127, 26, 52, 252)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Utils.imageBackGroundColor[index %
                                        Utils.imageBackGroundColor.length]),
                                child: Image.asset(
                                  Utils.imageUrl[index % Utils.imageUrl.length],
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Utils.statusColor[
                                        index % Utils.statusColor.length][0],
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  "          ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Utils.statusColor[
                                        index % Utils.statusColor.length][1],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  String _parseTimeString(String timeString) {
    String formattedTime = formatTime(timeString);
    return formattedTime;
  }

  String formatTime(String timeString) {
    DateTime dateTime = DateFormat('HH:mm:ss.SSS').parse(timeString);
    DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }
}
