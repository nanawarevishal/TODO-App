import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/Component/BottomNavigationBar.dart';
import 'package:to_do_app/Pages/FlashScreen.dart';
import 'package:to_do_app/Pages/GroupTask.dart';
import 'package:to_do_app/Pages/HomePage.dart';
import 'package:to_do_app/Pages/Task.dart';
import 'package:to_do_app/Pages/dayTask.dart';


void main()async {
    await GetStorage.init();
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
                        
    static GetStorage storage = GetStorage();
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
        return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: BottomNavBarState()
            ),
        );
    }
}
