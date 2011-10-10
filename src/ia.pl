% Appel : adversaire(+Joueur, -Adversaire).
%
% Permet d'effectuer le changement de joueur. L'adversaire de Joueur est 
% unifi� dans Adversaire.
adversaire(o, x).
adversaire(x, o).

% Appel : max(+Joueur, +Val1, +Val2, +Coup1, +Coup2, -MeilleureValeur, -MeilleurCoup).
%
% Choisit la meilleure valeur pour le joueur s�lectionn�. Le joueur x va chercher � 
% jouer le coup avec la plus haute valeur tandis que le joueur o va chercher � jouer 
% le coup avec la plus faible valeur. Le coup associ� � MeilleureValeur est unifi� 
% dans MeilleurCoup.
% Si +Val2 vaut -10000 on n'a actuellement aucun candidat au meilleur coup (premi�re 
% it�ration) et on prend donc forc�ment le candidat propos�.  
max(_, Val1, -10000, Coup1, _, Val1, Coup1).
max(x, Val1, Val2, Coup1, _, Val1, Coup1) :- Val1 > Val2.
max(x, Val1, Val2, _, Coup2, Val2, Coup2) :- Val1 < Val2 + 1.
max(o, Val1, Val2, Coup1, _, Val1, Coup1) :- Val1 < Val2.
max(o, Val1, Val2, _, Coup2, Val2, Coup2) :- Val1 > Val2 - 1.

minmax(Grille, Profondeur, Coup) :- minmax(x, Grille, Profondeur, _, Coup).

minmax(Joueur, Grille, Profondeur, MeilleureValeur, MeilleurCoup) :- 
    Profondeur > 0,
    NouvelleProfondeur is Profondeur - 1,
    findall(Coup, coup(Grille, Coup), Coups),
    minmax(Joueur, Grille, NouvelleProfondeur, Coups, -10000, _, MeilleureValeur, MeilleurCoup).

minmax(_, Grille, 0, Valeur, _) :- evaluer(Grille, Valeur).

minmax(Joueur, Grille, Profondeur, [Coup|Coups], ValeurLocale, CoupLocal, MeilleureValeur, MeilleurCoup) :-
    coup(Joueur, Grille, Coup, NouvelleGrille),
    adversaire(Joueur, Adversaire),
    minmax(Adversaire, NouvelleGrille, Profondeur, Valeur, _),
    max(Adversaire, Valeur, ValeurLocale, Coup, CoupLocal, NouvelleValeur, NouveauCoup),
    minmax(Joueur, Grille, Profondeur, Coups, NouvelleValeur, NouveauCoup, MeilleureValeur, MeilleurCoup).
    
minmax(_, _, _, [], MeilleureValeur, MeilleurCoup, MeilleureValeur, MeilleurCoup).