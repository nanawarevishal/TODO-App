package com.todoapp.todoapp.Services;

import java.time.LocalDate;
import java.util.List;

import com.todoapp.todoapp.Entity.SubTask;
import com.todoapp.todoapp.Entity.Task;
import com.todoapp.todoapp.Entity.TaskStatus;

public interface TaskService {
    
    public Task createTask(Task task,Long taskGroupId);

    public List<Task> addMultipleTask(List<Task>tasks,Long taskGroupId);

    public Task updateTask(Long taskId,Task task);

    public Task getTaskById(Long taskId);

    public List<Task> getTaskByTaskGroup(Long taskGroupId);

    public List<Task> getTaskByStatus(TaskStatus status);

    public List<SubTask> getTaskSubTask(Long taskId);

    public List<Task> getAllTasks();

    public List<List<Task>> getAllTaskByGroups();

    public List<Task> getAllTaskOfGroup(Long groupId);

    public void deleteTaskById(Long taskId);

    public List<Task> findTaskByGroupAndStatus(Long groupId,TaskStatus status);

    public List<Task> findTaskByStartDate(LocalDate startDate);

    public List<Task> findTaskByStartDateAndStatus(LocalDate startDate,TaskStatus status);

    public Task updateTaskCompletionPercentage(Long taskId);

    public Task updateSubTaskCompletionStatus(Long taskId,Long subTaskId);

}
