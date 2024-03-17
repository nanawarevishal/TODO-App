package com.todoapp.todoapp.Services;

import java.util.List;

import com.todoapp.todoapp.Entity.Task;
import com.todoapp.todoapp.Entity.TaskGroup;

public interface TaskGroupService {
    
    public TaskGroup createTaskGroup(TaskGroup taskGroup);

    public TaskGroup findById(Long taskGroupId);

    public List<Task> findAllTaskByGroupId(Long GroupId);

    public List<TaskGroup> findAllGroupTasks();

    public TaskGroup updatePercentageCompletionTaskGroup(Long GroupId);

    public List<TaskGroup> updatePercentageCompletionAllTask();

}
