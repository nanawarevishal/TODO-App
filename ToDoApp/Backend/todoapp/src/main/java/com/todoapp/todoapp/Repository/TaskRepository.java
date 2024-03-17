package com.todoapp.todoapp.Repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.todoapp.todoapp.Entity.Task;
import com.todoapp.todoapp.Entity.TaskStatus;

public interface TaskRepository extends JpaRepository<Task,Long> {
   
    @Query("SELECT t FROM Task t WHERE t.taskGroup.id = :taskGroupId")
    public List<Task> findByTaskGroup(@Param("taskGroupId") Long taskGroupId);

    @Query("SELECT t FROM Task t WHERE t.status =:status")
    public List<Task> findByTaskStatus(@Param("status")TaskStatus status);

    @Query("SELECT t FROM Task t WHERE t.taskGroup.id = :taskGroupId AND t.status =:status")
    public List<Task> findByTaskGroupAndStatus(@Param("taskGroupId")Long taskGroupId,@Param("status")TaskStatus status);

    @Query("SELECT t FROM Task t WHERE t.startDate = :startDate")
    public List<Task> findByStartDate(@Param("startDate") LocalDate startDate);

    @Query("SELECT t FROM Task t WHERE t.startDate = :startDate AND t.status =:status")
    public List<Task> findStartDateAndStatus(@Param("startDate")LocalDate startDate,@Param("status")TaskStatus status);
    
}
