% Appel : coup(+Joueur, +Grille, +Colonne).
% Extrait de Grille la colonne de numéro Colonne. Appelle ensuite coup/2 
% pour modifier cette colonne et y placer le symbole Joueur au premier 
% indice possible.
coup(Joueur, Grille, NumeroColonne) :- extraireColonne(Grille, NumeroColonne, Colonne), coup(Joueur, Colonne).

% Appel : jouer(+Joueur, +Colonne).
coup(Joueur, [X|_]) :- var(X), X = Joueur.
coup(Joueur, [X|L]) :- nonvar(X), coup(Joueur, L).
coup(_, []) :- fail.

% Appel : jouer(+Joueur, +Colonne).
% Joueur est un symbole représentant le joueur qui joue.
% Colonne est le numéro de la colonne où déposer la pièce.
jouer(Joueur, Colonne) :- 
    retract(grille(Grille)), 
    coup(Joueur, Grille, Colonne), 
    assert(grille(Grille)).