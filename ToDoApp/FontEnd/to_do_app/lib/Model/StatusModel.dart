class StatusModel {
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

  StatusModel({
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

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      title: json['title'],
      objective: json['objective'],
      description: json['description'],
      taskGroup: TaskGroup.fromJson(json['taskGroup']),
      status: json['status'],
      percentageCompletion: json['percentageCompletion'].toDouble(),
      startDate: json['startDate'],
      endDate: json['endDate'],
      time: json['time'],
      subTask: List<SubTask>.from(json['subTask'].map((x) => SubTask.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'objective': objective,
      'description': description,
      'taskGroup': taskGroup.toJson(),
      'status': status,
      'percentageCompletion': percentageCompletion,
      'startDate': startDate,
      'endDate': endDate,
      'time': time,
      'subTask': List<dynamic>.from(subTask.map((x) => x.toJson())),
    };
  }
}

class TaskGroup {
  int id;
  String type;
  double percentageCompletion;

  TaskGroup({
    required this.id,
    required this.type,
    required this.percentageCompletion,
  });

  factory TaskGroup.fromJson(Map<String, dynamic> json) {
    return TaskGroup(
      id: json['id'],
      type: json['type'],
      percentageCompletion: json['percentageCompletion'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'percentageCompletion': percentageCompletion,
    };
  }
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

  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      id: json['id'],
      tasks: json['tasks'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tasks': tasks,
      'completed': completed,
    };
  }
}
