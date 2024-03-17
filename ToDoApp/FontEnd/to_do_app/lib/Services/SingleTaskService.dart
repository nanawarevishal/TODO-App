
import 'dart:convert';

import 'package:to_do_app/Config/Configurations.dart';
import 'package:to_do_app/Config/TaskGroupConfig.dart';
import 'package:to_do_app/Model/SingleTaskModel.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/main.dart';

class TaskServices{

    static SingleTaskModel? task;

    static Future<SingleTaskModel?> getSingleTaskData()async{

        var response = await http.get(Uri.parse("${ConfigEndpoints.getSingleTask}${MainApp.storage.read("taskId")}"));
        if(response.statusCode == 200){
            var apiData = jsonDecode(response.body);
            return SingleTaskModel.fromJson(apiData);
        }
        return task;
    }

    
    static Future<SingleTaskModel?>updateSubTask(num taskId,num subTaskId)async{
        var response = await http.get(Uri.parse("${ConfigEndpoints.updateSubTask}$taskId&subTaskId=$subTaskId"));
        if(response.statusCode == 200){
            var apiData = jsonDecode(response.body);
            return SingleTaskModel.fromJson(apiData);
        }

        return task;
    }

    static Future<void> updateSingleTaskGroupPercentage(num taskGroupId)async{
        var response = await http.get(Uri.parse("${TaskGroupConfigEndpoints.updateSingleTaskGroupPercentage}$taskGroupId"));
    }
}