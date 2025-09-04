package com.example.bdd_demo.stepdefinitions;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.example.bdd_demo.Equipement;
import com.example.bdd_demo.EquipementRepository;
import com.example.bdd_demo.EquipementService;
import io.cucumber.java.en.*;

public class EquipementStepDefinitions {
    private Equipement equipement;
    private Equipement resultat;
    private EquipementRepository mockRepo;
    private EquipementService service;

    @Given("un équipement nommé {string}")
    public void un_equipement_nomme(String nom) {
        mockRepo = mock(EquipementRepository.class);
        service = new EquipementService(mockRepo);

        equipement = new Equipement(nom);
        when(mockRepo.save(equipement)).thenReturn(equipement);
    }

    @When("j'enregistre l'équipement")
    public void j_enregistre_l_equipement() {
        resultat = service.enregistrer(equipement);
    }

    @Then("Equipement sauvegardé doit avoir le nom {string}")
    public void l_equipement_sauvegarde_doit_avoir_le_nom(String nomAttendu) {
        
        assertNotNull(resultat);
        assertEquals(nomAttendu, resultat.getNom());
    }
}
