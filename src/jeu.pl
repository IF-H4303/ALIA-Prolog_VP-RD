% Appel : coup(+Joueur, +Grille, +Colonne).
% Extrait de Grille la colonne de num�ro Colonne. Appelle ensuite coup/2 
% pour modifier cette colonne et y placer le symbole Joueur au premier 
% indice possible.
coup(Joueur, [Colonne, _, _, _, _, _, _], 1) :- coup(Joueur, Colonne).
coup(Joueur, [_, Colonne, _, _, _, _, _], 2) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, Colonne, _, _, _, _], 3) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, Colonne, _, _, _], 4) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, _, Colonne, _, _], 5) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, _, _, Colonne, _], 6) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, _, _, _, Colonne], 7) :- coup(Joueur, Colonne).

% Appel : jouer(+Joueur, +Colonne).
coup(Joueur, [X|_]) :- var(X), X = Joueur.
coup(Joueur, [X|L]) :- nonvar(X), coup(Joueur, L).
coup(_, []) :- fail.

% Appel : jouer(+Joueur, +Colonne).
% Joueur est un symbole repr�sentant le joueur qui joue.
% Colonne est le num�ro de la colonne o� d�poser la pi�ce.
jouer(Joueur, Colonne) :- 
    retract(grille(Grille)), 
    coup(Joueur, Grille, Colonne), 
    assert(grille(Grille)).