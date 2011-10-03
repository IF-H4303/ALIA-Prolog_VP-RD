% Appel : victoireJoueurColonne(+Joueur, +Nombre, +Colonne).
% Une preuve existe si une suite de 4 symboles cons�cutifs de Joueur 
% est trouv�e dans Colonne. 
victoireJoueurColonne(_, Nombre, _) :- Nombre = 4.
victoireJoueurColonne(Joueur, Nombre, [X|L]) :-
    Joueur = X,
    NouveauNombre is Nombre + 1,
    victoireJoueurColonne(Joueur, NouveauNombre, L).
victoireJoueurColonne(Joueur, _, [X|L]) :-
    not(Joueur = X),
    victoireJoueurColonne(Joueur, 0, L). 

victoireColonne(Grille) :- victoireJoueurColonne(x, 0, Grille).
victoireColonne(Grille) :- victoireJoueurColonne(o, 0, Grille).