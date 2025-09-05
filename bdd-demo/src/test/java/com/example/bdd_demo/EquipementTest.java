package com.example.bdd_demo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class EquipementTest {
    @Test
    void testGettersSetters() {
        Equipement e = new Equipement("Imprimante");
        assertEquals("Imprimante", e.getNom());

        e.setNom("Scanner");
        assertEquals("Scanner", e.getNom());


        //e.setId(1L);
        assertEquals(0, e.getId());
    }
}
