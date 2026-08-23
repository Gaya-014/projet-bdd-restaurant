-- Liste des clients ayant fait une réservation
SELECT C.nomClient, C.prenomClient
FROM Client C
JOIN Réservation R ON C.idClient = R.idClient;

-- Commandes passées par un client donné
SELECT C.idCommande, C.dateCommande, Cl.nomClient
FROM Commande C
JOIN Réservation R ON C.idReservation = R.idReservation
JOIN Client Cl ON R.idClient = Cl.idClient
WHERE Cl.nomClient = 'MOUNIR';

-- Les plats composant un menu donné
SELECT M.nomMenu, P.nomPlat
FROM Menu M
JOIN Inclure I ON M.idMenu = I.idMenu
JOIN Plats P ON I.idPlat = P.idPlat
WHERE M.nomMenu = 'Menu TRADITIONNEL';

-- Fournisseurs livrant un ingrédient donné
SELECT F.nomFournisseur, I.nomIngredient
FROM Fournisseur F
JOIN Fournir Fo ON F.idFournisseur = Fo.idFournisseur
JOIN Ingrédients I ON Fo.idIngredient = I.idIngredient
WHERE I.nomIngredient = 'Tomate';

-- Ingrédients utilisés dans un plat
SELECT P.nomPlat, I.nomIngredient
FROM Plats P
JOIN Composer C ON P.idPlat = C.idPlat
JOIN Ingrédients I ON C.idIngredient = I.idIngredient
WHERE P.nomPlat = 'Pizza 4 fromages';

-- Serveurs ayant pris des commandes
SELECT S.nomServeur, S.PrenomServeur, C.idCommande
FROM Serveur S
JOIN Commande C ON S.idServeur = C.idServeur;

-- Menus commandés dans une commande donnée
SELECT M.nomMenu
FROM Menu M
JOIN Contenir Co ON M.idMenu = Co.idMenu
WHERE Co.idCommande = 5;

-- Requête imbriquée : clients ayant réservé pour 4 personnes ou plus
SELECT nomClient, prenomClient, Numtelephone
FROM Client
WHERE idClient IN (
    SELECT idClient
    FROM Réservation
    WHERE nbrPersonnes >= 4
);

-- Requête de calcul : montant total encaissé par mode de paiement
SELECT ModeDePaiement, SUM(Montant) AS MontantTotal
FROM Addition
GROUP BY ModeDePaiement;

-- Requête planning : réservations du 2025-11-11
SELECT C.nomClient, R.Date_, R.Heure, R.nbrPersonnes, T.NumTable
FROM Réservation R
JOIN Client C ON R.idClient = C.idClient
JOIN Table_ T ON R.idReservation = T.idReservation
WHERE R.Date_ = '2025-11-11'
ORDER BY R.Heure;

-- Requête de soustraction relationnelle : plats qui ne sont dans aucun menu
SELECT nomPlat, prixPlat
FROM Plats
WHERE idPlat NOT IN (
    SELECT DISTINCT idPlat
    FROM Inclure
);

-- Requête de division relationnelle : menus qui incluent tous les plats "boisson" (< 4.00€)
SELECT m.idMenu, m.nomMenu
FROM Menu m
WHERE NOT EXISTS (
    SELECT p.idPlat
    FROM Plats p
    WHERE p.prixPlat < 4.00
    EXCEPT
    SELECT i.idPlat
    FROM Inclure i
    WHERE i.idMenu = m.idMenu
);