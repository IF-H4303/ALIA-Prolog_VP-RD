% Appel : victoireJoueurColonne(+Joueur, +Nombre, +Colonne).
% Une preuve existe si une suite de 4 symboles consécutifs de Joueur 
% est trouvée dans Colonne. 
victoireJoueurColonne(_, Nombre, _) :- Nombre = 4.
victoireJoueurColonne(Joueur, Nombre, [X|L]) :-
    Joueur = X,
    NouveauNombre is Nombre + 1,
    victoireJoueurColonne(Joueur, NouveauNombre, L).
victoireJoueurColonne(Joueur, _, [X|L]) :-
    not(Joueur = X),
    victoireJoueurColonne(Joueur, 0, L). 

%extraireLigne([[X1|L1], [X2|L2], [X3|L3], [X4|L4], [X5|L5], [X6|L6]], Ligne, Resultat).

victoireColonne(Grille) :- victoireJoueurColonne(x, 0, Grille).
victoireColonne(Grille) :- victoireJoueurColonne(o, 0, Grille).