package com.example.tdd_demo.tdd.controller;

import com.example.tdd_demo.tdd.model.Equipement;
import com.example.tdd_demo.tdd.service.EquipementService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(EquipementController.class)
@Import(EquipementControllerTest.TestEquipementServiceConfig.class)
public class EquipementControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private EquipementService equipementService;

    @Autowired
    private ObjectMapper objectMapper;

    @TestConfiguration
    static class TestEquipementServiceConfig {
        @Bean
        public EquipementService equipementService() {
            return Mockito.mock(EquipementService.class);
        }
    }

    @Test
    void enregistrerEquipement_doiventRetournerEquipementAvecStatus201() throws Exception{

        String nomEquipement = "Ordinateur Portable";
        Equipement equipement = new Equipement(nomEquipement);

        //when(equipementService.enregistrer(equipement)).thenReturn(equipement);
        when(equipementService.enregistrer(Mockito.any(Equipement.class))).thenReturn(equipement);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/equipements")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(equipement)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.nom").value(nomEquipement));

    }

}
