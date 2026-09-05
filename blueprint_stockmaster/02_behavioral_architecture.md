# Architecture Comportementale : Mouvement de Stock

Ce diagramme de séquence illustre le flux exact de traitement d'un mouvement de stock, mettant en évidence le respect de la règle de gouvernance interdisant le stock négatif.

```mermaid
sequenceDiagram
    actor Manutentionnaire
    participant API as API Web (Backend)
    participant BDD as Base de Données

    Manutentionnaire->>API: POST /inventory/movements {emplacementId, type, quantite}
    
    rect rgb(240, 240, 255)
        note right of API: Phase de vérification du stock
        API->>BDD: SELECT stock_actuel (SUM(entrees) - SUM(sorties)) WHERE id_emplacement = emplacementId
        BDD-->>API: Retourne stock_actuel
    end

    alt typeMouvement == 'SORTIE' AND quantite > stock_actuel
        note over API,BDD: Violation de la règle de gouvernance absolue
        API-->>Manutentionnaire: HTTP 409 Conflict (Stock insuffisant)
    else Stock suffisant OU typeMouvement == 'ENTREE'
        note over API,BDD: Validation métier réussie
        API->>BDD: INSERT INTO mouvement_stock (id_emplacement, type_mouvement, quantite)
        BDD-->>API: Confirmation d'insertion (id généré)
        API-->>Manutentionnaire: HTTP 201 Created
    end