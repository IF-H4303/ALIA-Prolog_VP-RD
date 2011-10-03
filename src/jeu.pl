% Grille : 6 lignes et 7 colonnes

%dynamic grille/1

initialiser :- 
    retractall(sauverGrille(_)),
    assert(sauverGrille([[_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _]])).

coup(Joueur, [Colonne, _, _, _, _, _, _], 1) :- coup(Joueur, Colonne).
coup(Joueur, [_, Colonne, _, _, _, _, _], 2) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, Colonne, _, _, _, _], 3) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, Colonne, _, _, _], 4) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, _, Colonne, _, _], 5) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, _, _, Colonne, _], 6) :- coup(Joueur, Colonne).
coup(Joueur, [_, _, _, _, _, _, Colonne], 7) :- coup(Joueur, Colonne).

coup(Joueur, [X|L]) :- var(X), X = Joueur.
coup(Joueur, [X|L]) :- nonvar(X), coup(Joueur, L).

jouer(Joueur, Colonne) :- 
    retract(sauverGrille(Grille)), 
    coup(Joueur, Grille, Colonne), 
    assert(sauverGrille(Grille)).