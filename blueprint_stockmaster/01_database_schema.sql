-- Création de la table Produit
CREATE TABLE produit (
    id SERIAL PRIMARY KEY,
    reference VARCHAR(100) UNIQUE NOT NULL,
    designation VARCHAR(255) NOT NULL
);

-- Création de la table Emplacement
-- Un emplacement est strictement lié à un seul type de produit (id_produit).
CREATE TABLE emplacement (
    id SERIAL PRIMARY KEY,
    code_allee_rayon VARCHAR(50) UNIQUE NOT NULL,
    id_produit INT NOT NULL,
    FOREIGN KEY (id_produit) REFERENCES produit(id) ON DELETE RESTRICT
);

-- Création de la table Mouvement_Stock
-- L'historique immuable remplace toute colonne "quantité totale" modifiable.
CREATE TABLE mouvement_stock (
    id SERIAL PRIMARY KEY,
    id_emplacement INT NOT NULL,
    type_mouvement VARCHAR(10) NOT NULL CHECK (type_mouvement IN ('ENTREE', 'SORTIE')),
    quantite INT NOT NULL CHECK (quantite > 0),
    date_mouvement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_emplacement) REFERENCES emplacement(id) ON DELETE RESTRICT
);