Feature: Traçabilité et sécurisation des mouvements d'inventaire
  En tant que responsable d'entrepôt
  Je veux que chaque mouvement de stock soit tracé et contrôlé
  Afin de garantir qu'aucun emplacement ne puisse jamais afficher un stock négatif

  Scenario: Enregistrement d'une entrée de stock
    Given l'emplacement "Allée A - Rayon 2" contient un stock disponible de 50 unités
    When un manutentionnaire déclare une entrée de 20 unités sur cet emplacement
    Then le stock disponible de l'emplacement passe à 70 unités

  Scenario Outline: Sécurisation des sorties de stock selon la disponibilité
    Given l'emplacement "Allée A - Rayon 2" contient un stock disponible de <stock_disponible> unités
    When un manutentionnaire déclare une sortie de <quantite_sortie> unités sur cet emplacement
    Then <resultat>

    Examples:
      | stock_disponible | quantite_sortie | resultat                                                        |
      | 50               | 20              | le stock disponible de l'emplacement passe à 30 unités          |
      | 50               | 50              | le stock disponible de l'emplacement passe à 0 unité            |
      | 50               | 51              | le mouvement est rejeté car le stock disponible est insuffisant |
      | 0                | 1               | le mouvement est rejeté car le stock disponible est insuffisant |
