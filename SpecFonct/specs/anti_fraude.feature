Feature: Gouvernance et blocage des paiements frauduleux
  En tant que Responsable de la Gouvernance Financière
  Je veux que le système évalue le niveau de risque de chaque paiement
  Afin de bloquer les transactions potentiellement frauduleuses protégeant ainsi l'entreprise

  Scenario: Validation d'un paiement standard sans risque
    Given un client standard
    And une commande d'un montant de 5000 euros à destination de la "France"
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance

  Scenario: Exemption de contrôle pour les clients VIP
    Given un client au statut VIP
    And une commande d'un montant de 15000 euros à destination d'un pays sous embargo
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance grâce au statut VIP

  Scenario Outline: Blocage par la gouvernance selon la matrice de risque
    Given un client standard avec une commande de <montant_cmd> euros vers la "<destination>"
    When le client soumet son paiement
    Then le paiement est <resultat_paiement> par la gouvernance

    Examples:
      | montant_cmd | destination | resultat_paiement |
      | 5000        | Syldavie    | accepté            |
      | 10000       | France      | accepté            |
      | 10000       | Syldavie    | accepté            |
      | 10001       | France      | accepté            |
      | 10001       | Syldavie    | refusé             |
      | 15000       | Bordurie    | refusé             |
