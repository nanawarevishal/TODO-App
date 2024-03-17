
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:to_do_app/Config/Configurations.dart';
import 'package:to_do_app/Model/DayTaskModel.dart';
import 'package:http/http.dart' as http;

class DayTaskService{

    static List<DayTaskModel>tasks = [];

    static Future<List<DayTaskModel>> getAllTodaysTasks(DateTime dateTime)async{

        DateFormat formatter = DateFormat("yyyy-MM-dd");
        String todaysDate = formatter.format(dateTime);
        todaysDate = todaysDate.trim();
        var response = await http.get(Uri.parse("http://192.168.0.121:8080/api/tasks/getByTaskByStartDate?startDate=2024-03-05"));
        // var response = await http.get(Uri.parse("${ConfigEndpoints.getTaskByDateAndStatus}$todaysDate"));
        if(response.statusCode == 200){
            tasks.clear();
            var apiData = jsonDecode(response.body);
            for(Map<String,dynamic> index in apiData){
                tasks.add(DayTaskModel.fromJson(index));
            }
        }

        else{
            print(response.body);
        }

        return tasks;
    }

    static Future<List<DayTaskModel>> getAllTaskByStartDateAndStatus(DateTime date,String status)async{
        DateFormat formatter = DateFormat("yyyy-MM-dd");
        String todayaDate = formatter.format(date);
        todayaDate = todayaDate.trim();

        // var response = await http.get(Uri.parse("${ConfigEndpoints.getTaskByDateAndStatus}$todayaDate&status=$status"));
        //  var response = await http.get(Uri.parse("${ConfigEndpoints.getTaskByDateAndStatus}2024-03-05&status=$status"));
         var response = await http.get(Uri.parse("http://192.168.0.121:8080/api/tasks/getTaskByStartDateAndStatus?startDate=2024-03-05&status=$status"));
        
        if(response.statusCode == 200){
            var apiData = jsonDecode(response.body);
            tasks.clear();
            for(Map<String,dynamic>index in apiData){
                tasks.add(DayTaskModel.fromJson(index));
            }
        }

        else{
            print(response.body);
        }

        return tasks;
    }
}