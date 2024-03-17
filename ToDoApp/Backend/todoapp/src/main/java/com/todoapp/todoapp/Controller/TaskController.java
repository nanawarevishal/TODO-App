package com.todoapp.todoapp.Controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.todoapp.todoapp.Entity.SubTask;
import com.todoapp.todoapp.Entity.Task;
import com.todoapp.todoapp.Entity.TaskStatus;
import com.todoapp.todoapp.Services.TaskService;

@RestController
@RequestMapping("/api/tasks/")
public class TaskController {

    @Autowired
    private TaskService taskService;

    @PostMapping("createTask")
    public ResponseEntity<Task> createTaskHandler(@RequestBody Task task,@RequestParam("taskGroupId")Long taskGroupId){
        
        Task newTask = taskService.createTask(task,taskGroupId);
        
        return new ResponseEntity<Task>(newTask, HttpStatus.OK);
    }

    @GetMapping("groupTask")
    public ResponseEntity<List<Task>> getTaskByGroupHandler(@RequestParam("taskGroupId")Long taskGroupId){

        List<Task> tasks = taskService.getTaskByTaskGroup(taskGroupId);

        return new ResponseEntity<List<Task>>(tasks, HttpStatus.OK);
    } 

    @GetMapping("statusTask")
    public ResponseEntity<List<Task>> getTaskByStatus(@RequestParam("status")TaskStatus taskStatus){

        List<Task> tasks = taskService.getTaskByStatus(taskStatus);

        return new ResponseEntity<List<Task>>(tasks, HttpStatus.OK);
    }  

    @GetMapping("subTask")
    public ResponseEntity<List<SubTask>> getSubTask(@RequestParam("taskId")Long taskId){

        List <SubTask>task = taskService.getTaskSubTask(taskId);

        return new ResponseEntity<List<SubTask>> (task, HttpStatus.OK);
    }  

    @GetMapping("allTask")
    public ResponseEntity<List<Task>> getAllTaskHandler(){

        List <Task>task = taskService.getAllTasks();

        return new ResponseEntity<List<Task>> (task, HttpStatus.OK);
    }
    
    @GetMapping("taskByGroups")
    public ResponseEntity<List<List<Task>>> getAllTaskByGroupsHandler(){
        List<List<Task>>taskls = taskService.getAllTaskByGroups();

        return new ResponseEntity<List<List<Task>>>(taskls, HttpStatus.OK);
    }

    @GetMapping("getByGroup")
    public ResponseEntity<List<Task>> getTaskByGroupId(@RequestParam("groupId")Long groudId){
    
        List<Task>tasks = taskService.getAllTaskOfGroup(groudId);

        return new ResponseEntity<List<Task>>(tasks,HttpStatus.OK);
    }

    @GetMapping("getSingleTask")
    public ResponseEntity<Task> getTaskByIdHandler(@RequestParam("taskId")Long taskId){

        Task task = taskService.getTaskById(taskId);

        return new ResponseEntity<Task>(task, HttpStatus.OK);
    }

    @DeleteMapping("deleteTask")
    public ResponseEntity<String> deleteTaskHandler(@RequestParam("taskId")Long taskId){

        taskService.deleteTaskById(taskId);

        return new ResponseEntity<String>("Task deleted Successfully",HttpStatus.OK);

    }

    @PutMapping("updatetask")
    public ResponseEntity<Task> updateTaskHandler(@RequestBody Task task,@RequestParam("taskId")Long taksId){

        Task newTask = taskService.updateTask(taksId, task);

        return new ResponseEntity<Task>(newTask,HttpStatus.OK);
    }

    @GetMapping("getByGroup-status")
    public ResponseEntity<List<Task>> getTaskByGroupIdAndStatus(@RequestParam("groupId")Long taskGroupId,@RequestParam("status")TaskStatus status){

        List<Task>tasks = taskService.findTaskByGroupAndStatus(taskGroupId, status);

        return new ResponseEntity<List<Task>>(tasks,HttpStatus.OK);
    }

    @GetMapping("getByTaskByStartDate")
    public ResponseEntity<List<Task>> getTaskByStartDate(@RequestParam("startDate")String startDate){

        LocalDate date = LocalDate.parse(startDate);
        List<Task> tasks = taskService.findTaskByStartDate(date);
        return new ResponseEntity<List<Task>>(tasks, HttpStatus.OK);
    }

    @GetMapping("getTaskByStartDateAndStatus")
    public ResponseEntity<List<Task>>getTaskByStartDateAndTaskStatus(@RequestParam("startDate")String startDate,@RequestParam("status")TaskStatus status){

        LocalDate date = LocalDate.parse(startDate);
        List<Task>tasks = taskService.findTaskByStartDateAndStatus(date, status);
        return new ResponseEntity<List<Task>>(tasks, HttpStatus.OK);
    }

    @GetMapping("updateSubTask")
    public ResponseEntity<Task> updateSubTaskCompletionHandler(@RequestParam("taskId")Long taskId,@RequestParam("subTaskId")Long subTaskId){

        Task task = taskService.updateSubTaskCompletionStatus(taskId, subTaskId);

        return new ResponseEntity<Task>(task, HttpStatus.OK);
    }
}
