package com.todoapp.todoapp.Controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.todoapp.todoapp.Entity.TaskGroup;
import com.todoapp.todoapp.Services.TaskGroupService;

@RestController
@RequestMapping("/api/taskGroup/")
public class TaskGroupController {

    @Autowired
    private TaskGroupService taskGroupService;


    @PostMapping("create")
    public ResponseEntity<TaskGroup> createTaskGroupHandler(@RequestBody TaskGroup taskGroup){

        TaskGroup tsk = taskGroupService.createTaskGroup(taskGroup);

        return new ResponseEntity<TaskGroup>(tsk,HttpStatus.OK);
    }

    @GetMapping("getAllTaskGroups")
    public ResponseEntity<List<TaskGroup>> findAllTaskGroups(){
        List<TaskGroup>taskGroups = taskGroupService.findAllGroupTasks();
        
        return new ResponseEntity<List<TaskGroup>>(taskGroups, HttpStatus.OK);
    }

    @GetMapping("updateCompletionPercentageTaskGroup")
    public ResponseEntity<List<TaskGroup>> updateTaskCompletionPercentage(){

        List<TaskGroup>taskGroup = taskGroupService.updatePercentageCompletionAllTask();

        return new ResponseEntity<List<TaskGroup>>(taskGroup, HttpStatus.OK);
    }

    @GetMapping("updatePercentageCompeltionSingleTaskGroup")
    public ResponseEntity<TaskGroup> updatePercentageCompletionTaskGroup(@RequestParam("taskGroupId")Long taskGroupId){

        TaskGroup taskGroup = taskGroupService.updatePercentageCompletionTaskGroup(taskGroupId);

        return new ResponseEntity<TaskGroup>(taskGroup,HttpStatus.OK);
    }
}
