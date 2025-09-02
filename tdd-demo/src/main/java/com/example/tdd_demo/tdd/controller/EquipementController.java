package com.example.tdd_demo.tdd.controller;

import com.example.tdd_demo.tdd.model.Equipement;
import com.example.tdd_demo.tdd.service.EquipementService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/equipements")
public class EquipementController {
    private final EquipementService equipementService;

    public EquipementController(EquipementService equipementService){
        this.equipementService = equipementService;
    }

    @PostMapping
    public ResponseEntity<Equipement> enregistrerEquipement(@RequestBody Equipement equipement){
        Equipement saved = equipementService.enregistrer(equipement);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }
}
