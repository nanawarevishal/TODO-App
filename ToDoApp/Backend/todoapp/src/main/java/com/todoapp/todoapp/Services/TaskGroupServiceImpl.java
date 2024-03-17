package com.todoapp.todoapp.Services;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoapp.todoapp.Entity.Task;
import com.todoapp.todoapp.Entity.TaskGroup;
import com.todoapp.todoapp.Exception.TaskGroupException;
import com.todoapp.todoapp.Repository.TaskGroupRepository;

@Service
public class TaskGroupServiceImpl implements TaskGroupService {

    @Autowired
    private TaskGroupRepository taskGroupRepository;

    @Override
    public TaskGroup createTaskGroup(TaskGroup taskGroup) {
        
        TaskGroup tskGp = new TaskGroup();
        tskGp.setType(taskGroup.getType());
        tskGp.setPercentageCompletion(taskGroup.getPercentageCompletion());
        
        TaskGroup savedGroup = taskGroupRepository.save(tskGp);

        return savedGroup;
    }

    @Override
    public TaskGroup findById(Long taskGroupId) {
        Optional<TaskGroup> taskGp = taskGroupRepository.findById(taskGroupId);

        if(taskGp == null){
            throw new TaskGroupException("TaskGroup not present with id: "+taskGroupId);
        }

        return taskGp.get();
    }

    @Override
    public List<Task> findAllTaskByGroupId(Long GroupId) {
       Optional<TaskGroup>opt = taskGroupRepository.findById(GroupId);

        if(!opt.isPresent() || opt == null){
                throw new TaskGroupException("Task Group not present with id: "+GroupId);
        }

        return opt.get().getTasks();
    }

    @Override
    public List<TaskGroup> findAllGroupTasks() {
        
        List<TaskGroup>taskGroups = taskGroupRepository.findAll();

        return taskGroups;
    }

    @Override
    public TaskGroup updatePercentageCompletionTaskGroup(Long GroupId) {
        
        List<Task>tasks = findAllTaskByGroupId(GroupId);

        TaskGroup taskGroup = findById(GroupId);

        double totalPercentage = 0.0;

        for(Task tsk : tasks){
            totalPercentage += tsk.getPercentageCompletion();
        }

        double percentage = ((double)totalPercentage/tasks.size());

        DecimalFormat df = new DecimalFormat("#.##");
        
        String formattedNumber = df.format(percentage);

        percentage = Double.parseDouble(formattedNumber);

        taskGroup.setPercentageCompletion(percentage);

        TaskGroup updatedTaskGroup = taskGroupRepository.save(taskGroup);

        return updatedTaskGroup;

    }

    @Override
    public List<TaskGroup> updatePercentageCompletionAllTask() {

        List<TaskGroup>taskGroups = findAllGroupTasks();

        for(TaskGroup tskGp : taskGroups){
            updatePercentageCompletionTaskGroup(tskGp.getId());
        }

        return taskGroups;
    }
    
}
