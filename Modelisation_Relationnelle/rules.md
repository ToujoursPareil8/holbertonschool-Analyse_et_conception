## Tache 0:

#### 1. Sujets :

**CLIENT:** représente la personne qui achète (Acme Corp, TechNova,). Ses attributs sont le nom, le contact(email), et l'adresse de livraison.
**COMMANDE**: Représente l'acte d'achat à un instant T (CMD-901, CMD-902,CMD-903). Ses attributs sont l'identifiant (numéro de commande), la date d'achat et le statut.
**PRODUIT:** Représente le catalogue des articles vendus (bureau chene(P-01), Chaise Ergonomique(P-02), Lampe LED). Ses attributs sont la référence, ladésignation et le prix unitaire.

#### 2. Regles de gestion et cardinalité:

**A. Relation entre CLIENT et COMMANDE**

- Règle RG-01: Un client peut passer de zéro à plusieurs commandes. (0,n)
    - Cardinalité côté Client : (0,n)
- Règle RG-02: Une commande est obligatoirement passée par un client. (1,1)
    - Cardinalité côté Commade: (1,1)

**B. Relation entre COMMANDE et PRODUIT**

- Règle RG-03: Une commande ne peut pas être vide : elle doit contenir au moins 1 produit et peut en contenir plusieurs
    - Cardinalité côté Commande: (1,n)
- Règle RG-04: Un produit du catalogue peut être commandé jamais commandé et commandé à plusieurs reprises dans des commandes différentes.
    -Cardinalité coté Produit: (0,n)

