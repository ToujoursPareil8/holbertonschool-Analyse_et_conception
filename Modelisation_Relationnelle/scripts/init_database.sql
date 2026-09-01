-- Script d'initialisation de la base MegaShop-B2B
-- Auteur : [Votre Nom]

BEGIN;

-- ============================================
-- 1. NETTOYAGE (ordre inverse des dépendances)
-- ============================================
DROP TABLE IF EXISTS ligne_commande CASCADE;
DROP TABLE IF EXISTS commande CASCADE;
DROP TABLE IF EXISTS produit CASCADE;
DROP TABLE IF EXISTS client CASCADE;

-- ============================================
-- 2. TABLES SANS DÉPENDANCE
-- ============================================

CREATE TABLE client (
    id_client       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nom             VARCHAR(150) NOT NULL,
    contact_email   VARCHAR(150),
    adresse         VARCHAR(255) NOT NULL
);

CREATE TABLE produit (
    id_produit      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code_produit    VARCHAR(20) NOT NULL UNIQUE,
    designation     VARCHAR(150) NOT NULL,
    prix_unitaire   DECIMAL(10,2) NOT NULL CHECK (prix_unitaire >= 0)
);

-- ============================================
-- 3. TABLES AVEC DÉPENDANCE SIMPLE
-- ============================================

CREATE TABLE commande (
    id_commande     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    reference       VARCHAR(20) NOT NULL UNIQUE,   -- ex: CMD-901
    date_commande   DATE NOT NULL,
    statut          VARCHAR(20) NOT NULL DEFAULT 'EN_COURS'
                        CHECK (statut IN ('EN_COURS', 'LIVREE', 'ANNULEE')),
    id_client       UUID NOT NULL,
    CONSTRAINT fk_commande_client
        FOREIGN KEY (id_client) REFERENCES client(id_client)
);

-- ============================================
-- 4. TABLE DE LIAISON (association porteuse "Contient")
-- ============================================

CREATE TABLE ligne_commande (
    id_commande     UUID NOT NULL,
    id_produit      UUID NOT NULL,
    quantite        INTEGER NOT NULL CHECK (quantite > 0),
    prix_unitaire_ht DECIMAL(10,2) NOT NULL CHECK (prix_unitaire_ht >= 0),
    PRIMARY KEY (id_commande, id_produit),
    CONSTRAINT fk_ligne_commande
        FOREIGN KEY (id_commande) REFERENCES commande(id_commande)
        ON DELETE CASCADE,
    CONSTRAINT fk_ligne_produit
        FOREIGN KEY (id_produit) REFERENCES produit(id_produit)
);

COMMIT;