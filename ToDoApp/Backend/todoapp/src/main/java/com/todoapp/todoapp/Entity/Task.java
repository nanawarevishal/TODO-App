package com.todoapp.todoapp.Entity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Task {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String title;
    
    private String objective;

    private String description;

    @ManyToOne(cascade = CascadeType.ALL)
    private TaskGroup taskGroup;

    private TaskStatus status;

    private Double percentageCompletion;

    private LocalDate startDate;

    private LocalDate endDate;

    private LocalTime time;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SubTask>subTask=new ArrayList<>();

}
