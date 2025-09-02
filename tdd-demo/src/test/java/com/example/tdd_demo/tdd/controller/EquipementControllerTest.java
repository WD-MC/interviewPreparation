package com.example.tdd_demo.tdd.controller;

import com.example.tdd_demo.tdd.model.Equipement;
import com.example.tdd_demo.tdd.service.EquipementService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest()
public class EquipementControllerTest {

    @Autowired
    private MockMvc mockMvc;

    private EquipementService equipementService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void enregistrerEquipement_doiventRetournerEquipementAvecStatus201() throws Exception{

        Equipement equipement = new Equipement("Ordinateur Portable");
        when(equipementService.enregistrer(equipement)).thenReturn(equipement);

        mockMvc.perform(post("/api/equipements")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(equipement)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.nom").value("Ordinateur Portable"));
    }

}
