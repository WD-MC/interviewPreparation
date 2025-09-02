package com.example.tdd_demo.tdd.service;

//Test pour le cas d'usage "Enregistrer un equipement"

import com.example.tdd_demo.tdd.model.Equipement;
import com.example.tdd_demo.tdd.repository.EquipementRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/*
    Classe contenant les tests unitaires pour la classe EquipementService
*/
public class EquipementServiceTest {

    private String nomEquipement = "Ordinateur portable";
    //@Test

    @ParameterizedTest
    @ValueSource(strings = {"Ordinateur Portable", "Clavier", "Écran 24 pouces"})
    void enregistrerEquipement_doitRetournerEquipementSauvegarde(){

        //Creation d'un mock du repository a l'aide de Mockito
        EquipementRepository mockRepo = mock(EquipementRepository.class);

        //Creation du service a tester auquel on injecte le mock du repository
        EquipementService service = new EquipementService(mockRepo);

        //Création d’un objet Equipement à sauvegarder
        Equipement equipement = new Equipement(nomEquipement);

        //Definition du comportement du mock
        when(mockRepo.save(equipement)).thenReturn(equipement);

        Equipement result = service.enregistrer(equipement);

        assertNotNull(result);
        assertEquals(nomEquipement, result.getNom());
    }
}
