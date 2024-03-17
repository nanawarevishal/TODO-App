
import 'package:flutter/material.dart';
import 'package:to_do_app/Controller/AddTaskController.dart';

class AddTaskService{

    static Future<void> addTask({required TextEditingController taskGroupController,required TextEditingController taskNameController,required TextEditingController descriptionController,required TextEditingController startDateController,required TextEditingController endDateController, required TextEditingController startTimeController,required AddTaskController controller})async{
        
        num groupId = -1;
        if(taskGroupController.text =="Daily Task"){
            groupId = 1;
        }
        else if(taskGroupController.text =="Work"){
            groupId = 2;
        }
        else if(taskGroupController.text =="Personal Project"){
            groupId = 3;
        }
        else{
            groupId = 4;
        }

        
        print("GroupId: $groupId");
        print("taskGroup:${taskGroupController.text}");
        print("name:${taskNameController.text}");
        print("desc:${descriptionController.text}");
        print("startDate:${startDateController.text}");
        print("enddate:${endDateController.text}");
        print("startTime:${startTimeController.text}");
        print(controller.subTask);

        // var response = await http.get(Uri.parse("${ConfigEndpoints.addTask}$groupId"));
    }
}