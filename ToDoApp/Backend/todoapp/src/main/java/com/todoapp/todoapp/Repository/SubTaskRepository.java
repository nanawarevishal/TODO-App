package com.todoapp.todoapp.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.todoapp.todoapp.Entity.SubTask;

public interface SubTaskRepository extends JpaRepository<SubTask,Long>{
    
}
