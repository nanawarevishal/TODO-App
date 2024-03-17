
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Component/BottomNavigationBar.dart';


class FlashScreen extends StatefulWidget{
    const FlashScreen({super.key});

    @override
    State createState()=>_FlashScreenState();
}

class _FlashScreenState extends State{

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: const Color.fromARGB(255, 243, 243, 243),
            body: Column(
                children: [
                    Image.asset("assets/images/FlashScreen.jpeg",colorBlendMode: BlendMode.luminosity,),

                    const SizedBox(height: 20,),

                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: const Text("Task-Management & To-Do List ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: const Text("This productive tool designed to help you better manage your task project-wise convenietly!",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal
                      ),
                      textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                        onTap: (){
                            Get.to(()=> BottomNavBarState());
                        },
                      child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width/1.25,
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 73, 42, 254)
                          ),
                      
                          child: const Row(
                              children: [
                                  Spacer(),
                                   Text("Let's Start",style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,fontWeight: FontWeight.w600
                                   ),
                                   ),
                      
                                  Spacer(),
                              
                                  Icon(Icons.arrow_circle_right_outlined,color: Colors.white,)
                              ],
                          ),
                      ),
                    )
                ],
            ),
        );
    }
}