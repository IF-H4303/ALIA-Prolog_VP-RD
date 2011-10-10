% Affiche la grille dans la console.
afficherGrille :-
    grille(Grille),
    findall(Ligne, extraireLigne(Grille, _, Ligne), Lignes),
    reverse(Lignes, LignesInversees), % Les cases du bas sont en tête de tableau.
    afficherLignes(LignesInversees).

afficherLignes([L|R]) :- write('    '), afficherLigne(L), afficherLignes(R).
afficherLignes([]).

afficherLigne([L|R]) :- afficherSymbole(L), write(' '), afficherLigne(R).
afficherLigne([]) :- nl.

afficherSymbole(vide) :- write('-').
afficherSymbole(o) :- write('o').
afficherSymbole(x) :- write('x').

% .
j(NumeroColonne) :- jouer(o, NumeroColonne), afficherGrille, !.
o :- grille(G), minmax(G, 2, Coup), jouer(x, Coup), afficherGrille, !.
