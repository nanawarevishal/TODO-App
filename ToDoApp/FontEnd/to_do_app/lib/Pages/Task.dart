
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:to_do_app/Model/SingleTaskModel.dart';
import 'package:to_do_app/Pages/HomePage.dart';
import 'package:to_do_app/Services/SingleTaskService.dart';

class Task extends StatefulWidget {
  const Task({super.key});
	
  @override
  State createState() => _TaskState();
}

class _TaskState extends State {

  bool flag = false;
  List<SingleTaskModel?> task = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: !flag? Future.wait([TaskServices.getSingleTaskData()]): null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return _loadedView(snapshot);
          } else {
            return _shimmerView();
          }
        }
    );
  }

  Widget _loadedView(AsyncSnapshot<dynamic> snapshot) {
    if(!flag){
      task = snapshot.data;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const HomePage());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(83, 26, 52, 252),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(83, 26, 52, 252),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.event_available_outlined),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(83, 26, 52, 252),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset("assets/images/dotsIcons.png")),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                task[0]!.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Objective",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                task[0]!.description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(83, 26, 52, 252)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.alarm_rounded),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("Deadline : "),
                            Text(
                              formatDateString(task[0]!.endDate),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Team",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Stack(
                          children: [
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 192, 191, 191),
                                    ),
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  "assets/images/user (2).png",
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fitHeight,
                                )),
                            Positioned(
                              left: 22,
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    "assets/images/user2.png",
                                    width: 60,
                                    height: 60,
                                  )),
                            ),
                            Positioned(
                              left: 42,
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    "assets/images/user1.png",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fitHeight,
                                  )),
                            ),
                            Positioned(
                              left: 62,
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(83, 26, 52, 252),
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.add)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      )
                    ],
                  ),
                  const Spacer(),
                  CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 8,
                    percent: task[0]!.percentageCompletion/100,
                    backgroundColor: const Color.fromARGB(83, 26, 52, 252),
                    progressColor: const Color.fromARGB(255, 123, 90, 255),
                    center: Text(task[0]!.percentageCompletion.toString()),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Today's Task",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: task[0]!.subTask.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/user1.png",
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 225,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task[0]!.subTask[index].tasks,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text("Asignee Jack Robert")
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: ()async{
                              SingleTaskModel? tsk = await TaskServices.updateSubTask(task[0]!.id, task[0]!.subTask[index].id);
                              await TaskServices.updateSingleTaskGroupPercentage(task[0]!.taskGroup.id);
                              task.clear();
                              task.add(tsk);
                              flag = true;
                              setState(() {
                                  
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: task[0]!.subTask[index].completed ? Colors.green : Colors.transparent,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _shimmerView() {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 206, 206, 206),
        highlightColor: Colors.grey.shade300,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const HomePage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(83, 26, 52, 252),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(83, 26, 52, 252),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.event_available_outlined),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(83, 26, 52, 252),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset("assets/images/dotsIcons.png")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                 "Title",
                  style:
                       TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Objective",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      decoration:const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.amber
                      ),
                      child: const Text(
                       " task!.description                                                        ",
                        style:  TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.only(bottom: 2),
                      decoration:const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.amber
                      ),
                      child: const Text(
                       " task!.description                                                        ",
                        style:  TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      decoration:const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.amber
                      ),
                      child: const Text(
                       " task!.description                                                        ",
                        style:  TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      decoration:const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.amber
                      ),
                      child: const Text(
                       " task!.description                                                        ",
                        style:  TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      decoration:const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.amber
                      ),
                      child: const Text(
                       " task!.description                                                        ",
                        style:  TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(83, 26, 52, 252)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               Icon(Icons.alarm_rounded),
                               SizedBox(
                                width: 5,
                              ),
                               Text("Deadline : "),
                              Text(
                                "          ",
                                style:
                                     TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "Team",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Stack(
                            children: [
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 192, 191, 191),
                                      ),
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    "assets/images/user (2).png",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fitHeight,
                                  )),
                              Positioned(
                                left: 22,
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      "assets/images/user2.png",
                                      width: 60,
                                      height: 60,
                                    )),
                              ),
                              Positioned(
                                left: 42,
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      "assets/images/user1.png",
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fitHeight,
                                    )),
                              ),
                              Positioned(
                                left: 62,
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(83, 26, 52, 252),
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        )
                      ],
                    ),
                    const Spacer(),
                    CircularPercentIndicator(
                      radius: 40,
                      lineWidth: 8,
                      percent: .70,
                      backgroundColor: const Color.fromARGB(83, 26, 52, 252),
                      progressColor: const Color.fromARGB(255, 123, 90, 255),
                      center: const Text(""),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Today's Task",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/user1.png",
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                             SizedBox(
                              width: 225,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: const Text(
                                      "task!.subTask[index].tasks",
                                      style:  TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(height: 3,),
                                   Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: const Text("Asignee Jack Robert"))
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('MMMM dd').format(dateTime);
    return formattedDate;
  }
}
