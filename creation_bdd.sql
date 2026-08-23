CREATE TABLE Client(
idClient BIGINT,
nomClient VARCHAR(50) NOT NULL,
prenomClient VARCHAR(50) NOT NULL,
Numtelephone VARCHAR(20),
PRIMARY KEY(idClient)
);

CREATE TABLE Addition(
idAddition INT,
Montant DECIMAL(10,2) NOT NULL,
ModeDePaiement VARCHAR(25) NOT NULL,
DateDePaiement DATE NOT NULL,
PRIMARY KEY(idAddition)
);

CREATE TABLE Réservation(
idReservation BIGINT,
Date_ DATE NOT NULL,
Heure TIME NOT NULL,
nbrPersonnes BIGINT NOT NULL,
idClient BIGINT,
PRIMARY KEY(idReservation),
FOREIGN KEY(idClient) REFERENCES Client(idClient)
);

CREATE TABLE Menu(
idMenu BIGINT,
nomMenu VARCHAR(50) NOT NULL,
PrixMenu DOUBLE NOT NULL,
DescriptionMenu VARCHAR(150) NOT NULL,
PRIMARY KEY(idMenu)
);

CREATE TABLE Table_(
idTable BIGINT,
NumTable INT NOT NULL,
numPlaces INT NOT NULL,
idReservation BIGINT NOT NULL,
PRIMARY KEY(idTable),
FOREIGN KEY(idReservation) REFERENCES Réservation(idReservation)
);

CREATE TABLE Fournisseur(
idFournisseur INT,
nomFournisseur VARCHAR(50) NOT NULL,
numTel VARCHAR(20),
email VARCHAR(50),
adresse VARCHAR(100),
PRIMARY KEY(idFournisseur)
);

CREATE TABLE Plats(
idPlat BIGINT,
nomPlat VARCHAR(80) NOT NULL,
descriptionPlat VARCHAR(150) NOT NULL,
prixPlat DOUBLE NOT NULL,
PRIMARY KEY(idPlat)
);

CREATE TABLE Ingrédients(
idIngredient VARCHAR(50),
nomIngredient VARCHAR(50) NOT NULL,
quantiteEnStock VARCHAR(50),
PRIMARY KEY(idIngredient)
);

CREATE TABLE Commande(
idCommande INT,
dateCommande DATE NOT NULL,
heureCommande TIME NOT NULL,
idAddition INT NOT NULL,
idReservation BIGINT,
PRIMARY KEY(idCommande),
UNIQUE(idAddition),
FOREIGN KEY(idAddition) REFERENCES Addition(idAddition),
FOREIGN KEY(idReservation) REFERENCES Réservation(idReservation)
);

CREATE TABLE Livraison(
idLivraison VARCHAR(50),
dateLivraison DATE,
heureLivraison TIME,
adresseLivraison VARCHAR(100),
statutdeLivr VARCHAR(50),
idClient BIGINT,
idCommande INT,
PRIMARY KEY(idLivraison),
UNIQUE(idCommande),
FOREIGN KEY(idClient) REFERENCES Client(idClient),
FOREIGN KEY(idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE Serveur(
idServeur BIGINT,
nomServeur VARCHAR(50) NOT NULL,
PrenomServeur VARCHAR(50) NOT NULL,
idCommande INT,
PRIMARY KEY(idServeur),
FOREIGN KEY(idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE Contenir(
idCommande INT,
idMenu BIGINT,
quantité BIGINT NOT NULL,
PRIMARY KEY(idCommande, idMenu),
FOREIGN KEY(idCommande) REFERENCES Commande(idCommande),
FOREIGN KEY(idMenu) REFERENCES Menu(idMenu)
);

CREATE TABLE Commander(
idCommande INT,
idPlat BIGINT,
PRIMARY KEY(idCommande, idPlat),
FOREIGN KEY(idCommande) REFERENCES Commande(idCommande),
FOREIGN KEY(idPlat) REFERENCES Plats(idPlat)
);

CREATE TABLE Inclure(
idMenu BIGINT,
idPlat BIGINT,
PRIMARY KEY(idMenu, idPlat),
FOREIGN KEY(idMenu) REFERENCES Menu(idMenu),
FOREIGN KEY(idPlat) REFERENCES Plats(idPlat)
);

CREATE TABLE Composer(
idPlat BIGINT,
idIngredient VARCHAR(50),
PRIMARY KEY(idPlat, idIngredient),
FOREIGN KEY(idPlat) REFERENCES Plats(idPlat),
FOREIGN KEY(idIngredient) REFERENCES Ingrédients(idIngredient)
);

CREATE TABLE Fournir(
idFournisseur INT,
idIngredient VARCHAR(50),
PRIMARY KEY(idFournisseur, idIngredient),
FOREIGN KEY(idFournisseur) REFERENCES Fournisseur(idFournisseur),
FOREIGN KEY(idIngredient) REFERENCES Ingrédients(idIngredient)
);

---

INSERT INTO Client (idClient, nomClient, prenomClient, Numtelephone) VALUES
(1, 'AOUANOUK', 'GAYA', '0612345678'),
(2, 'SERRAYE', 'MOUNIR', '0687654321'),
(3, 'MAHREZ', 'RIADH', '0700112233');

INSERT INTO Plats (idPlat, nomPlat, descriptionPlat, prixPlat) VALUES
(1, 'Steak Frites', 'Viande de boeuf et frites maison', 18.50),
(2, 'Salade Caesar', 'Poulet grillé, parmesan, croûtons', 14.00),
(3, 'Tiramisu', 'Dessert au café et mascarpone', 8.00),
(4, 'Mousse au chocolat', 'Dessert chocolat noir', 7.50),
(5, 'Petit Fanta', 'Boisson soda orange 33cl', 3.50),
(6, 'Petit Coca', 'Boisson soda cola 33cl', 3.50);

INSERT INTO Menu (idMenu, nomMenu, PrixMenu, DescriptionMenu) VALUES
(10, 'Menu du Jour', 25.00, 'Entrée + Plat + Dessert'),
(20, 'Menu Enfant', 12.00, 'Plat + Dessert + Boisson');

INSERT INTO Addition (idAddition, Montant, ModeDePaiement, DateDePaiement) VALUES
(100, 39.00, 'CB', '2025-11-10'),
(101, 12.00, 'Espèces', '2025-11-11');

INSERT INTO Serveur (idServeur, nomServeur, PrenomServeur) VALUES
(50, 'Belaili', 'Youssef', NULL);

INSERT INTO Inclure (idMenu, idPlat) VALUES
(10, 1),
(10, 2),
(10, 3),
(20, 1),
(20, 4),
(20, 5),
(20, 6);

INSERT INTO Réservation (idReservation, Date_, Heure, nbrPersonnes, idClient) VALUES
(1000, '2025-11-10', '20:00:00', 2, 1),
(1001, '2025-11-11', '12:30:00', 5, 2);

INSERT INTO Table_ (idTable, NumTable, numPlaces, idReservation) VALUES
(1, 4, 2, 1000),
(2, 10, 6, 1001);

INSERT INTO Commande (idCommande, dateCommande, heureCommande, idAddition, idReservation) VALUES
(500, '2025-11-10', '20:05:00', 100, 1000),
(501, '2025-11-11', '12:35:00', 101, 1001);

INSERT INTO Commander (idCommande, idPlat) VALUES
(500, 2),
(500, 1);

INSERT INTO Contenir (idCommande, idMenu, quantité) VALUES
(501, 20, 1);

UPDATE Serveur SET idCommande = 500 WHERE idServeur = 50;