package com.example.tdd_demo.tdd.repository;

import com.example.tdd_demo.tdd.model.Equipement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EquipementRepository extends JpaRepository<Equipement, Long> {

}
