package com.example.tdd_demo.tdd.service;

import com.example.tdd_demo.tdd.model.Equipement;
import com.example.tdd_demo.tdd.repository.EquipementRepository;

public class EquipementService {

    private final EquipementRepository equipementRepository;

    public EquipementService(EquipementRepository equipementRepository){
        this.equipementRepository = equipementRepository;
    }

    public Equipement enregistrer(Equipement equipement){
        return equipementRepository.save(equipement);
    }
}
