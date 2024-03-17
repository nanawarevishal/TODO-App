

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorChangeController extends GetxController{

    RxInt selectedButton = 1.obs;

    Color changeBackGroundColor(int buttonIndex){
        
        if(buttonIndex == selectedButton.value){
            return const Color.fromARGB(255, 123, 90, 255);
        }
        return const Color.fromARGB(83, 26, 52, 252);
    }

    Color changeForeGroudColor(int buttonIndex){
        if(buttonIndex == selectedButton.value){
            return  Colors.white;
        }
        return const Color.fromARGB(255, 123, 90, 255);
    }
}
