package com.todoapp.todoapp.Services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoapp.todoapp.Entity.SubTask;
import com.todoapp.todoapp.Exception.SubTaskException;
import com.todoapp.todoapp.Repository.SubTaskRepository;


@Service
public class SubTaskServiceImpl implements SubTaskService {
    @Autowired
    private SubTaskRepository subTaskRepository;
    @Override
    public SubTask findSubTaskById(Long subTaskId) {
        
        Optional<SubTask>otp = subTaskRepository.findById(subTaskId);
        if(otp == null || !otp.isPresent()){
            throw new SubTaskException("SubTask not exist with id : "+subTaskId);
        }

        return otp.get();
    }
    
}
