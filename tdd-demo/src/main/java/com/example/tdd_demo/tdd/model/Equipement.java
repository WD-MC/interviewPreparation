package com.example.tdd_demo.tdd.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class Equipement {
    @Id
    @GeneratedValue()
    private Long id;

    private String nom;

    // Constructeurs
    public Equipement() {}

    public Equipement(String nom) {
        this.nom = nom;
    }

    // Getters / Setters
    public Long getId() {
        return id;
    }


    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }


}
