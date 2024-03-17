
class ConfigEndpoints{

    static String URL = "http://192.168.0.103:8080/api/tasks/";

    static String statusTask = "${URL}statusTask?status=IN_PROGRESS";
    static String allTask = "${URL}allTask";
    static String taskByGroup = "${URL}taskByGroups";
    static String getByGroup = "${URL}getByGroup?groupId=";
    static String getSingleTask = "${URL}getSingleTask?taskId=";
    static String addTask = "${URL}createTask?taskGroupId=";
    static String getBYGroupIdANDStatus = "${URL}getByGroup-status?";
    static String getTodaysTask = "${URL}getByTaskByStartDate?startDate=";
    static String getTaskByDateAndStatus = "${URL}getByTaskByStartDate?startDate=";
    static String updateSubTask = "${URL}updateSubTask?taskId=";

}

// http://192.168.0.121:8080/api/tasks/statusTask?status=IN_PROGRESS
// http://127.0.0.1:8080/api/tasks/taskByGroups
// http://127.0.0.1:8080/api/tasks/statusTask?status=IN_PROGRESS
// http://127.0.0.1:8080/api/tasks/getByGroup?groupId=3
// http://127.0.0.1:8080/api/tasks/createTask?taskGroupId=3
// http://127.0.0.1:8080/api/tasks/getByTaskByStartDate?startDate=2024-03-05
// http://127.0.0.1:8080/api/tasks/getTaskByStartDateAndStatus?startDate=2024-03-05&status=TODO
// http://127.0.0.1:8080/api/tasks/updateSubTask?taskId=53&subTaskId=56
