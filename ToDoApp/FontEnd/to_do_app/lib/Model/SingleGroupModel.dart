class SingleGroupModel {
  final int id;
  final String title;
  final String objective;
  final String description;
  final TaskGroup taskGroup;
  final String status;
  final double percentageCompletion;
  final String startDate;
  final String endDate;
  final String time;
  final List<SubTask> subTask;

  SingleGroupModel({
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

  factory SingleGroupModel.fromJson(Map<String, dynamic> json) {
    return SingleGroupModel(
      id: json['id'],
      title: json['title'],
      objective: json['objective'],
      description: json['description'],
      taskGroup: TaskGroup.fromJson(json['taskGroup']),
      status: json['status'],
      percentageCompletion: json['percentageCompletion'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      time: json['time'],
      subTask: List<SubTask>.from(
          json['subTask'].map((subTask) => SubTask.fromJson(subTask))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
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
      'subTask': subTask.map((subTask) => subTask.toJson()).toList(),
    };
    return data;
  }
}

class TaskGroup {
  final int id;
  final String type;
  final double percentageCompletion;

  TaskGroup({
    required this.id,
    required this.type,
    required this.percentageCompletion,
  });

  factory TaskGroup.fromJson(Map<String, dynamic> json) {
    return TaskGroup(
      id: json['id'],
      type: json['type'],
      percentageCompletion: json['percentageCompletion'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'type': type,
      'percentageCompletion': percentageCompletion,
    };
    return data;
  }
}

class SubTask {
  final int id;
  final String tasks;
  final bool completed;

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
    final Map<String, dynamic> data = {
      'id': id,
      'tasks': tasks,
      'completed': completed,
    };
    return data;
  }
}
