package com.example.bdd_demo;

public class EquipementService {
    private final EquipementRepository equipementRepository;

    public EquipementService(EquipementRepository equipementRepository){
        this.equipementRepository = equipementRepository;
    }

    public Equipement enregistrer(Equipement equipement){
        return equipementRepository.save(equipement);
    }
}
