% Appel : victoireJoueurColonne(+Joueur, +Colonne).
% Une preuve existe si une suite de 4 symboles consécutifs de Joueur 
% est trouvée dans Colonne.
victoireJoueurColonne(Joueur, Colonne) :- victoireJoueurColonne(Joueur, 0, Colonne). 
victoireJoueurColonne(_, Nombre, _) :- Nombre = 4.
victoireJoueurColonne(Joueur, Nombre, [X|L]) :-
    Joueur = X,
    NouveauNombre is Nombre + 1,
    victoireJoueurColonne(Joueur, NouveauNombre, L).
victoireJoueurColonne(Joueur, _, [X|L]) :-
    not(Joueur = X),
    victoireJoueurColonne(Joueur, 0, L).

% Appel : victoireJoueurLigne(+Joueur, +Ligne).
% Une preuve existe si une suite de 4 symboles consécutifs de Joueur 
% est trouvée dans Ligne.
victoireJoueurLigne(Joueur, Ligne) :- victoireJoueurColonne(Joueur, 0, Ligne).

% Appel : victoireJoueur(+Joueur, +Grille).
% Une preuve existe si le joueur Joueur a gagné sur Grille.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 1, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 2, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 3, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 4, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 5, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 6, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 7, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 1, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 2, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 3, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 4, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 5, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 6, Ligne), victoireJoueurLigne(Joueur, Ligne).

% Appel : victoire(+Grille).
% Une preuve existe si un des deux joueurs (x ou o) a gagné.
victoire(Grille) :- victoire(x, Grille).
victoire(Grille) :- victoire(o, Grille).