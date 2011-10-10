% Définition : un coup est représenté par un numéro de colonne.
% Le pion va automatiquement s'ajouter dans la première place disponible.

% Appel : coup(+Joueur, +Grille, +NumeroColonne, -NouvelleGrille).
%
% Joue le coup du Joueur sur la Grille dans la colonne NumeroColonne 
% et place le résultat dans NouvelleGrille. 
coup(Joueur, Grille, NumeroColonne, NouvelleGrille) :- copierGrille(Joueur, Grille, 1, NumeroColonne, NouvelleGrille).

copierGrille(Joueur, [X|R], Nombre, Colonne, [X|L]) :-
    Nombre \== Colonne,
    NouveauNombre is Nombre + 1,
    copierGrille(Joueur, R, NouveauNombre, Colonne, L).

copierGrille(Joueur, [X|R], Nombre, Nombre, [C|R]) :- copierColonne(Joueur, X, C).

copierColonne(Joueur, [vide|R], [Joueur|R]).
copierColonne(Joueur, [x|R], [x|L]) :- copierColonne(Joueur, R, L).
copierColonne(Joueur, [o|R], [o|L]) :- copierColonne(Joueur, R, L).

% Appel : coup(+Grille, +NumeroColonne)
% Une preuve existe si le coup consistant à ajouter une pièce sur 
% la Grille dans la colonne NumeroColonne est valide (i.e. NumeroColonne 
% est valide et il y a encore de la place dans la colonne).
%
% Appel : coup(+Grille, -NumeroColonne)
% Génère les coups possible sur la Grille dans NumeroColonne.  
coup(Grille, NumeroColonne) :-
    between(1, 7, NumeroColonne),
    extraireColonne(Grille, NumeroColonne, Colonne),
    coup(Colonne).

coup([X|_]) :- X == vide.
coup([X|L]) :- X \== vide, coup(L).
coup([]) :- fail.  

% Appel : jouer(+Joueur, +NumeroColonne).
% Joue le coup du Joueur sur la grille dans la colonne NumeroColonne.
jouer(Joueur, NumeroColonne) :- 
    between(1, 7, NumeroColonne),
    retract(grille(Grille)), 
    coup(Joueur, Grille, NumeroColonne, NouvelleGrille), 
    assert(grille(NouvelleGrille)).
