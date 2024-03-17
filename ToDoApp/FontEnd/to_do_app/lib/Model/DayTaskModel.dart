import 'dart:convert';

List<DayTaskModel> taskFromJson(String str) => List<DayTaskModel>.from(json.decode(str).map((x) => DayTaskModel.fromJson(x)));

String taskToJson(List<DayTaskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DayTaskModel {
    DayTaskModel({
        required this.id,
        required this.title,
        required this.objective,
        required this.description,
        required this.taskGroup,
        required this.status,
        required this.percentageCompletion,
        required this.startDate,
        required this.endDate,
        required this.time,
        required this.subTask,
    });

    int id;
    String title;
    String objective;
    String description;
    TaskGroup taskGroup;
    String status;
    double percentageCompletion;
    String startDate;
    String endDate;
    String time;
    List<SubTask> subTask;

    factory DayTaskModel.fromJson(Map<String, dynamic> json) => DayTaskModel(
        id: json["id"],
        title: json["title"],
        objective: json["objective"],
        description: json["description"],
        taskGroup: TaskGroup.fromJson(json["taskGroup"]),
        status: json["status"],
        percentageCompletion: json["percentageCompletion"].toDouble(),
        startDate: json["startDate"],
        endDate: json["endDate"],
        time: json["time"],
        subTask: List<SubTask>.from(json["subTask"].map((x) => SubTask.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "objective": objective,
        "description": description,
        "taskGroup": taskGroup.toJson(),
        "status": status,
        "percentageCompletion": percentageCompletion,
        "startDate": startDate,
        "endDate": endDate,
        "time": time,
        "subTask": List<dynamic>.from(subTask.map((x) => x.toJson())),
    };
}

class SubTask {
    SubTask({
        required this.id,
        required this.tasks,
        required this.completed,
    });

    int id;
    String tasks;
    bool completed;

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
    TaskGroup({
        required this.id,
        required this.type,
        required this.percentageCompletion,
    });

    int id;
    String type;
    double percentageCompletion;

    factory TaskGroup.fromJson(Map<String, dynamic> json) => TaskGroup(
        id: json["id"],
        type: json["type"],
        percentageCompletion: json["percentageCompletion"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "percentageCompletion": percentageCompletion,
    };
}
