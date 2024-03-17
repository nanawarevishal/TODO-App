package com.todoapp.todoapp.Entity;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class TaskGroup {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    private String type;

    @JsonIgnore
    @OneToMany(mappedBy = "taskGroup",cascade = CascadeType.ALL,orphanRemoval = true)
    private List<Task>tasks = new ArrayList<>();

    private Double percentageCompletion;
}
