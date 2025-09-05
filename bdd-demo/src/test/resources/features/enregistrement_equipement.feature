Feature: Enregistrement d'un équipement

  Scenario Outline: Enregistrer un nouvel équipement
    Given un équipement nommé "<ordinateurName>"
    When j'enregistre l'équipement
    Then Equipement sauvegardé doit avoir le nom "<ordinateurName>"

    Examples:
      |ordinateurName|
      |DELL          |
      |Lenovo        |
      |HP            |

