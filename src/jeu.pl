% Appel : coup(+Joueur, +Grille, +Colonne).
% Extrait de Grille la colonne de num�ro Colonne. Appelle ensuite coup/2 
% pour modifier cette colonne et y placer le symbole Joueur au premier 
% indice possible.
coup(Joueur, Grille, NumeroColonne) :-
    between(1, 7, NumeroColonne),
    extraireColonne(Grille, NumeroColonne, Colonne),
    coup(Joueur, Colonne).
coup(_, _, NumeroColonne) :- not(between(1, 7, NumeroColonne)), fail.

% Appel : jouer(+Joueur, +Colonne).
% Aucune preuve n'est possible si la colonne choisie est d�j� pleine.
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

lancer :-
    consult('/Users/vincent/workspace/Projet Prolog/src/grille.pl'),
    consult('/Users/vincent/workspace/Projet Prolog/src/ia.pl'),
    consult('/Users/vincent/workspace/Projet Prolog/src/ui.pl'),
    initialiser.