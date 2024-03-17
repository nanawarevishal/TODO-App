package com.todoapp.todoapp.Services;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoapp.todoapp.Entity.SubTask;
import com.todoapp.todoapp.Entity.Task;
import com.todoapp.todoapp.Entity.TaskGroup;
import com.todoapp.todoapp.Entity.TaskStatus;
import com.todoapp.todoapp.Exception.TaskException;
import com.todoapp.todoapp.Repository.TaskRepository;
import com.todoapp.todoapp.Repository.SubTaskRepository;

@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private SubTaskRepository subTaskRepository;

    @Autowired
    private TaskGroupService taskGroupService;

    @Autowired
    private SubTaskService subTaskService;

    @Override
    public Task createTask(Task task,Long taskGroupId) {

        TaskGroup taskGroup = taskGroupService.findById(taskGroupId);
        
        Task newTask = new Task();

        newTask.setTitle(task.getTitle());
        newTask.setDescription(task.getDescription());
        newTask.setTaskGroup(taskGroup);
        newTask.setStatus(task.getStatus());
        newTask.setStartDate(LocalDate.now());
        newTask.setEndDate(LocalDate.now());
        newTask.setTime(LocalTime.now());
        newTask.setObjective(task.getObjective());
        newTask.setPercentageCompletion((double)0.0);
        
        for(SubTask data : task.getSubTask()){
            SubTask subTask = new SubTask();
            subTask.setTasks(data.getTasks());
            subTask.setCompleted(false);
            SubTask savedSubTask = subTaskRepository.save(subTask);
            System.err.println("List: "+subTask.toString());
            System.err.println("Data: "+savedSubTask.toString());
            newTask.getSubTask().add(savedSubTask);
        }

        Task savedTask = taskRepository.save(newTask);

        return savedTask;
    }

    @Override
    public Task updateTask(Long taskId,Task task) {
        Task isExist = getTaskById(taskId);

        if(task.getObjective()!=null){
            isExist.setObjective(task.getObjective());
        }

        Task savedTask = taskRepository.save(isExist);

        return savedTask;
    }

    @Override
    public List<Task> getTaskByTaskGroup(Long taskGroupId) {
        
        List<Task>tasks = taskRepository.findByTaskGroup(taskGroupId);

        return tasks;
    }

    @Override
    public List<Task> getTaskByStatus(TaskStatus status) {
        
        List<Task>tasks = taskRepository.findByTaskStatus(status);

        return tasks;
    }

    @Override
    public List<SubTask> getTaskSubTask(Long taskId) {

        Task task = getTaskById(taskId);

        List<SubTask>subTasks = task.getSubTask();

        return subTasks;
    }

    @Override
    public Task getTaskById(Long taskId) {
        
        Optional<Task>opt = taskRepository.findById(taskId);

        if(opt == null){
            throw new TaskException("Task not found with ID"+taskId);
        }

        Task task = opt.get();
        return task;
    }

    @Override
    public List<Task> getAllTasks() {
        
        List<Task>tasks = taskRepository.findAll();

        for(Task tsk : tasks){
            Task updatedTask = updateTaskCompletionPercentage(tsk.getId());

            taskRepository.save(updatedTask);
        }
        return tasks;
    }

    @Override
    public List<List<Task>> getAllTaskByGroups() {
        List<Task>daily_task = getTaskByTaskGroup((long)1);
        List<Task>work = getTaskByTaskGroup((long)2);
        List<Task>office_project = getTaskByTaskGroup((long)3);
        List<Task>personal_project = getTaskByTaskGroup((long)4);

        List<List<Task>>list =new ArrayList<>();

        list.add(daily_task);
        list.add(work);
        list.add(office_project);
        list.add(personal_project);

        return list;
    }

    @Override
    public List<Task> getAllTaskOfGroup(Long groupId) {
        
        List<Task>tasks = taskRepository.findByTaskGroup(groupId);

        return tasks;
    }


    @Override
    public void deleteTaskById(Long taskId) {
        taskRepository.deleteById(taskId);
    }

    @Override
    public List<Task> findTaskByGroupAndStatus(Long groupId, TaskStatus status) {
        
        List<Task>tasks = taskRepository.findByTaskGroupAndStatus(groupId, status);

        return tasks;
    }

    @Override
    public List<Task> findTaskByStartDate(LocalDate startDate) {
        List<Task>task = taskRepository.findByStartDate(startDate);

        return task;
    }

    @Override
    public List<Task> findTaskByStartDateAndStatus(LocalDate startDate, TaskStatus status) {
        List<Task>tasks = taskRepository.findStartDateAndStatus(startDate, status);

        return tasks;
    }

    @Override
    public Task updateTaskCompletionPercentage(Long taskId) {
        
        Task task = getTaskById(taskId);

        int cntForSubTaskComplete = 0;

        for(SubTask sb : task.getSubTask()){
            if(sb.isCompleted()){
                cntForSubTaskComplete++;
            }
        }

        double percentage = ((double)cntForSubTaskComplete/task.getSubTask().size()) * 100;

        DecimalFormat df = new DecimalFormat("#.##");
        
        String formattedNumber = df.format(percentage);

        percentage = Double.parseDouble(formattedNumber);

        task.setPercentageCompletion(percentage);

        Task updatedTask = taskRepository.save(task);

        return updatedTask;

    }

    @Override
    public Task updateSubTaskCompletionStatus(Long taskId,Long subTaskId) {
        Task task = getTaskById(taskId);

        SubTask subTask  = subTaskService.findSubTaskById(subTaskId);

        subTask.setCompleted(!subTask.isCompleted());

        subTaskRepository.save(subTask);

        Task savedTask = taskRepository.save(task);

        Task updatedTask = updateTaskCompletionPercentage(savedTask.getId());

        System.out.println("Updated Task :"+updatedTask);

        return updatedTask;
    }

    @Override
    public List<Task> addMultipleTask(List<Task> tasks, Long taskGroupId) {
        
        List<Task>taskls = new ArrayList<>();
        for(Task task : tasks){
            TaskGroup taskGroup = taskGroupService.findById(taskGroupId);
        
            Task newTask = new Task();
    
            newTask.setTitle(task.getTitle());
            newTask.setDescription(task.getDescription());
            newTask.setTaskGroup(taskGroup);
            newTask.setStatus(task.getStatus());
            newTask.setStartDate(LocalDate.now());
            newTask.setEndDate(LocalDate.now());
            newTask.setTime(LocalTime.now());
            newTask.setObjective(task.getObjective());
            newTask.setPercentageCompletion((double)0.0);
            
            for(SubTask data : task.getSubTask()){
                SubTask subTask = new SubTask();
                subTask.setTasks(data.getTasks());
                subTask.setCompleted(false);
                SubTask savedSubTask = subTaskRepository.save(subTask);
                System.err.println("List: "+subTask.toString());
                System.err.println("Data: "+savedSubTask.toString());
                newTask.getSubTask().add(savedSubTask);
            }
    
            Task savedTask = taskRepository.save(newTask);

            taskls.add(savedTask);
        }

        return taskls;
    }

}
