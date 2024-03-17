// To parse this JSON data, do
//
//     final taskGroupModel = taskGroupModelFromJson(jsonString);

import 'dart:convert';

List<List<TaskGroupModel>> taskGroupModelFromJson(String str) => List<List<TaskGroupModel>>.from(json.decode(str).map((x) => List<TaskGroupModel>.from(x.map((x) => TaskGroupModel.fromJson(x)))));

String taskGroupModelToJson(List<List<TaskGroupModel>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class TaskGroupModel {
    int id;
    String title;
    String description;
    TaskGroup taskGroup;
    String status;
    DateTime startDate;
    DateTime startTime;
    List<SubTask> subTask;

    TaskGroupModel({
        required this.id,
        required this.title,
        required this.description,
        required this.taskGroup,
        required this.status,
        required this.startDate,
        required this.startTime,
        required this.subTask,
    });

    factory TaskGroupModel.fromJson(Map<String, dynamic> json) => TaskGroupModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        taskGroup: TaskGroup.fromJson(json["taskGroup"]),
        status: json["status"],
        startDate: DateTime.parse(json["startDate"]),
        startTime: DateTime.parse(json["startTime"]),
        subTask: List<SubTask>.from(json["subTask"].map((x) => SubTask.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "taskGroup": taskGroup.toJson(),
        "status": status,
        "startDate": startDate.toIso8601String(),
        "startTime": startTime.toIso8601String(),
        "subTask": List<dynamic>.from(subTask.map((x) => x.toJson())),
    };
}

class SubTask {
    int id;
    String tasks;
    bool completed;

    SubTask({
        required this.id,
        required this.tasks,
        required this.completed,
    });

    factory SubTask.fromJson(Map<String, dynamic> json) => SubTask(
        id: json["id"],
        tasks: json["tasks"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tasks": tasks,
        "completed": completed,
    };
}

class TaskGroup {
    int id;
    String type;
    int percentageCompletion;

    TaskGroup({
        required this.id,
        required this.type,
        required this.percentageCompletion,
    });

    factory TaskGroup.fromJson(Map<String, dynamic> json) => TaskGroup(
        id: json["id"],
        type: json["type"],
        percentageCompletion: json["percentageCompletion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "percentageCompletion": percentageCompletion,
    };
}
