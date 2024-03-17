import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:to_do_app/Model/StatusModel.dart';
import 'package:to_do_app/Pages/GroupTask.dart';
import 'package:to_do_app/Pages/Task.dart';
import 'package:to_do_app/Pages/dayTask.dart';
import 'package:to_do_app/Services/HomePageServices.dart';
import 'package:to_do_app/Utils/ColorsList.dart';
import 'package:to_do_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          HomepageService.getDataByStatus(),
          HomepageService.getDataByGroups()
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return _loadedView(snapshot);
          } else {
            return _shimmerView();
          }
        });
  }

  Widget _loadedView(AsyncSnapshot<List<dynamic>> snapshot) {
    List<StatusModel> statusModel = snapshot.data![0];
    List<List<StatusModel>> groupModel = snapshot.data![1];
    print("StatusModel:$statusModel");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              child: Row(
                children: [
                  Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: const Color.fromARGB(255, 192, 191, 191),
                          ),
                          shape: BoxShape.circle),
                      child: Image.asset(
                        "assets/images/user (2).png",
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitHeight,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello!",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Livia Vacarro",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_sharp,
                        size: 35,
                      )
                    )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 90, 55, 247),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your today's task is almost done!",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const DayTask());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 233, 232, 249),
                                borderRadius: BorderRadius.circular(14)),
                            child: const Text(
                              "View Task",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 28, 5, 237)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 40,
                    percent: .75,
                    progressColor: Colors.white,
                    lineWidth: 7,
                    center: const Text(
                      "85%",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "In Progress",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.left,
                          ),
                          Image.asset(
                            "assets/images/flare.jpeg",
                            height: 30,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: statusModel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  MainApp.storage.remove("taskId");
                                  MainApp.storage
                                      .write("taskId", statusModel[index].id);
                                  Get.to(() => const Task());
                                },
                                child: Container(
                                  width: 230,
                                  padding: const EdgeInsets.all(14),
                                  margin:
                                      const EdgeInsets.only(right: 16, top: 10),
                                  decoration: BoxDecoration(
                                      color: Utils.colorList[
                                          index % Utils.colorList.length],
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            statusModel[index].taskGroup.type,
                                            //   "Office Project",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: Utils
                                                        .imageBackGroundColor[
                                                    (index + 1) %
                                                        Utils
                                                            .imageBackGroundColor
                                                            .length]),
                                            child: Image.asset(
                                              Utils.imageUrl[(index + 1) %
                                                  Utils.imageUrl.length],
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        statusModel[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      LinearPercentIndicator(
                                        lineHeight: 7,
                                        barRadius: const Radius.circular(6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        percent: statusModel[index].percentageCompletion/100,
                                        progressColor:
                                            Utils.percentIndicatorList[index %
                                                Utils.percentIndicatorList
                                                    .length],
                                        backgroundColor: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Task Groups",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(146, 123, 132, 255)),
                            child: const Text("4"),
                          )
                        ],
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.all(6),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: groupModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                MainApp.storage.remove("grouId");
                                MainApp.storage.write("groupId",
                                    groupModel[index][0].taskGroup.id);
                                Get.to(() => const GroupTask());
                              },
                              child: Container(
                                height: 90,
                                padding: const EdgeInsets.all(18),
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 227, 227, 227)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Utils.imageBackGroundColor[
                                              index %
                                                  Utils.imageBackGroundColor
                                                      .length]),
                                      child: Image.asset(
                                        Utils.imageUrl[
                                            index % Utils.imageUrl.length],
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          groupModel[index][0].taskGroup.type,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                            "${groupModel[index].length.toString()} Tasks")
                                      ],
                                    ),
                                    const Spacer(),
                                    CircularPercentIndicator(
                                        percent: groupModel[index][0].taskGroup.percentageCompletion/100,
                                        backgroundColor:
                                            Utils.taskGroupPrecentColors[index %
                                                Utils.taskGroupPrecentColors
                                                    .length][0],
                                        progressColor:
                                            Utils.taskGroupPrecentColors[index %
                                                Utils.taskGroupPrecentColors
                                                    .length][1],
                                        center: Text(groupModel[index][0].taskGroup.percentageCompletion.toString()),
                                        radius: 25),
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                    ]
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _shimmerView() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      body: SingleChildScrollView(
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 206, 206, 206),
          highlightColor: Colors.grey.shade300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                child: Row(
                  children: [
                    Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(
                              color: const Color.fromARGB(255, 192, 191, 191),
                            ),
                            shape: BoxShape.circle),
                        child: Image.asset(
                          "assets/images/user (2).png",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fitHeight,
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Livia Vacarro",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        )
                      ],
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
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 90, 55, 247),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your today's task is almost done!",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: 150,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 233, 232, 249),
                                  borderRadius: BorderRadius.circular(14)),
                              child: const Text(
                                "View Task",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 28, 5, 237)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: 40,
                      percent: .75,
                      progressColor: Colors.white,
                      lineWidth: 7,
                      center: const Text(
                        "85%",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "In Progress",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: Text(" "),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 230,
                                  padding: const EdgeInsets.all(14),
                                  margin:
                                      const EdgeInsets.only(right: 16, top: 10),
                                  decoration: BoxDecoration(
                                      color: Utils.colorList[
                                          index % Utils.colorList.length],
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: Utils
                                                        .imageBackGroundColor[
                                                    (index + 1) %
                                                        Utils
                                                            .imageBackGroundColor
                                                            .length]),
                                            child: Image.asset(
                                              Utils.imageUrl[(index + 1) %
                                                  Utils.imageUrl.length],
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "                       ",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      LinearPercentIndicator(
                                        lineHeight: 7,
                                        barRadius: const Radius.circular(6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        percent: .6,
                                        progressColor:
                                            Utils.percentIndicatorList[index %
                                                Utils.percentIndicatorList
                                                    .length],
                                        backgroundColor: Colors.white,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Task Groups",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(146, 123, 132, 255)),
                              child: const Text(" "),
                            )
                          ],
                        ),
                        ListView.builder(
                            padding: const EdgeInsets.all(6),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // MainApp.storage.remove("grouId");
                                  // MainApp.storage.write("groupId",
                                  // groupModel[index][0].taskGroup.id);
                                  // Get.to(() => const GroupTask());
                                },
                                child: Container(
                                  height: 90,
                                  padding: const EdgeInsets.all(18),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 227, 227, 227)),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Utils.imageBackGroundColor[
                                                index %
                                                    Utils.imageBackGroundColor
                                                        .length]),
                                        child: Image.asset(
                                          Utils.imageUrl[
                                              index % Utils.imageUrl.length],
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Spacer(),
                                      CircularPercentIndicator(
                                          percent: .7,
                                          backgroundColor: Utils
                                                  .taskGroupPrecentColors[
                                              index %
                                                  Utils.taskGroupPrecentColors
                                                      .length][0],
                                          progressColor: Utils
                                                  .taskGroupPrecentColors[
                                              index %
                                                  Utils.taskGroupPrecentColors
                                                      .length][1],
                                          center: const Text("70%"),
                                          radius: 25),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
