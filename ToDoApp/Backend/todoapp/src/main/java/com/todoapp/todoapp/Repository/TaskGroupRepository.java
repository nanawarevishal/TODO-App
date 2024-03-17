package com.todoapp.todoapp.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.todoapp.todoapp.Entity.TaskGroup;

public interface TaskGroupRepository extends JpaRepository<TaskGroup,Long> {
        
}
