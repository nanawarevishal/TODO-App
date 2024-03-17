

import 'dart:convert';
import 'package:to_do_app/Config/Configurations.dart';
import 'package:to_do_app/Model/SingleGroupModel.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/main.dart';

class GroupTaskPageService{

    static List<SingleGroupModel>tasks = [];

    static Future<List<SingleGroupModel>> getAllTaskGroup()async{
        var response = await http.get(Uri.parse("${ConfigEndpoints.getByGroup}${MainApp.storage.read("groupId")}"));
        if(response.statusCode == 200){
            tasks.clear();
            var apiData = jsonDecode(response.body);
            for(Map<String,dynamic> index in apiData){
                tasks.add(SingleGroupModel.fromJson(index));
            }
        }
        return tasks;
    }
    // api/tasks/getByGroup-status?groupId=4&status=IN_PROGRESS
    static Future<List<SingleGroupModel>> getAllTaskByGroupIdStatus(String status)async{
        var response = await http.get(Uri.parse("${ConfigEndpoints.getBYGroupIdANDStatus}groupId=${MainApp.storage.read("groupId")}&status=$status"));
        if(response.statusCode == 200){
            var apiData = jsonDecode(response.body);
            tasks.clear();
            for(Map<String,dynamic> index in apiData){
                tasks.add(SingleGroupModel.fromJson(index));
            }
        }
        return tasks;
    }
}