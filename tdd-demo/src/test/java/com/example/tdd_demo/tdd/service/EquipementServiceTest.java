package com.example.tdd_demo.tdd.service;

//Test pour le cas d'usage "Enregistrer un equipement"

import com.example.tdd_demo.tdd.model.Equipement;
import com.example.tdd_demo.tdd.repository.EquipementRepository;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/*
    Classe contenant les tests unitaires pour la classe EquipementService
*/
public class EquipementServiceTest {
    @Test
    void enregistrerEquipement_doitRetournerEquipementSauvegarde(){

        //Creation d'un mock du repository a l'aide de Mockito
        EquipementRepository mockRepo = mock(EquipementRepository.class);

        //Creation du service a tester auquel on injecte le mock du repository
        EquipementService service = new EquipementService(mockRepo);

        //Création d’un objet Equipement à sauvegarder
        Equipement equipement = new Equipement("Ordinateur portable");

        //Definition du comportement du mock
        when(mockRepo.save(equipement)).thenReturn(equipement);

        Equipement result = service.enregistrer(equipement);

        assertNotNull(result);
        assertEquals("Ordinateur portable", result.getNom());
    }
}
