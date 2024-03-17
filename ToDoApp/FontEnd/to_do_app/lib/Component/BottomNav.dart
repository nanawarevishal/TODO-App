

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Controller/NavBarController.dart';
import 'package:to_do_app/Pages/AddTask.dart';
import 'package:to_do_app/Pages/HomePage.dart';
import 'package:to_do_app/Pages/Task.dart';
import 'package:to_do_app/Pages/dayTask.dart';

class NavigationBars{

  static double height = 30;
  static Color colorSelect =const Color(0XFF0686F8);
  static Color color = const Color(0XFF7AC0FF);
  static Color color2 = const Color(0XFF96B1FD);
  static Color bgColor = const Color.fromARGB(163, 106, 143, 255);

  
  static List<TabItem> items = [
  const TabItem(
    icon:Icons.home,
    title: 'Home',
  ),
  const TabItem(
    icon: Icons.date_range_sharp,
    title: 'Date',
   
  ),
  const TabItem(
    icon: Icons.add,
    title: 'Add Task',
  ),
  const TabItem(
    icon: Icons.task,
    title: 'Task',
  ),
  const TabItem(
    icon: Icons.person_2_sharp,
    title: 'profile',
  ),
];


   static List<Widget>widgetList = [const HomePage(),const DayTask(),const CreateTask(),const Task(),const HomePage()];

    static NavBarController controller = Get.put(NavBarController());

    static Widget addNavBar(){
        return Obx(() =>  SizedBox(
        child: BottomBarInspiredOutside(
              items: items,
              backgroundColor: bgColor,
              color: const Color(0XFF0686F8),
              colorSelected: Colors.white,
              indexSelected: controller.visit.value,
              onTap: (int index) => controller.visit.value = index,
              top: -28,
              animated: true,
              itemStyle: ItemStyle.circle,
              chipStyle:const ChipStyle(notchSmoothness: NotchSmoothness.sharpEdge),
            ),
      )
        );
    }
}