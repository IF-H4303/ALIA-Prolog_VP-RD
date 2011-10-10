% D�finition : un coup est repr�sent� par un num�ro de colonne.
% Le pion va automatiquement s'ajouter dans la premi�re place disponible.

% Appel : coup(+Joueur, +Grille, +NumeroColonne, -NouvelleGrille).
%
% Joue le coup du Joueur sur la Grille dans la colonne NumeroColonne 
% et place le r�sultat dans NouvelleGrille. 
coup(Joueur, Grille, NumeroColonne, NouvelleGrille) :- copierGrille(Joueur, Grille, 1, NumeroColonne, NouvelleGrille).

% Appel : copierGrille(+Joueur, +Grille, +Nombre, +NumeroColonne, -NouvelleGrille).
%
% Copie la Grille en y ins�rant le coup du Joueur dans la colonne NumeroColonne. 
% Le r�sultat est unifi� dans une NouvelleGrille. La colonne en cours de parcours 
% est retenue dans Nombre.
copierGrille(Joueur, [X|R], Nombre, NumeroColonne, [X|L]) :-
    Nombre \== NumeroColonne,
    NouveauNombre is Nombre + 1,
    copierGrille(Joueur, R, NouveauNombre, NumeroColonne, L).
copierGrille(Joueur, [X|R], Nombre, Nombre, [C|R]) :- copierColonne(Joueur, X, C).

% Appel : copierColonne(+Joueur, +Colonne, -NouvelleColonne).
%
% Copie la Colonne en y ins�rant le coup du Joueur � la premi�re case vide. 
% Le r�sultat est unifi� dans une NouvelleColonne.
copierColonne(Joueur, [vide|R], [Joueur|R]).
copierColonne(Joueur, [x|R], [x|L]) :- copierColonne(Joueur, R, L).
copierColonne(Joueur, [o|R], [o|L]) :- copierColonne(Joueur, R, L).

% Appel : coup(+Grille, ?NumeroColonne).
%
% Une preuve existe si le coup consistant � ajouter une pi�ce sur 
% la Grille dans la colonne NumeroColonne est valide (i.e. NumeroColonne 
% est valide et il y a encore de la place dans la colonne). Peut servir  
% � g�n�rer la liste des coups valides. Voir coup/2.  
coup(Grille, NumeroColonne) :-
    between(1, 7, NumeroColonne),
    extraireColonne(Grille, NumeroColonne, Colonne),
    coup(Colonne).

% Appel : coup(+Colonne).
%
% Une preuve existe si la Colonne contient au moins une case a videe.
% Dans ce cas, un nouveau coup est possible dans cette colonne. 
coup([X|_]) :- X == vide.
coup([X|L]) :- X \== vide, coup(L).
coup([]) :- fail.  

% Appel : jouer(+Joueur, +NumeroColonne).
%
% Joue le coup du Joueur sur la grille dans la colonne NumeroColonne.
jouer(Joueur, NumeroColonne) :- 
    between(1, 7, NumeroColonne),
    retract(grille(Grille)), 
    coup(Joueur, Grille, NumeroColonne, NouvelleGrille), 
    assert(grille(NouvelleGrille)).
