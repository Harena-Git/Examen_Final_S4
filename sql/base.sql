CREATE DATABASE tp_flight CHARACTER SET utf8mb4;
USE tp_flight;

CREATE TABLE etablissement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    fond DECIMAL(12,2) DEFAULT 0.00,
    date_creation DATE DEFAULT CURRENT_DATE
);

CREATE TABLE type_pret (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(100) NOT NULL,
    taux DECIMAL(5,2) NOT NULL CHECK (taux > 0),
    duree_max INT NOT NULL CHECK (duree_max > 0),
    montant_min DECIMAL(12,2) DEFAULT 1000.00
);

CREATE TABLE client (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    cin VARCHAR(20) UNIQUE NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    date_inscription DATE DEFAULT CURRENT_DATE
);

CREATE TABLE pret (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT NOT NULL,
    id_type_pret INT NOT NULL,
    montant DECIMAL(12,2) NOT NULL CHECK (montant > 0),
    duree INT NOT NULL CHECK (duree > 0),
    date_pret DATE DEFAULT CURRENT_DATE,
    statut ENUM('en_attente', 'approuve', 'refuse', 'en_cours', 'rembourse') DEFAULT 'en_attente',
    FOREIGN KEY (id_client) REFERENCES client(id),
    FOREIGN KEY (id_type_pret) REFERENCES type_pret(id)
);

CREATE TABLE remboursement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pret INT NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    date_prevue DATE NOT NULL,
    paye BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_pret) REFERENCES pret(id)
);

CREATE TABLE historique_fond (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_etablissement INT NOT NULL,
    type_operation ENUM('ajout', 'retrait', 'correction') NOT NULL DEFAULT 'ajout',
    montant DECIMAL(12,2) NOT NULL CHECK (montant > 0),
    commentaire TEXT,
    date_operation DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_etablissement) REFERENCES etablissement(id)
);
