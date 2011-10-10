% Appel : adversaire(+Joueur, -Adversaire).
%
% Permet d'effectuer le changement de joueur. L'adversaire de Joueur est 
% unifi� dans Adversaire.
adversaire(o, x).
adversaire(x, o).

% Appel : meilleurCoup(+Joueur, +Val1, +Val2, +Coup1, +Coup2, -MeilleureValeur, -MeilleurCoup).
%
% Choisit la meilleure valeur pour le joueur s�lectionn�. Le joueur x va chercher � 
% jouer le coup avec la plus haute valeur tandis que le joueur o va chercher � jouer 
% le coup avec la plus faible valeur. Le coup associ� � MeilleureValeur est unifi� 
% dans MeilleurCoup.
%
% Si +Val2 vaut -10000 on n'a actuellement aucun candidat au meilleur coup (premi�re 
% it�ration) et on prend donc forc�ment le candidat propos�.  
meilleurCoup(_, Val1, -10000, Coup1, _, Val1, Coup1).
%meilleurCoup(x, Val1, Val2, Coup1, _, Val1, Coup1) :- Val1 > Val2.
%meilleurCoup(x, Val1, Val2, _, Coup2, Val2, Coup2) :- Val1 < Val2 + 1.
%meilleurCoup(o, Val1, Val2, Coup1, _, Val1, Coup1) :- Val1 < Val2.
%meilleurCoup(o, Val1, Val2, _, Coup2, Val2, Coup2) :- Val1 > Val2 - 1.
meilleurCoup(o, Val1, Val2, Coup1, _, Val1, Coup1) :- Val1 > Val2.
meilleurCoup(o, Val1, Val2, _, Coup2, Val2, Coup2) :- Val1 < Val2 + 1.
meilleurCoup(x, Val1, Val2, Coup1, _, Val1, Coup1) :- Val1 < Val2.
meilleurCoup(x, Val1, Val2, _, Coup2, Val2, Coup2) :- Val1 > Val2 - 1.

% Appel : minimax(+Grille, +Profondeur, -Coup).
%
% Applique l'algorithme du minimax pour le joueur � ordinateur � (jouant avec les x)
% sur Grille pour une profondeur de recherche Profondeur. Voir minimax/5.
minimax(Grille, Profondeur, Coup) :- minimax(x, Grille, Profondeur, _, Coup).

% Appel : minimax(+Joueur, +Grille, +Profondeur, -MeilleureValeur, -MeilleurCoup).
%
% Gr�ce � l'algorithme du minimax, cherche � maximiser MeilleureValeur pour un Joueur
% sur la Grille avec une profondeur de l'arbre des coups Profondeur. Le meilleur coup 
% est unifi� dans MeilleurCoup. Voir minimax/8.
minimax(Joueur, Grille, Profondeur, MeilleureValeur, MeilleurCoup) :- 
    Profondeur > 0,
    NouvelleProfondeur is Profondeur - 1,
    findall(Coup, coup(Grille, Coup), Coups),
    minimax(Joueur, Grille, NouvelleProfondeur, Coups, -10000, _, MeilleureValeur, MeilleurCoup).
minimax(_, Grille, 0, Valeur, _) :- evaluer(Grille, Valeur).

% Appel : minimax(+Joueur, +Grille, +Profondeur, +Coups, +ValeurLocale, +CoupLocal, -MeilleureValeur, -MeilleurCoup).
%
% Parcourt la liste des Coups du joueur Joueur sur la grille Grille � une profondeur 
% de l'arbre des coups Profondeur. Recherche la valeur optimale pour le joueur et l'unifie 
% dans ValeurLocale � c�t� du coup associ� CoupLocal. ValeurLocale et CoupLocal contiennent 
% � tout instant le coup le plus favorable � la profondeur actuelle pour le joueur.
%
% Une fois tous les coups visit�s, les optimums locaux deviennt les optimums globaux et sont 
% unifi�s dans MeilleureValeur et MeilleurCoup. 
minimax(Joueur, Grille, Profondeur, [Coup|Coups], ValeurLocale, CoupLocal, MeilleureValeur, MeilleurCoup) :-
    coup(Joueur, Grille, Coup, NouvelleGrille),
    adversaire(Joueur, Adversaire),
    minimax(Adversaire, NouvelleGrille, Profondeur, Valeur, _),
    meilleurCoup(Adversaire, Valeur, ValeurLocale, Coup, CoupLocal, NouvelleValeur, NouveauCoup),
    minimax(Joueur, Grille, Profondeur, Coups, NouvelleValeur, NouveauCoup, MeilleureValeur, MeilleurCoup).
minimax(_, _, _, [], MeilleureValeur, MeilleurCoup, MeilleureValeur, MeilleurCoup).